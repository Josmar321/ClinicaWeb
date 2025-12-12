using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using ClinicaWeb.ServiciosWS;

namespace ClinicaWeb.admin
{
    public partial class HistorialClinicoPaciente : System.Web.UI.Page
    {
        private PacienteWSClient wsPacientes = new PacienteWSClient();
        private HistorialClinicoWSClient wsHistorial = new HistorialClinicoWSClient();
        private CitaMedicaWSClient wsCitas = new CitaMedicaWSClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string codigo = Request.QueryString["codigo"];
                if (string.IsNullOrEmpty(codigo))
                {
                    lblMensaje.Text = "No se ha especificado el paciente.";
                    divInfoPaciente.Visible = false;
                    divObs.Visible = false;
                    rptCitas.Visible = false;
                    return;
                }
                CargarDatosPaciente(codigo);
                CargarHistorial(codigo);
                CargarCitasMedicas(codigo, null, null);
            }
        }

        private void CargarDatosPaciente(string codigo)
        {
            paciente paciente = wsPacientes.obtenerPacientePorId(codigo);
            if (paciente == null)
            {
                lblMensaje.Text = "No se encontró el paciente.";
                divInfoPaciente.Visible = false;
                return;
            }
            lblNombrePaciente.Text = paciente.nombre + " " + paciente.primerApellido + " " + paciente.segundoApellido;
            lblCodigoPaciente.Text = paciente.codigoPaciente;
            lblEmailPaciente.Text = paciente.email;
            divInfoPaciente.Visible = true;
        }

        private void CargarHistorial(string codigo)
        {
            historialClinico historial = wsHistorial.obtenerHistorialConCitas(codigo);
            if (historial == null)
            {
                lblMensaje.Text = "Este paciente no tiene historial clínico registrado.";
                divObs.Visible = false;
                return;
            }
            lblObsGenerales.Text = historial.obsGenerales;
            divObs.Visible = true;
        }

        private void CargarCitasMedicas(string codigoPaciente, DateTime? fechaInicio, DateTime? fechaFin)
        {
            citaMedica[] citas = wsCitas.listarCitasMedicas()
                .Where(c => c.paciente != null && c.paciente.codigoPaciente == codigoPaciente)
                .ToArray();

            if (fechaInicio.HasValue && fechaFin.HasValue)
            {
                citas = citas.Where(c => c.fecha >= fechaInicio.Value && c.fecha <= fechaFin.Value).ToArray();
            }

            rptCitas.DataSource = citas;
            rptCitas.DataBind();

            lblMensajeCitas.Text = citas.Length == 0 ? "No se encontraron citas para este paciente." : "";
        }

        protected void btnBuscarPorFecha_Click(object sender, EventArgs e)
        {
            string codigo = Request.QueryString["codigo"];
            DateTime? fechaInicio = null, fechaFin = null;
            if (DateTime.TryParse(txtFechaInicio.Text, out DateTime fi)) fechaInicio = fi;
            if (DateTime.TryParse(txtFechaFin.Text, out DateTime ff)) fechaFin = ff;

            CargarCitasMedicas(codigo, fechaInicio, fechaFin);
        }

        protected void btnAgregarCita_Click(object sender, EventArgs e)
        {
            string codigo = Request.QueryString["codigo"];
            Response.Redirect($"InsertarCitaMedica.aspx?codigo={codigo}");
        }

        protected void rptCitas_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            string codigoPaciente = Request.QueryString["codigo"];
            int idCitaMedica = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Editar")
            {
                Response.Redirect($"ModificarCitaMedica.aspx?idCitaMedica={idCitaMedica}&codigo={codigoPaciente}");
            }
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("GestionHistorialClinico.aspx");
        }

        // Métodos barra izquierda...
        protected void btnDashboard_Click(object sender, EventArgs e) => Response.Redirect("dashboard.aspx");
        protected void btnUsuarios_Click(object sender, EventArgs e) => Response.Redirect("usuarios.aspx");
        protected void btnMedicos_Click(object sender, EventArgs e) => Response.Redirect("medicos.aspx");
        protected void btnEspecialidades_Click(object sender, EventArgs e) => Response.Redirect("especialidades.aspx");
        protected void btnLocales_Click(object sender, EventArgs e) => Response.Redirect("locales.aspx");
        protected void btnReportes_Click(object sender, EventArgs e) => Response.Redirect("reportes.aspx");
        protected void btnConfiguracion_Click(object sender, EventArgs e) => Response.Redirect("configuracion.aspx");
    }
}
