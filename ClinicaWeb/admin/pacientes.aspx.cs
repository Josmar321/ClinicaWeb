using System;
using System.Linq;
using System.Web.UI.WebControls;
using ClinicaWeb.ServiciosWS;

namespace ClinicaWeb.admin
{
    public partial class pacientes : System.Web.UI.Page
    {
        private PacienteWSClient wsPaciente = new PacienteWSClient();
        private const int PageSize = 3;

        protected int CurrentPage
        {
            get
            {
                if (ViewState["CurrentPage"] == null || (int?)ViewState["CurrentPage"] < 1)
                    ViewState["CurrentPage"] = 1;
                return (int)ViewState["CurrentPage"];
            }
            set
            {
                ViewState["CurrentPage"] = value < 1 ? 1 : value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CurrentPage = 1;
                FiltrarPacientes();
            }
        }

        private void FiltrarPacientes()
        {
            var pacientes = wsPaciente.listarPaciente();
            string estado = ddlEstado.SelectedValue;

            if (!string.IsNullOrEmpty(estado))
            {
                bool activo = estado == "activo";
                pacientes = pacientes.Where(p => p.activo == activo).ToArray();
            }

            int total = pacientes.Length;
            int pageCount = (int)Math.Ceiling(total / (double)PageSize);
            if (CurrentPage > pageCount) CurrentPage = 1;

            var paged = pacientes.Skip((CurrentPage - 1) * PageSize).Take(PageSize).ToArray();
            rptPacientes.DataSource = paged;
            rptPacientes.DataBind();

            var paginas = Enumerable.Range(1, pageCount == 0 ? 1 : pageCount).ToList();
            rptPaginas.DataSource = paginas;
            rptPaginas.DataBind();

            btnPagPrev.Enabled = CurrentPage > 1;
            btnPagNext.Enabled = CurrentPage < pageCount;
        }

        protected void ddlEstado_SelectedIndexChanged(object sender, EventArgs e)
        {
            CurrentPage = 1;
            FiltrarPacientes();
        }

        protected void btnBuscarId_Click(object sender, EventArgs e)
        {
            string id = txtBuscarId.Text.Trim().ToLower();
            if (!string.IsNullOrEmpty(id))
            {
                var pacientes = wsPaciente.listarPaciente();
                var filtrados = pacientes.Where(p =>
                    (p.docIdentidad != null && p.docIdentidad.ToLower().Contains(id)) ||
                    (p.nombre != null && p.nombre.ToLower().Contains(id)) ||
                    (p.primerApellido != null && p.primerApellido.ToLower().Contains(id)) ||
                    (p.segundoApellido != null && p.segundoApellido.ToLower().Contains(id))
                ).ToArray();

                string estado = ddlEstado.SelectedValue;
                bool activo = estado == "activo";

                filtrados = filtrados.Where(p => p.activo == activo).ToArray();

                rptPacientes.DataSource = filtrados;
                rptPacientes.DataBind();
                rptPaginas.DataSource = new int[0];
                rptPaginas.DataBind();
                btnPagPrev.Enabled = false;
                btnPagNext.Enabled = false;
            }
        }

        protected void btnLimpiarBusqueda_Click(object sender, EventArgs e)
        {
            txtBuscarId.Text = "";
            CurrentPage = 1;
            FiltrarPacientes();
        }

        protected void btnPagPrev_Click(object sender, EventArgs e)
        {
            if (CurrentPage > 1) CurrentPage--;
            FiltrarPacientes();
        }

        protected void btnPagNext_Click(object sender, EventArgs e)
        {
            var pacientes = wsPaciente.listarPaciente();
            string estado = ddlEstado.SelectedValue;

            if (!string.IsNullOrEmpty(estado))
            {
                bool activo = estado == "activo";
                pacientes = pacientes.Where(p => p.activo == activo).ToArray();
            }

            int total = pacientes.Length;
            int pageCount = (int)Math.Ceiling(total / (double)PageSize);
            if (CurrentPage < pageCount) CurrentPage++;
            FiltrarPacientes();
        }

        protected void btnPag_Click(object sender, EventArgs e)
        {
            var btn = (Button)sender;
            int nuevaPagina = int.Parse(btn.CommandArgument);
            CurrentPage = nuevaPagina;
            FiltrarPacientes();
        }

        protected void rptPacientes_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            string docId = e.CommandArgument.ToString();
            if (e.CommandName == "VerPerfil")
                Response.Redirect($"PerfilPaciente.aspx?doc={docId}");
            else if (e.CommandName == "VerHistoria")
                Response.Redirect($"HistoriaClinica.aspx?doc={docId}");
        }
    }
}
