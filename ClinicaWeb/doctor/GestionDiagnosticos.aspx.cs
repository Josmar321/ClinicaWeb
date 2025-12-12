using System;
using System.Collections.Generic;
using System.Linq;
using ClinicaWeb.ServiciosWS;

namespace ClinicaWeb.doctor
{
    public partial class GestionDiagnosticos : System.Web.UI.Page
    {
        // Clientes de los Web Services necesarios
        private PacienteWSClient wsPacientes = new PacienteWSClient();
        private CitaMedicaWSClient wsCitas = new CitaMedicaWSClient();
        private ReporteDiagnosticosWSClient wsReporte = new ReporteDiagnosticosWSClient();
        private MedicoWSClient wsMedico = new MedicoWSClient();
        private UsuarioWSClient wsUsuario = new UsuarioWSClient();

        private const int PacientesPorPagina = 5;
        private static List<paciente> pacientesDelMedico = new List<paciente>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Usuario"] == null)
                {
                    Response.Redirect("~/InicioSesion.aspx");
                    return;
                }

                pacientesDelMedico.Clear();
                CargarPacientes();
            }
        }

        private int PaginaActual
        {
            get { return ViewState["PaginaActual"] != null ? (int)ViewState["PaginaActual"] : 1; }
            set { ViewState["PaginaActual"] = value; }
        }

        private void CargarPacientes(string buscarDNI = "")
        {
            try
            {
                if (pacientesDelMedico.Count == 0 && string.IsNullOrEmpty(buscarDNI))
                {
                    string codigoMedico = Session["CodigoMedicoLogueado"]?.ToString();
                    if (string.IsNullOrEmpty(codigoMedico))
                    {
                        string username = Session["Usuario"]?.ToString();
                        if (string.IsNullOrEmpty(username)) return;

                        int idUsuario = wsUsuario.obtenerUsuarioPorUsername(username);
                        medico med = wsMedico.obtenerMedicoXUser(idUsuario);
                        if (med == null) return;

                        codigoMedico = med.codigoMedico;
                        Session["CodigoMedicoLogueado"] = codigoMedico;
                    }

                    var todasLasCitas = wsCitas.listarCitasMedicas()?.ToList() ?? new List<citaMedica>();
                    var citasDelMedico = todasLasCitas.Where(c => c.medico != null && c.medico.codigoMedico.Trim() == codigoMedico.Trim()).ToList();

                    if (citasDelMedico.Any())
                    {
                        // ==================================================================
                        // ===     APLICANDO TU LÓGICA: OBTENER PACIENTES COMPLETOS       ===
                        // ==================================================================

                        // 1. Obtenemos los códigos únicos de los pacientes de las citas del médico.
                        var codigosDeMisPacientes = citasDelMedico
                            .Where(c => c.paciente != null && c.paciente.codigoPaciente != null)
                            .Select(c => c.paciente.codigoPaciente.Trim())
                            .Distinct()
                            .ToList();

                        // 2. Creamos una nueva lista para guardar los pacientes con datos completos.
                        var listaCompletaDePacientes = new List<paciente>();

                        // 3. Por cada código único, llamamos al servicio para obtener el objeto completo.
                        foreach (string codigo in codigosDeMisPacientes)
                        {
                            paciente pCompleto = wsPacientes.obtenerPacientePorId(codigo);
                            if (pCompleto != null)
                            {
                                listaCompletaDePacientes.Add(pCompleto);
                            }
                        }

                        // 4. Asignamos esta nueva lista completa a nuestra variable estática.
                        pacientesDelMedico = listaCompletaDePacientes;
                    }
                }

                IEnumerable<paciente> listaParaMostrar = pacientesDelMedico;

                if (!string.IsNullOrEmpty(buscarDNI))
                {
                    listaParaMostrar = pacientesDelMedico.Where(p => p.docIdentidad != null && p.docIdentidad.Contains(buscarDNI));
                }

                int totalRegistros = listaParaMostrar.Count();
                rptPacientes.DataSource = listaParaMostrar.Skip((PaginaActual - 1) * PacientesPorPagina).Take(PacientesPorPagina).ToList();
                rptPacientes.DataBind();

                int totalPaginas = (int)Math.Ceiling((double)totalRegistros / PacientesPorPagina);
                if (PaginaActual > totalPaginas && totalPaginas > 0) PaginaActual = totalPaginas;

                var paginas = Enumerable.Range(1, Math.Max(1, totalPaginas))
                                          .Select(i => new { Numero = i, Actual = PaginaActual });
                rptPaginas.DataSource = paginas;
                rptPaginas.DataBind();
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al cargar los pacientes: " + ex.Message;
                lblMensaje.Visible = true;
            }
        }

        // --- LOS MÉTODOS DE EVENTOS SE QUEDAN IGUAL ---

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            PaginaActual = 1;
            CargarPacientes(txtBuscarId.Text.Trim());
        }

        protected void btnGenerarReporte_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtFechaInicio.Text) || string.IsNullOrEmpty(txtFechaFin.Text))
            {
                lblReporteError.Text = "Debe seleccionar una fecha de inicio y una fecha de fin.";
                lblReporteError.Visible = true;
                return;
            }
            string codigoMedico = Session["CodigoMedicoLogueado"]?.ToString();
            if (string.IsNullOrEmpty(codigoMedico))
            {
                lblReporteError.Text = "Error de sesión. Por favor, inicie sesión de nuevo.";
                lblReporteError.Visible = true;
                return;
            }
            DateTime fechaInicio = DateTime.Parse(txtFechaInicio.Text);
            DateTime fechaFin = DateTime.Parse(txtFechaFin.Text);
            try
            {
                byte[] reportePDF = wsReporte.generarReporteDiagnosticosMedico(codigoMedico, fechaInicio, fechaFin);
                if (reportePDF == null || reportePDF.Length == 0)
                {
                    lblReporteError.Text = "No se encontraron datos para generar el reporte con los filtros seleccionados.";
                    lblReporteError.Visible = true;
                    return;
                }
                Response.Clear();
                Response.ContentType = "application/pdf";
                Response.AddHeader("content-disposition", "attachment;filename=Reporte_Personal.pdf");
                Response.BinaryWrite(reportePDF);
                Response.End();
            }
            catch (Exception ex)
            {
                lblReporteError.Text = "Error al generar el reporte: " + ex.Message;
                lblReporteError.Visible = true;
            }
        }

        protected void rptPacientes_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Gestionar")
            {
                string pacienteDNI = e.CommandArgument.ToString();
                Response.Redirect($"DetalleCitasDiagnostico.aspx?dni={pacienteDNI}");
            }
        }

        protected void rptPaginas_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Paginar")
            {
                PaginaActual = Convert.ToInt32(e.CommandArgument);
                CargarPacientes(txtBuscarId.Text.Trim());
            }
        }
    }
}