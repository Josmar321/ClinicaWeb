using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.ComponentModel;
using ClinicaWeb.ServiciosWS;

namespace ClinicaWeb.admin
{
    public partial class locales : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                CargarLocales();
        }

        private void CargarLocales(string filtro = "", string estado = "")
        {
            LocalWSClient client = new LocalWSClient();
            var lista = client.listarLocales();

            if (!string.IsNullOrWhiteSpace(filtro))
                lista = lista.Where(e => e.direccion.IndexOf(filtro, StringComparison.OrdinalIgnoreCase) >= 0).ToArray();

            if (!string.IsNullOrWhiteSpace(estado))
            {
                bool activo = estado == "activo";
                lista = lista.Where(e => Convert.ToBoolean(e.activo) == activo).ToArray();
            }

            rptLocales.DataSource = lista;
            rptLocales.DataBind();
        }
       
        protected void IrNuevoLocal(object sender, EventArgs e)
        {
            Response.Redirect("nuevo-local.aspx");
        }
        protected void txtBuscar_TextChanged(object sender, EventArgs e)
        {
            string filtro = txtBuscar.Text.Trim();
            string estado = ddlEstado.SelectedValue;
            CargarLocales(filtro,estado);
        }

        protected void ddlEstado_SelectedIndexChanged(object sender, EventArgs e)
        {
            string filtro = txtBuscar.Text.Trim();
            string estado = ddlEstado.SelectedValue;
            CargarLocales(filtro,estado);
        }
    }
}