using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ClinicaWeb.ServiciosWS;

namespace ClinicaWeb.patient
{
    public partial class citas : System.Web.UI.Page
    {
        private CitaMedicaWSClient citaMedicaWS = new CitaMedicaWSClient();
        private ConsultorioWSClient consultorioWS = new ConsultorioWSClient();
        private LocalWSClient localWS = new LocalWSClient();
        private UsuarioWSClient usuarioWS = new UsuarioWSClient();
        private PacienteWSClient pacienteWS = new PacienteWSClient();
        private MedicoWSClient medicoWS = new MedicoWSClient();
        private DisponibilidadWSClient disponibilidadWS = new DisponibilidadWSClient();
        private CitaMedicaWSClient citaWS = new CitaMedicaWSClient();

        private string SelectedEstado
        {
            get => ViewState["SelectedEstado"] as string ?? "TODAS";
            set => ViewState["SelectedEstado"] = value;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SelectedEstado = "TODAS";
                ddlFiltroEstado.SelectedValue = SelectedEstado;
                cargarCitasFiltradas();
            }
        }


        private void cargarCitasFiltradas()
        {
            string username = Session["Usuario"]?.ToString();
            if (string.IsNullOrEmpty(username)) return;

            int idUsuario = usuarioWS.obtenerUsuarioPorUsername(username);
            if (idUsuario <= 0) return;

            var paciente = pacienteWS.obtenerPacienteXUser(idUsuario);
            if (paciente == null) return;

            string codigoPaciente = paciente.codigoPaciente;
            var citas = citaMedicaWS.listarCitasPorPaciente(codigoPaciente)?.ToList() ?? new List<citaMedica>();

            foreach (var cita in citas)
            {
                // Consultorio y Local
                if (cita.consultorio != null && cita.consultorio.idConsultorio > 0)
                {
                    var consultorioCompleto = consultorioWS.obtenerConsultorioPorId(cita.consultorio.idConsultorio);
                    cita.consultorio.numConsultorio = consultorioCompleto.numConsultorio;
                    cita.consultorio.piso = consultorioCompleto.piso;

                    if (consultorioCompleto.local != null && consultorioCompleto.local.idLocal > 0)
                    {
                        var localCompleto = localWS.obtenerLocalPorId(consultorioCompleto.local.idLocal);
                        cita.consultorio.local = localCompleto;
                    }
                }

                // Datos del médico
                if (cita.medico != null && !string.IsNullOrEmpty(cita.medico.codigoMedico))
                {
                    var medicoCompleto = medicoWS.obtenerMedicoPorId(cita.medico.codigoMedico);
                    if (medicoCompleto != null)
                    {
                        cita.medico.nombre = medicoCompleto.nombre;
                        cita.medico.primerApellido = medicoCompleto.primerApellido;
                        cita.medico.segundoApellido = medicoCompleto.segundoApellido;
                        cita.medico.especialidad = medicoCompleto.especialidad;
                    }
                }
            }

            ViewState["CITAS"] = citas;

            List<citaMedica> citasFiltradas;

            if (SelectedEstado == "TODAS")
            {
                citasFiltradas = citas;
            }
            else
            {
                citasFiltradas = citas
                    .Where(c => c.estado.ToString().Equals(SelectedEstado, StringComparison.OrdinalIgnoreCase))
                    .ToList();
            }

            rptCitas.DataSource = citasFiltradas;
            rptCitas.DataBind();
        }



