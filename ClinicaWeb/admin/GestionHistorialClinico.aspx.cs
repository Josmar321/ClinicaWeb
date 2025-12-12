using System;
using System.Linq;
using System.Collections.Generic;
using ClinicaWeb.ServiciosWS;

namespace ClinicaWeb.admin
{
    public partial class GestionHistorialClinico : System.Web.UI.Page
    {
        private PacienteWSClient wsPacientes = new PacienteWSClient();
        private const int PacientesPorPagina = 3;
        private static List<paciente> todosPacientes = new List<paciente>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarPacientes();
            }
        }

        private int PaginaActual
        {
            get
            {
                int pag;
                if (ViewState["PaginaActual"] != null && int.TryParse(ViewState["PaginaActual"].ToString(), out pag))
                    return pag;
                return 1;
            }
            set { ViewState["PaginaActual"] = value; }
        }

        private void CargarPacientes(string buscarId = "")
        {
            try
            {
                if (todosPacientes == null || todosPacientes.Count == 0)
                    todosPacientes = wsPacientes.listarPaciente()?.ToList() ?? new List<paciente>();

                IEnumerable<paciente> filtrados = todosPacientes;

                // Filtrar por código si se está buscando
                if (!string.IsNullOrEmpty(buscarId))
                {
                    filtrados = filtrados.Where(p => p.codigoPaciente != null && p.codigoPaciente.Contains(buscarId));
                    PaginaActual = 1; // Si buscas, muestra siempre la primera página
                }

                int total = filtrados.Count();
                int totalPaginas = (int)Math.Ceiling((double)total / PacientesPorPagina);
                if (PaginaActual > totalPaginas) PaginaActual = 1;

                var pacientesPagina = filtrados
                    .Skip((PaginaActual - 1) * PacientesPorPagina)
                    .Take(PacientesPorPagina)
                    .ToList();

                rptPacientes.DataSource = pacientesPagina;
                rptPacientes.DataBind();

                // Crear los números de página
                var paginas = Enumerable.Range(1, Math.Max(totalPaginas, 1)).Select(num => new { Numero = num, Actual = PaginaActual }).ToList();
                rptPaginas.DataSource = paginas;
                rptPaginas.DataBind();

                lblMensaje.Text = total == 0 ? "No se encontraron pacientes." : "";
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al cargar los pacientes: " + ex.Message;
            }
        }

        // Evento de paginación (numeritos)
        protected void rptPaginas_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            int pag;
            if (int.TryParse(e.CommandArgument.ToString(), out pag))
                PaginaActual = pag;
            CargarPacientes(txtBuscarId.Text.Trim());
        }

        // Evento de botones en paciente (Ver perfil, Ver historial)
        protected void rptPacientes_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            string codigoPaciente = e.CommandArgument.ToString();
            if (e.CommandName == "VerPerfil")
            {
                Response.Redirect($"PerfilPaciente.aspx?codigo={codigoPaciente}");
            }
            else if (e.CommandName == "VerHistorial")
            {
                Response.Redirect($"HistorialClinicoPaciente.aspx?codigo={codigoPaciente}");

            }
        }

        // Buscar por ID al hacer click en botón o enter
        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (IsPostBack && Request["__EVENTTARGET"] == "btnBuscar")
            {
                PaginaActual = 1;
                CargarPacientes(txtBuscarId.Text.Trim());
            }
        }

        // Métodos de navegación barra izquierda
        protected void btnDashboard_Click(object sender, EventArgs e) => Response.Redirect("dashboard.aspx");
        protected void btnUsuarios_Click(object sender, EventArgs e) => Response.Redirect("usuarios.aspx");
        protected void btnMedicos_Click(object sender, EventArgs e) => Response.Redirect("medicos.aspx");
        protected void btnEspecialidades_Click(object sender, EventArgs e) => Response.Redirect("especialidades.aspx");
        protected void btnLocales_Click(object sender, EventArgs e) => Response.Redirect("locales.aspx");
        protected void btnReportes_Click(object sender, EventArgs e) => Response.Redirect("reportes.aspx");
        protected void btnConfiguracion_Click(object sender, EventArgs e) => Response.Redirect("configuracion.aspx");
    }
}
