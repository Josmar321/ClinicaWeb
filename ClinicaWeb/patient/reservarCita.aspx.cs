using ClinicaWeb.ServiciosWS;
using SendGrid;
using SendGrid.Helpers.Mail;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Net.WebRequestMethods;
using SW = ClinicaWeb.ServiciosWS;

namespace ClinicaWeb.patient
{
    public partial class reservarCita : System.Web.UI.Page
    {
        private SW.MedicoWSClient medicoWS = new SW.MedicoWSClient();
        private SW.DisponibilidadWSClient disponibilidadWS = new SW.DisponibilidadWSClient();
        private SW.CitaMedicaWSClient citaWS = new SW.CitaMedicaWSClient();
        protected string filtrosQuery;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string codigoMedico = Request.QueryString["codigoMedico"];
                string fechaSeleccionada = Request.QueryString["fecha"];
                string idLocalString = Request.QueryString["idLocal"];

                if (string.IsNullOrEmpty(codigoMedico) || string.IsNullOrEmpty(fechaSeleccionada) || string.IsNullOrEmpty(idLocalString))
                {
                    Response.Redirect("agendarCita.aspx");
                    return;
                }

                lblCodigoMedico.Text = codigoMedico;

                var medico = medicoWS.obtenerMedicoPorId(codigoMedico);
                if (medico != null)
                {
                    lblNombreMedico.Text = $"{medico.nombre} {medico.primerApellido} {medico.segundoApellido}";
                    lblEspecialidad.Text = medico.especialidad?.nombre ?? "(Sin especialidad)";
                }

                if (DateTime.TryParse(fechaSeleccionada, out DateTime fecha))
                {
                    lblFecha.Text = fecha.ToString("dd/MM/yyyy");

                    string diaSemana = fecha.ToString("dddd").ToUpper();
                    switch (diaSemana)
                    {
                        case "TUESDAY": diaSemana = "MARTES"; break;
                        case "WEDNESDAY": diaSemana = "MIERCOLES"; break;
                        case "THURSDAY": diaSemana = "JUEVES"; break;
                        case "FRIDAY": diaSemana = "VIERNES"; break;
                        case "SATURDAY": diaSemana = "SABADO"; break;
                        case "SUNDAY": diaSemana = "DOMINGO"; break;
                        case "MONDAY": diaSemana = "LUNES"; break;
                        case "MIÉRCOLES": diaSemana = "MIERCOLES"; break;
                        case "SÁBADO": diaSemana = "SABADO"; break;
                    }

                    var disponibilidades = disponibilidadWS.obtenerDisponibilidadXMedico(codigoMedico) ?? new SW.disponibilidad[0];
                    var disponiblesDia = disponibilidades
                        .Where(d => d.dia.ToString() == diaSemana && d.activo)
                        .ToList();

                    var citas = citaWS.listarCitasMedicas();
                    var citasDia = citas
                        .Where(c => c.medico.codigoMedico == codigoMedico && c.fecha.Date == fecha.Date && c.activo)
                        .ToList();
                    var horasOcupadas = new HashSet<string>(
                        citasDia.Select(c => c.hora.ToString("HH:mm"))
                    );
                    lblSinDisponibilidad.Visible = disponiblesDia.Count == 0;

                    var horaSeleccionada = ViewState["horaSeleccionada"]?.ToString();
                    var intervalos = new List<dynamic>();
                    foreach (var disp in disponiblesDia)
                    {
                        DateTime inicio = disp.horaInicio;
                        DateTime fin = disp.horaFin;

                        while (inicio < fin)
                        {
                            string horaTexto = inicio.ToString("HH:mm");
                            bool esSeleccionada = (horaTexto == horaSeleccionada);

                            //intervalos.Add(new { Text = horaTexto, Seleccionado = esSeleccionada });

                            if (!horasOcupadas.Contains(horaTexto))
                            {
                                intervalos.Add(new { Text = horaTexto, Seleccionado = esSeleccionada });
                            }
                            inicio = inicio.AddMinutes(30);
                        }
                    }
                    if (intervalos.Count() == 0)
                    {
                        Response.Write("<script>alert('¡El médico no tiene disponibilidades!'); window.location='agendarCita.aspx';</script>");

                    }
                    rptHoras.DataSource = intervalos;
                    rptHoras.DataBind();
                }

                int idLocal = int.Parse(idLocalString);