        protected void rptCitas_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Cancelar")
            {
                int idCita;
                if (int.TryParse(e.CommandArgument.ToString(), out idCita))
                {
                    citaMedicaWS.cancelarCitaMedica(idCita);
                    cargarCitasFiltradas();
                }
            }
        }

        protected void btnModificar_Command(object sender, CommandEventArgs e)
        {
            int idCita = int.Parse(e.CommandArgument.ToString());
            hfIdCitaModificar.Value = idCita.ToString();

            try
            {
                var cita = citaMedicaWS.obtenerCitaMedicaPorId(idCita);
                if (cita != null)
                {
                    ddlModalidad.SelectedValue = cita.modalidad.ToString();
                    cargarHorasDisponibles(cita.medico.codigoMedico, cita.fecha);
                    ddlHoraNueva.SelectedValue = cita.hora.ToString("HH:mm");

                    // Mostrar el modal con una clave única por cita
                    string scriptKey = "abrirModal_" + idCita;
                    ScriptManager.RegisterStartupScript(this, GetType(), scriptKey, "$('#modalModificar').modal('show');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "error", "alert('No se encontró la cita seleccionada.');", true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "error", $"alert('Error al obtener la cita: {ex.Message}');", true);
            }
        }



        protected void btnGuardarCambios_Click(object sender, EventArgs e)
        {
            int idCita = int.Parse(hfIdCitaModificar.Value);

            // Suponiendo que ddlHoraNueva tiene valores como "10:30"
            string horaTexto = ddlHoraNueva.SelectedValue;  // ejemplo: "10:30"
            DateTime horaDate = DateTime.Parse(horaTexto);  // genera: DateTime con fecha + hora

            var nuevaCita = new citaMedica
            {
                idCita = idCita,
                hora = horaDate,
                horaSpecified = true,
                modalidad = (modalidad)Enum.Parse(typeof(modalidad), ddlModalidad.SelectedValue),
                modalidadSpecified = true,
                activo = true
            };



            try
            {
                citaMedicaWS.modificarCitaMedicaPaciente(nuevaCita);

                // Confirmación al usuario
                ScriptManager.RegisterStartupScript(this, GetType(), "modificado", "alert('Cita modificada exitosamente.');", true);

                // Refrescar citas y cerrar modal
                cargarCitasFiltradas();
                ScriptManager.RegisterStartupScript(this, GetType(), "cerrarModal", "$('#modalModificar').modal('hide');", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "error", $"alert('Error al modificar la cita: {ex.Message}');", true);
            }
        }


        private void cargarHorasDisponibles(string codigoMedico, DateTime fecha)
        {
            ddlHoraNueva.Items.Clear();

            string diaSemana = fecha.ToString("dddd").ToUpper();
            switch (diaSemana)
            {
                case "MONDAY": diaSemana = "LUNES"; break;
                case "TUESDAY": diaSemana = "MARTES"; break;
                case "WEDNESDAY": diaSemana = "MIERCOLES"; break;
                case "THURSDAY": diaSemana = "JUEVES"; break;
                case "FRIDAY": diaSemana = "VIERNES"; break;
                case "SATURDAY": diaSemana = "SABADO"; break;
                case "SUNDAY": diaSemana = "DOMINGO"; break;
                case "MIÉRCOLES": diaSemana = "MIERCOLES"; break;
                case "SÁBADO": diaSemana = "SABADO"; break;
            }

            var disponibilidades = disponibilidadWS.obtenerDisponibilidadXMedico(codigoMedico) ?? new disponibilidad[0];
            var disponiblesDia = disponibilidades.Where(d => d.dia.ToString() == diaSemana).ToList();
            var citas = citaWS.listarCitasMedicas();
            var citasDia = citas
                .Where(c => c.medico.codigoMedico == codigoMedico && c.fecha.Date == fecha.Date && c.activo)
                .ToList();
            var horasOcupadas = new HashSet<string>(
                citasDia.Select(c => c.hora.ToString("HH:mm"))
            );
            foreach (var disp in disponiblesDia)
            {
                DateTime inicio = disp.horaInicio;
                DateTime fin = disp.horaFin;

                while (inicio < fin)
                {
                    string horaTexto = inicio.ToString("HH:mm");
                    if (!horasOcupadas.Contains(horaTexto))
                    {
                        ddlHoraNueva.Items.Add(new ListItem(inicio.ToString("HH:mm"), inicio.ToString("HH:mm")));
                    }
                    //ddlHoraNueva.Items.Add(new ListItem(inicio.ToString("HH:mm"), inicio.ToString("HH:mm")));
                    inicio = inicio.AddMinutes(30);
                }
            }
        }

        protected void btnConfirmarCancelacion_Click(object sender, EventArgs e)
        {
            int idCita = int.Parse(hfIdCitaCancelar.Value);
            try
            {
                citaMedicaWS.cancelarCitaMedica(idCita);
                ScriptManager.RegisterStartupScript(this, GetType(), "cancelado", "alert('Cita cancelada exitosamente.');", true);
                cargarCitasFiltradas();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "error", $"alert('Error al cancelar la cita: {ex.Message}');", true);
            }
        }

        protected void ddlFiltroEstado_SelectedIndexChanged(object sender, EventArgs e)
        {
            SelectedEstado = ddlFiltroEstado.SelectedValue;
            cargarCitasFiltradas();
        }

    }
}