using System;
using System.Linq;
using ClinicaWeb.ServiciosWS;

namespace ClinicaWeb.doctor
{
    public partial class DetalleCitasDiagnostico : System.Web.UI.Page
    {
        private PacienteWSClient wsPaciente = new PacienteWSClient();
        private CitaMedicaWSClient wsCitas = new CitaMedicaWSClient();

        // Propiedad para acceder fácilmente al DNI del paciente desde la URL
        private string PacienteDNI
        {
            get { return Request.QueryString["dni"]; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (string.IsNullOrEmpty(PacienteDNI))
                {
                    pnlError.Visible = true;
                    lblMensajeError.Text = "No se ha especificado un paciente. Por favor, vuelva al listado.";
                    pnlContenido.Visible = false;
                    return;
                }

                CargarDatosPaciente(PacienteDNI);
                CargarCitas(PacienteDNI);
            }
        }

        private void CargarDatosPaciente(string dni)
        {
            try
            {
                paciente p = wsPaciente.obtenerPacientePorId(dni);
                if (p != null)
                {
                    lblNombrePaciente.Text = $"{p.nombre} {p.primerApellido} {p.segundoApellido}";
                    lblDniPaciente.Text = p.docIdentidad;
                }
                else
                {
                    throw new Exception("No se encontró al paciente.");
                }
            }
            catch (Exception ex)
            {
                pnlError.Visible = true;
                lblMensajeError.Text = "Error al cargar los datos del paciente: " + ex.Message;
                pnlContenido.Visible = false;
            }
        }

        private void CargarCitas(string dni)
        {
            try
            {
                // Usamos el método optimizado que solo trae las citas de este paciente
                citaMedica[] citas = wsCitas.listarCitasPorPaciente(dni);
                // Ordenamos para ver las más recientes primero
                rptCitas.DataSource = citas?.OrderByDescending(c => c.fecha).ThenByDescending(c => c.hora).ToArray();
                rptCitas.DataBind();
            }
            catch (Exception ex)
            {
                // Si falla la carga de citas, al menos mostramos un mensaje en esa sección
                pnlError.Visible = true;
                lblMensajeError.Text += "<br/>Error al cargar las citas: " + ex.Message;
            }
        }

        protected void rptCitas_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "GestionarDiagnostico")
            {
                string idCita = e.CommandArgument.ToString();
                // Redirigimos a la página del formulario, pasando el ID de la cita y el DNI del paciente
                // para poder volver fácilmente a esta página.
                Response.Redirect($"FormularioDiagnostico.aspx?idCita={idCita}&pacienteDNI={PacienteDNI}");
            }
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("GestionDiagnosticos.aspx");
        }
    }
}