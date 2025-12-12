using System;
using System.Linq;
using System.Web.UI.WebControls;
using ClinicaWeb.ServiciosWS;

namespace ClinicaWeb.doctor
{
    public partial class ModificarCitaMedica : System.Web.UI.Page
    {
        private CitaMedicaWSClient wsCitas = new CitaMedicaWSClient();
        private MedicoWSClient wsMedicos = new MedicoWSClient();
        private HistorialClinicoWSClient wsHistorial = new HistorialClinicoWSClient();

        private int IdCitaActual
        {
            get { int.TryParse(Request.QueryString["idCitaMedica"], out int id); return id; }
        }
        private string CodigoPaciente
        {
            get { return Request.QueryString["codigo"]; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (IdCitaActual == 0 || string.IsNullOrEmpty(CodigoPaciente))
                {
                    lblMensaje.Text = "No se ha especificado la cita o el paciente correctamente.";
                    lblMensaje.Visible = true;
                    pnlFormulario.Visible = false;
                    return;
                }
                CargarDatosCita(IdCitaActual);
            }
        }

        private void CargarDatosCita(int idCita)
        {
            try
            {
                var listaMedicos = wsMedicos.listarMedico();
                ddlMedico.DataSource = listaMedicos;
                ddlMedico.DataTextField = "nombre";
                ddlMedico.DataValueField = "codigoMedico";
                ddlMedico.DataBind();
                ddlMedico.Items.Insert(0, new ListItem("Seleccione un médico...", ""));

                ddlEstado.Items.Add("PROGRAMADA");
                ddlEstado.Items.Add("CANCELADA");
                ddlEstado.Items.Add("REALIZADA");
                ddlModalidad.Items.Add("PRESENCIAL");
                ddlModalidad.Items.Add("VIRTUAL");

                citaMedica cita = wsCitas.obtenerCitaMedicaPorId(idCita);

                if (cita == null)
                {
                    lblMensaje.Text = "Error: No se pudo encontrar la cita médica.";
                    lblMensaje.Visible = true;
                    pnlFormulario.Visible = false;
                    return;
                }

                ViewState["CitaOriginal"] = cita;

                txtFecha.Text = cita.fecha.ToString("yyyy-MM-dd");
                txtHora.Text = cita.hora.ToString("HH:mm");
                txtPrecio.Text = cita.precio.ToString();
                ddlEstado.SelectedValue = cita.estado.ToString();
                ddlModalidad.SelectedValue = cita.modalidad.ToString();

                if (cita.paciente != null)
                {
                    txtCodigoPaciente.Text = cita.paciente.codigoPaciente ?? "";
                }
                if (cita.medico != null && !string.IsNullOrEmpty(cita.medico.codigoMedico))
                {
                    ddlMedico.SelectedValue = cita.medico.codigoMedico;
                }
                chkActivo.Checked = cita.activo;
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Ocurrió un error al cargar los datos: " + ex.Message;
                lblMensaje.Visible = true;
                pnlFormulario.Visible = false;
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                citaMedica citaOriginal = (citaMedica)ViewState["CitaOriginal"];
                if (citaOriginal == null || citaOriginal.paciente == null)
                {
                    lblMensaje.Text = "Error de sesión. No se pudo recuperar la información de la cita.";
                    lblMensaje.Visible = true;
                    return;
                }

                historialClinico historialParaGuardar = citaOriginal.historialClinico;

                // ==================================================================
                // ===     LÓGICA PARA CREAR HISTORIAL CLÍNICO SI ES NULO         ===
                // ==================================================================
                if (historialParaGuardar == null || historialParaGuardar.idHistorial == 0)
                {
                    // Intentamos obtenerlo primero, por si acaso ya existe pero no vino con la cita
                    historialParaGuardar = wsHistorial.obtenerHistorialConCitas(citaOriginal.paciente.codigoPaciente);

                    // Si sigue siendo nulo, ahora sí lo creamos
                    if (historialParaGuardar == null)
                    {
                        lblMensaje.Text = "Paciente sin historial. Creando uno nuevo automáticamente...";
                        lblMensaje.Visible = true;

                        historialClinico nuevoHistorial = new historialClinico
                        {
                            paciente = citaOriginal.paciente,
                            fechaCreacion = DateTime.Now,
                            fechaCreacionSpecified = true,
                            obsGenerales = "Historial creado automáticamente.",
                            citasMedicas = new citaMedica[] { citaOriginal } // Adjuntamos la cita para el backend
                        };

                        int nuevoHistorialId = wsHistorial.insertarHistorialClinico(nuevoHistorial);

                        if (nuevoHistorialId <= 0)
                        {
                            lblMensaje.Text = "Error crítico: No se pudo crear el historial del paciente.";
                            return;
                        }

                        // Creamos la referencia al historial recién creado
                        historialParaGuardar = new historialClinico { idHistorial = nuevoHistorialId };
                    }
                }

                // --- FIN DE LA NUEVA LÓGICA ---

                citaMedica citaModificada = new citaMedica
                {
                    idCita = citaOriginal.idCita,
                    fecha = DateTime.Parse(txtFecha.Text),
                    fechaSpecified = true,
                    hora = DateTime.Parse(txtHora.Text),
                    horaSpecified = true,
                    precio = double.Parse(txtPrecio.Text),
                    estado = (estadoCita)Enum.Parse(typeof(estadoCita), ddlEstado.SelectedValue),
                    estadoSpecified = true,
                    modalidad = (modalidad)Enum.Parse(typeof(modalidad), ddlModalidad.SelectedValue),
                    modalidadSpecified = true,
                    activo = chkActivo.Checked,
                    paciente = citaOriginal.paciente,
                    consultorio = citaOriginal.consultorio,
                    medico = new medico { codigoMedico = ddlMedico.SelectedValue },
                    historialClinico = historialParaGuardar
                };

                int res = wsCitas.modificarCitaMedica(citaModificada);

                if (res > 0)
                {
                    Response.Redirect($"HistorialClinicoPaciente.aspx?codigo={this.CodigoPaciente}&update_success=1");
                }
                else
                {
                    lblMensaje.Text = "No se pudo modificar la cita.";
                    lblMensaje.Visible = true;
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al guardar los cambios: " + ex.Message;
                lblMensaje.Visible = true;
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect($"HistorialClinicoPaciente.aspx?codigo={this.CodigoPaciente}");
        }
    }
}