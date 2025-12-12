using System;
using System.Collections.Generic;
using System.Linq;
using ClinicaWeb.patient;
using ClinicaWeb.ServiciosWS;

namespace ClinicaWeb.doctor
{
    public partial class HistorialClinicoPaciente : System.Web.UI.Page
    {
        // Se usan los endpoints específicos para evitar el error de ambigüedad.
        // Asegúrate que los nombres ("...WSPort1" o "...WSPort") coincidan con tu Web.config.
        private PacienteWSClient wsPacientes = new PacienteWSClient();
        private static List<medico> listaCompletaMedicos;
        private HistorialClinicoWSClient wsHistorial = new HistorialClinicoWSClient("HistorialClinicoWSPort");
        private CitaMedicaWSClient wsCitas = new CitaMedicaWSClient("CitaMedicaWSPort");
        MedicoWSClient wsMedicos = new MedicoWSClient();
        private string CodigoPacienteActual
        {
            get { return Request.QueryString["codigo"]; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {


                // Cargar la lista de médicos una sola vez
                try
                {

                    listaCompletaMedicos = wsMedicos.listarMedico()?.ToList() ?? new List<medico>();
                }
                catch
                {
                    listaCompletaMedicos = new List<medico>();
                }

                if (string.IsNullOrEmpty(CodigoPacienteActual))
                {
                    MostrarError("No se ha especificado el código del paciente.");
                    return;
                }
                CargarDatosCompletos(CodigoPacienteActual);
            }
        }
        protected string ObtenerNombreMedico(object medicoObj)
        {
            if (medicoObj == null || listaCompletaMedicos == null) return "No asignado";

            medico med = (medico)medicoObj;
            if (med.codigoMedico == null) return "Código no disponible";

            var medicoEncontrado = listaCompletaMedicos.FirstOrDefault(m => m.codigoMedico == med.codigoMedico);

            if (medicoEncontrado != null)
            {
                return $"{medicoEncontrado.nombre} {medicoEncontrado.primerApellido}";
            }
            return "Médico no encontrado";
        }
        protected string GetStatusBadgeClass(string status)
        {
            switch (status.ToLower())
            {
                case "completada":
                    return "status-completed";
                case "pendiente":
                    return "status-pending";
                case "cancelada":
                    return "status-canceled";
                default:
                    return "bg-info text-dark";
            }
        }
        private void CargarDatosCompletos(string codigoPaciente)
        {
            try
            {
                // 1. Buscamos el paciente por separado para asegurarnos de tener todos sus datos
                paciente pac = wsPacientes.obtenerPacientePorId(codigoPaciente);
                if (pac == null)
                {
                    MostrarError("No se encontró al paciente con el código especificado.");
                    return;
                }

                // 2. Llenamos el encabezado con los datos completos del paciente
                lblNombrePaciente.Text = $"{pac.nombre} {pac.primerApellido} {pac.segundoApellido}";
                lblDniPaciente.Text = pac.docIdentidad;
                lblCodigoPaciente.Text = pac.codigoPaciente;
                lblEmailPaciente.Text = pac.email;

                // 3. Cargar el historial clínico (esta parte ya estaba bien)
                historialClinico historial = wsHistorial.obtenerHistorialConCitas(codigoPaciente);
                if (historial != null)
                {
                    lblObsGenerales.Text = string.IsNullOrEmpty(historial.obsGenerales) ? "Sin observaciones." : historial.obsGenerales;
                    divObs.Visible = true;
                }
                else
                {
                    divObs.Visible = false;
                }

                // 4. Cargar las citas (esta parte ya estaba bien)
                citaMedica[] citas = wsCitas.listarCitasPorPaciente(codigoPaciente);
                rptCitas.DataSource = citas?.OrderByDescending(c => c.fecha).ToArray();
                rptCitas.DataBind();

                pnlContenido.Visible = true; // Mostrar todo el panel
            }
            catch (Exception ex)
            {
                MostrarError("Ocurrió un error al cargar la información: " + ex.Message);
            }
        }

        private void MostrarError(string mensaje)
        {
            lblMensaje.Text = mensaje;
            lblMensaje.Visible = true;
            pnlContenido.Visible = false; // Ocultar el contenido principal si hay un error
        }

        protected void btnAgregarCita_Click(object sender, EventArgs e)
        {
            Response.Redirect($"InsertarCitaMedica.aspx?codigo={CodigoPacienteActual}");
        }

        protected void rptCitas_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Editar")
            {
                int idCitaMedica = Convert.ToInt32(e.CommandArgument);
                // Volvemos a usar tu URL original, que pasa ambos parámetros necesarios
                Response.Redirect($"ModificarCitaMedica.aspx?idCitaMedica={idCitaMedica}&codigo={CodigoPacienteActual}");
            }
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("GestionHistorialClinico.aspx");
        }
    }
}