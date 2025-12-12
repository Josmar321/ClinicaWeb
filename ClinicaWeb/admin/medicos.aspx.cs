using System;
using System.Linq;
using System.Web.UI.WebControls;
using ClinicaWeb.ServiciosWS;

namespace ClinicaWeb.admin
{
    public partial class medicos : System.Web.UI.Page
    {
        private MedicoWSClient wsMedico = new MedicoWSClient();
        private EspecialidadWSClient wsEspecialidad = new EspecialidadWSClient();
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
                CargarEspecialidades();
                CurrentPage = 1;
                FiltrarMedicos();
            }
        }

        private void CargarEspecialidades()
        {
            ddlEspecialidad.Items.Clear();
            ddlEspecialidad.Items.Add(new ListItem("Todas las especialidades", "0"));
            var especialidades = wsEspecialidad.listarEspecialidad();
            foreach (var esp in especialidades)
            {
                ddlEspecialidad.Items.Add(new ListItem(esp.nombre, esp.idEspecialidad.ToString()));
            }
        }

        private void FiltrarMedicos()
        {
            var medicos = wsMedico.listarMedico();
            string estado = ddlEstado.SelectedValue;
            int idEspecialidad = int.Parse(ddlEspecialidad.SelectedValue);
            string criterio = txtBuscarId.Text.Trim().ToLower();  // << AÑADIDO

            // Filtro por estado
            if (!string.IsNullOrEmpty(estado))
            {
                bool activo = estado == "activo";
                medicos = medicos.Where(m => m.activo == activo).ToArray();
            }

            // Filtro por especialidad
            if (idEspecialidad != 0)
            {
                medicos = medicos.Where(m => m.especialidad != null &&
                                             m.especialidad.idEspecialidad == idEspecialidad).ToArray();
            }

            // Filtro por texto (nombre, apellidos, código y especialidad)
            if (!string.IsNullOrEmpty(criterio))
            {
                medicos = medicos.Where(m =>
                    (m.docIdentidad != null && m.docIdentidad.Trim().ToLower().Contains(criterio)) ||
                    (m.nombre != null && m.nombre.ToLower().Contains(criterio)) ||
                    (m.primerApellido != null && m.primerApellido.ToLower().Contains(criterio)) ||
                    (m.segundoApellido != null && m.segundoApellido.ToLower().Contains(criterio)) ||
                    (m.especialidad != null && m.especialidad.nombre != null && m.especialidad.nombre.ToLower().Contains(criterio))
                ).ToArray();
            }


            int total = medicos.Length;
            int pageCount = (int)Math.Ceiling(total / (double)PageSize);
            if (CurrentPage > pageCount) CurrentPage = 1;

            var paged = medicos.Skip((CurrentPage - 1) * PageSize).Take(PageSize).ToArray();
            rptMedicos.DataSource = paged;
            rptMedicos.DataBind();

            var paginas = Enumerable.Range(1, pageCount == 0 ? 1 : pageCount).ToList();
            rptPaginas.DataSource = paginas;
            rptPaginas.DataBind();

            btnPagPrev.Enabled = CurrentPage > 1;
            btnPagNext.Enabled = CurrentPage < pageCount;
        }


        protected void ddlEstado_SelectedIndexChanged(object sender, EventArgs e)
        {
            CurrentPage = 1;
            FiltrarMedicos();
        }

        protected void ddlEspecialidad_SelectedIndexChanged(object sender, EventArgs e)
        {
            CurrentPage = 1;
            FiltrarMedicos();
        }

        protected void btnBuscarId_Click(object sender, EventArgs e)
        {
            CurrentPage = 1;
            FiltrarMedicos();
        }


        protected void btnLimpiarBusqueda_Click(object sender, EventArgs e)
        {
            txtBuscarId.Text = "";
            CurrentPage = 1;
            FiltrarMedicos();
        }

        protected void btnPagPrev_Click(object sender, EventArgs e)
        {
            if (CurrentPage > 1) CurrentPage--;
            FiltrarMedicos();
        }

        protected void btnPagNext_Click(object sender, EventArgs e)
        {
            var medicos = wsMedico.listarMedico();
            string estado = ddlEstado.SelectedValue;
            int idEspecialidad = int.Parse(ddlEspecialidad.SelectedValue);

            if (!string.IsNullOrEmpty(estado))
            {
                bool activo = estado == "activo";
                medicos = medicos.Where(m => m.activo == activo).ToArray();
            }

            if (idEspecialidad != 0)
            {
                medicos = medicos.Where(m => m.especialidad != null && m.especialidad.idEspecialidad == idEspecialidad).ToArray();
            }

            int total = medicos.Length;
            int pageCount = (int)Math.Ceiling(total / (double)PageSize);
            if (CurrentPage < pageCount) CurrentPage++;
            FiltrarMedicos();
        }

        protected void btnPag_Click(object sender, EventArgs e)
        {
            var btn = (Button)sender;
            int nuevaPagina = int.Parse(btn.CommandArgument);
            CurrentPage = nuevaPagina;
            FiltrarMedicos();
        }

        protected void rptMedicos_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            string codigoMedico = e.CommandArgument.ToString();
            Session["docIdentidadMedico"] = codigoMedico;
            if (e.CommandName == "VerPerfil")
                Response.Redirect($"PerfilMedico.aspx?codigoMedico={codigoMedico}");
            else if (e.CommandName == "VerHistorial")
                Response.Redirect($"ReporteAtencionXMedicos.aspx?codigoMedico={codigoMedico}");
        }
    }
}
