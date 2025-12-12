// administradores.aspx.cs
using System;
using System.Linq;
using System.Web.UI.WebControls;
using ClinicaWeb.ServiciosWS;

namespace ClinicaWeb.admin
{
    public partial class administradores : System.Web.UI.Page
    {
        private AdministradorWSClient ws = new AdministradorWSClient();
        private const int PageSize = 3;

        protected int CurrentPage
        {
            get
            {
                if (ViewState["CurrentPage"] == null)
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
                FiltrarAdministradores();
            }
        }

        private void FiltrarAdministradores()
        {
            var admins = ws.listarAdministrador();
            string estado = ddlEstado.SelectedValue;

            if (!string.IsNullOrEmpty(estado))
            {
                bool activo = estado == "activo";
                admins = admins.Where(a => a.activo == activo).ToArray();
            }

            int total = admins.Length;
            int pageCount = (int)Math.Ceiling(total / (double)PageSize);
            if (CurrentPage > pageCount) CurrentPage = 1;

            var paged = admins.Skip((CurrentPage - 1) * PageSize).Take(PageSize).ToArray();
            rptAdmins.DataSource = paged;
            rptAdmins.DataBind();

            rptPaginas.DataSource = Enumerable.Range(1, pageCount == 0 ? 1 : pageCount);
            rptPaginas.DataBind();

            btnPagPrev.Enabled = CurrentPage > 1;
            btnPagNext.Enabled = CurrentPage < pageCount;
        }

        protected void ddlEstado_SelectedIndexChanged(object sender, EventArgs e)
        {
            CurrentPage = 1;
            FiltrarAdministradores();
        }
        protected void btnBuscarId_Click(object sender, EventArgs e)
        {
            string filtro = txtBuscarId.Text.Trim().ToLower();
            if (!string.IsNullOrEmpty(filtro))
            {
                var lista = ws.listarAdministrador();

                // Filtrar por estado si está seleccionado
                string estado = ddlEstado.SelectedValue;
                if (!string.IsNullOrEmpty(estado))
                {
                    bool activo = estado == "activo";
                    lista = lista.Where(a => a.activo == activo).ToArray();
                }

                // Filtrar por coincidencia parcial en cualquier campo relevante
                var resultado = lista.Where(a =>
                    a.docIdentidad.ToLower().Contains(filtro) ||
                    a.nombre.ToLower().Contains(filtro) ||
                    a.primerApellido.ToLower().Contains(filtro) ||
                    a.segundoApellido.ToLower().Contains(filtro)
                ).ToArray();

                // Mostrar resultados o limpiar si no hay coincidencias
                rptAdmins.DataSource = resultado.Length > 0 ? resultado : null;
                rptAdmins.DataBind();

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
            FiltrarAdministradores();
        }

        protected void btnPagPrev_Click(object sender, EventArgs e)
        {
            if (CurrentPage > 1) CurrentPage--;
            FiltrarAdministradores();
        }

        protected void btnPagNext_Click(object sender, EventArgs e)
        {
            var admins = ws.listarAdministrador();
            string estado = ddlEstado.SelectedValue;

            if (!string.IsNullOrEmpty(estado))
            {
                bool activo = estado == "activo";
                admins = admins.Where(a => a.activo == activo).ToArray();
            }

            int total = admins.Length;
            int pageCount = (int)Math.Ceiling(total / (double)PageSize);
            if (CurrentPage < pageCount) CurrentPage++;
            FiltrarAdministradores();
        }

        protected void btnPag_Click(object sender, EventArgs e)
        {
            var btn = (Button)sender;
            int nuevaPagina = int.Parse(btn.CommandArgument);
            CurrentPage = nuevaPagina;
            FiltrarAdministradores();
        }

        protected void rptAdmins_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            string codigoAdmin = e.CommandArgument.ToString();
            if (e.CommandName == "VerPerfil")
                Response.Redirect($"admin-perfil.aspx?codigoAdmin={codigoAdmin}");
        }
    }
}