                var localWS = new SW.LocalWSClient();
                var local = localWS.obtenerLocalPorId(idLocal);
                lblLocal.Text = local != null ? local.direccion : "(Local no encontrado)";

                var consultorioWS = new SW.ConsultorioWSClient();
                var consultorios = consultorioWS.listarConsultoriosPorIdLocalYMedico(idLocal, codigoMedico)
                    .Where(c => c.activo)
                    .ToList();

                ddlConsultorio.DataSource = consultorios.Select(c => new
                {
                    idConsultorio = c.idConsultorio,
                    descripcion = $"{c.numConsultorio} - piso {c.piso}"
                }).ToList();
                ddlConsultorio.DataTextField = "descripcion";
                ddlConsultorio.DataValueField = "idConsultorio";
                ddlConsultorio.DataBind();

                ddlModalidad.SelectedValue = "PRESENCIAL";
                ActualizarPrecio();
            }
        }



        protected void ddlModalidad_SelectedIndexChanged(object sender, EventArgs e)
        {
            ActualizarPrecio();
        }

        private void ActualizarPrecio()
        {
            string modalidad = ddlModalidad.SelectedValue;
            lblPrecio.Text = modalidad == "PRESENCIAL" ? "S/. 100.00" : "S/. 80.00";
        }

        protected void SeleccionarHora_Command(object sender, CommandEventArgs e)
        {
            string horaSeleccionada = e.CommandArgument.ToString();
            ViewState["horaSeleccionada"] = horaSeleccionada;

            // Cambiar visualmente el botón
            Response.Write("<script>alert('Hora seleccionada: " + horaSeleccionada + "');</script>");
        }


        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("agendarCita.aspx?" + filtrosQuery);
        }

        protected void btnReservar_Click(object sender, EventArgs e)
        {
            var citaWS = new SW.CitaMedicaWSClient();
            // var historialWS = new SW.HistorialClinicoWSClient(); // Comentado
            var usuarioWS = new SW.UsuarioWSClient();
            var pacienteWS = new SW.PacienteWSClient();
            var consultorioWS = new SW.ConsultorioWSClient();
            var localWS = new SW.LocalWSClient();
            string codigoMedico = lblCodigoMedico.Text;
            string fechaTexto = lblFecha.Text;
            string horaTexto = hfHoraSeleccionada.Value;
            string modalidadTexto = ddlModalidad.SelectedValue;
            double precio = modalidadTexto == "PRESENCIAL" ? 100.0 : 80.0;

            // Obtener username desde la sesión
            string username = Session["Usuario"]?.ToString();
            if (string.IsNullOrEmpty(username))
            {
                Response.Redirect("../InicioSesion.aspx");
                return;
            }

            // Obtener ID de usuario usando el método correcto
            int idUsuario = usuarioWS.obtenerUsuarioPorUsername(username);
            if (idUsuario <= 0)
            {
                Response.Write("<script>alert('Error: no se encontró el ID del usuario.');</script>");
                return;
            }

            // Obtener paciente a partir del ID del usuario
            SW.paciente paciente = pacienteWS.obtenerPacienteXUser(idUsuario);
            if (paciente == null)
            {
                Response.Write("<script>alert('Error: no se encontró el paciente.');</script>");
                return;
            }

            string codigoPaciente = paciente.codigoPaciente;
            int idConsultorio = int.Parse(ddlConsultorio.SelectedValue);

            // ======= HISTORIAL CLÍNICO OMITIDO TEMPORALMENTE =======
            /*
            SW.historialClinico historial = historialWS.obtenerHistorialConCitas(codigoPaciente);
            bool seDebeCrearHistorial = historial == null;

            if (seDebeCrearHistorial)
            {
                historial = new SW.historialClinico
                {
                    fechaCreacion = DateTime.Today,
                    fechaCreacionSpecified = true,
                    obsGenerales = "Historial creado automáticamente",
                    paciente = new SW.paciente { codigoPaciente = codigoPaciente }
                };

                historialWS.insertarHistorialClinico(historial);
            }
            */
            // =======================================================

            // Paso 2: Crear cita médica
            DateTime fechaDate = DateTime.Parse(fechaTexto);
            DateTime horaDate = DateTime.Parse(horaTexto);

            var cita = new SW.citaMedica
            {
                fecha = fechaDate,
                fechaSpecified = true,
                hora = horaDate,
                horaSpecified = true,
                precio = precio,
                estado = (SW.estadoCita)Enum.Parse(typeof(SW.estadoCita), "PROGRAMADA"),
                estadoSpecified = true,
                modalidad = (SW.modalidad)Enum.Parse(typeof(SW.modalidad), modalidadTexto),
                modalidadSpecified = true,
                paciente = new SW.paciente { codigoPaciente = codigoPaciente },
                medico = new SW.medico { codigoMedico = codigoMedico },
                consultorio = new SW.consultorio { idConsultorio = idConsultorio },
                historialClinico = null, // No se está asignando historial clínico
                activo = true
            };
            var medicocorreo = medicoWS.obtenerMedicoPorId(codigoMedico);
            var consultoriocorreo = consultorioWS.obtenerConsultorioPorId(idConsultorio);
            var localcorreo = localWS.obtenerLocalPorId(consultoriocorreo.local.idLocal);
            citaWS.insertarCitaMedica(cita);
            Task.Run(async () =>
            {
                await EnviarCorreoAPacienteAsync(paciente.email, paciente.nombre,
                    fechaDate.ToString("dd/MM/yyyy"), horaDate.ToString("HH:mm"), modalidadTexto, medicocorreo.nombre, medicocorreo.primerApellido,
                    consultoriocorreo.numConsultorio.ToString(), localcorreo.direccion);
            });
            Task.Run(async () =>
            {
                await EnviarCorreoAMedicoAsync(medicocorreo.email, paciente.nombre,
                    fechaDate.ToString("dd/MM/yyyy"), horaDate.ToString("HH:mm"), modalidadTexto, medicocorreo.nombre, paciente.primerApellido,
                    consultoriocorreo.numConsultorio.ToString(), localcorreo.direccion);
            });
            // Confirmación
            ScriptManager.RegisterStartupScript(this, GetType(), "citaRegistrada", "$('#modalCitaRegistrada').modal('show');", true);
        }

        private async Task EnviarCorreoAPacienteAsync(string correoDestino, string nombrePaciente, string fecha, string hora, string modalidad,
            string nombreMedico, string apellido, string consultorio, string local)
        {

            var apiKey = "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";
            var client = new SendGridClient(apiKey);
            var from = new EmailAddress("nelvier200@gmail.com", "NEOSALUD");
            var subject = "Confirmación de Cita Médica - NEOSALUD";
            var to = new EmailAddress(correoDestino, nombrePaciente);

            var plainTextContent = $"Estimado(a) {nombrePaciente}, su cita médica fue registrada exitosamente.\n\n" +
                                   $"Médico: {nombreMedico} + {apellido}\n" +
                                   $"Fecha: {fecha}\n" +
                                   $"Hora: {hora}\n" +
                                   $"Modalidad: {modalidad}\n";

            if (modalidad.ToUpper() == "PRESENCIAL")
            {
                plainTextContent += $"Local: {local}\nConsultorio: {consultorio}";
            }
            else if (modalidad.ToUpper() == "VIRTUAL")
            {
                plainTextContent += $"Link de Zoom: https://zoom.com";
            }

            var htmlContent = $@"
                    <div style='font-family: Arial, sans-serif; max-width: 600px; margin: auto; border: 1px solid #e0e0e0; border-radius: 8px; padding: 20px; background-color: #f9f9f9;'>
                        <h2 style='color: #2c3e50;'>📅 Confirmación de Cita Médica</h2>
                        <p>Estimado(a), <strong>{nombrePaciente}</strong>.</p>
                        <p>Le informamos que su registro de cita médica se realizó exitosamente, con la siguiente información:</p>

                        <div style='background-color: #ffffff; padding: 15px; border: 1px solid #dcdcdc; border-radius: 6px; margin-top: 20px; line-height: 1.6;'>
                        <p><strong>👨‍⚕️ Médico:</strong> {nombreMedico} {apellido}</p>
                        <p><strong>📅 Fecha:</strong> {fecha}</p>
                        <p><strong>🕒 Hora:</strong> {hora}</p>
                        <p><strong>🔁 Modalidad:</strong> <span style='color: {(modalidad.ToUpper() == "PRESENCIAL" ? "green" : "#d32f2f")};'>{modalidad}</span></p>";

            if (modalidad.ToUpper() == "PRESENCIAL")
            {
                htmlContent += $@"
                        <p><strong>📍 Local:</strong> {local}</p>
                        <p><strong>🚪 Consultorio:</strong> {consultorio}</p>";
            }
            else if (modalidad.ToUpper() == "VIRTUAL")
            {
                htmlContent += $@"
                    <p><strong>🔗 Link de Zoom:</strong> <a href='https://zoom.com' target='_blank' style='color: #1976d2;'>https://zoom.com</a></p>";
            }

            htmlContent += @"
                    </div>
                    <p style='margin-top: 30px;'>Atentamente,</p>
                    <p><strong>NeoSalud</strong></p>
                    <p style='font-size: 0.9em; color: #888;'>Este es un mensaje automático, por favor no responder.</p>
                </div>";

            var msg = MailHelper.CreateSingleEmail(from, to, subject, plainTextContent, htmlContent);
            var response = await client.SendEmailAsync(msg);

            Console.WriteLine($"Resultado: {response.StatusCode}");
        }
        private async Task EnviarCorreoAMedicoAsync(string correoDestino, string nombrePaciente, string fecha, string hora, string modalidad,
                   string nombreMedico, string apellido, string consultorio, string local)
        {

            var apiKey = "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";
            var client = new SendGridClient(apiKey);
            var from = new EmailAddress("nelvier200@gmail.com", "NEOSALUD");
            var subject = "Confirmación de Cita Médica - NEOSALUD";
            var to = new EmailAddress(correoDestino, nombrePaciente);

            var plainTextContent = $"Estimado(a) {nombreMedico}, su cita médica fue registrada exitosamente.\n\n" +
                                   $"Paciente: {nombrePaciente} + {apellido}\n" +
                                   $"Fecha: {fecha}\n" +
                                   $"Hora: {hora}\n" +
                                   $"Modalidad: {modalidad}\n";

            if (modalidad.ToUpper() == "PRESENCIAL")
            {
                plainTextContent += $"Local: {local}\nConsultorio: {consultorio}";
            }
            else if (modalidad.ToUpper() == "VIRTUAL")
            {
                plainTextContent += $"Link de Zoom: https://zoom.com";
            }

            var htmlContent = $@"
                    <div style='font-family: Arial, sans-serif; max-width: 600px; margin: auto; border: 1px solid #e0e0e0; border-radius: 8px; padding: 20px; background-color: #f9f9f9;'>
                        <h2 style='color: #2c3e50;'>📅 Confirmación de Cita Médica</h2>
                        <p>Estimado(a), <strong>{nombreMedico}</strong>.</p>
                        <p>Le informamos que se acaba de registrar una cita médica, con la siguiente información:</p>

                        <div style='background-color: #ffffff; padding: 15px; border: 1px solid #dcdcdc; border-radius: 6px; margin-top: 20px; line-height: 1.6;'>
                        <p><strong>👨‍⚕️ Paciente:</strong> {nombrePaciente} {apellido}</p>
                        <p><strong>📅 Fecha:</strong> {fecha}</p>
                        <p><strong>🕒 Hora:</strong> {hora}</p>
                        <p><strong>🔁 Modalidad:</strong> <span style='color: {(modalidad.ToUpper() == "PRESENCIAL" ? "green" : "#d32f2f")};'>{modalidad}</span></p>";

            if (modalidad.ToUpper() == "PRESENCIAL")
            {
                htmlContent += $@"
                        <p><strong>📍 Local:</strong> {local}</p>
                        <p><strong>🚪 Consultorio:</strong> {consultorio}</p>";
            }
            else if (modalidad.ToUpper() == "VIRTUAL")
            {
                htmlContent += $@"
                    <p><strong>🔗 Link de Zoom:</strong> <a href='https://zoom.com' target='_blank' style='color: #1976d2;'>https://zoom.com</a></p>";
            }

            htmlContent += @"
                    </div>
                    <p style='margin-top: 30px;'>Atentamente,</p>
                    <p><strong>NeoSalud</strong></p>
                    <p style='font-size: 0.9em; color: #888;'>Este es un mensaje automático, por favor no responder.</p>
                </div>";

            var msg = MailHelper.CreateSingleEmail(from, to, subject, plainTextContent, htmlContent);
            var response = await client.SendEmailAsync(msg);

            Console.WriteLine($"Resultado: {response.StatusCode}");
        }
    }

}