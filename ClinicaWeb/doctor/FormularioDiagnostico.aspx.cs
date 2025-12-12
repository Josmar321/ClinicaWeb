using System;
using System.Linq;
using ClinicaWeb.ServiciosWS;

namespace ClinicaWeb.doctor
{
    public partial class FormularioDiagnostico : System.Web.UI.Page
    {
        private CitaMedicaWSClient wsCita = new CitaMedicaWSClient();
        private DiagnosticoWSClient wsDiagnostico = new DiagnosticoWSClient();
        private TratamientoWSClient wsTratamiento = new TratamientoWSClient();

        private int IdCitaActual
        {
            get
            {
                int.TryParse(Request.QueryString["idCita"], out int id);
                return id;
            }
        }
        private string PacienteDNI
        {
            get { return Request.QueryString["pacienteDNI"]; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (IdCitaActual == 0)
                {
                    MostrarError("No se ha especificado una cita válida.");
                    return;
                }
                CargarDatos();
            }
        }

        private void CargarDatos()
        {
            try
            {

                citaMedica cita = wsCita.obtenerCitaMedicaPorId(IdCitaActual);
                if (cita == null)
                {
                    MostrarError("No se pudieron cargar los detalles de la cita.");
                    return;
                }
                lblFechaCita.Text = cita.fecha.ToString("dd/MM/yyyy");


                paciente pac = new PacienteWSClient().obtenerPacientePorId(this.PacienteDNI);
                if (pac != null)
                {
                    lblNombrePaciente.Text = $"{pac.nombre} {pac.primerApellido} {pac.segundoApellido}";
                    lblDniPaciente.Text = pac.docIdentidad; 
                }


                diagnostico diag = wsDiagnostico.obtenerDiagnosticoPorId(IdCitaActual);
                if (diag != null)
                {
                    hdnDiagnosticoId.Value = diag.idDiagnostico.ToString();
                    txtDiagnostico.Text = diag.descripcionDiagnostico;
                }

                tratamiento trat = wsTratamiento.obtenerTratamientoPorId(IdCitaActual);
                if (trat != null)
                {
                    hdnTratamientoId.Value = trat.idTratamiento.ToString();
                    txtTratamiento.Text = trat.descripcionTratamiento;
                }
            }
            catch (Exception ex)
            {
                MostrarError("Error al cargar la información: " + ex.Message);
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
         
                diagnostico diag = new diagnostico
                {
                    idDiagnostico = int.Parse(hdnDiagnosticoId.Value),
                    descripcionDiagnostico = txtDiagnostico.Text,
                    fecha = DateTime.Now,
                    citaMedica = new citaMedica { idCita = IdCitaActual }
                };

                if (diag.idDiagnostico > 0)
                    wsDiagnostico.modificarDiagnostico(diag);
                else
                    wsDiagnostico.insertarDiagnostico(diag);

              
                tratamiento trat = new tratamiento
                {
                    idTratamiento = int.Parse(hdnTratamientoId.Value),
                    descripcionTratamiento = txtTratamiento.Text,
                    citaMedica = new citaMedica { idCita = IdCitaActual }
                };

                if (trat.idTratamiento > 0)
                    wsTratamiento.modificarTratamiento(trat);
                else
                    wsTratamiento.insertarTratamiento(trat);

               
                citaMedica cita = wsCita.obtenerCitaMedicaPorId(IdCitaActual);
                if (cita != null && cita.estado == estadoCita.PROGRAMADA)
                {
                    cita.estado = estadoCita.REALIZADA;
                    wsCita.modificarCitaMedica(cita);
                }

                lblMensajeExito.Text = "Diagnóstico y tratamiento guardados con éxito. Estado de cita actualizado a Realizada.";
                lblMensajeExito.Visible = true;
            }
            catch (Exception ex)
            {
                MostrarError("Error al guardar los datos: " + ex.Message);
            }
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect($"DetalleCitasDiagnostico.aspx?dni={PacienteDNI}");
        }

        private void MostrarError(string mensaje)
        {
            pnlError.Visible = true;
            lblMensajeError.Text = mensaje;
            pnlContenido.Visible = false;
        }
    }
}