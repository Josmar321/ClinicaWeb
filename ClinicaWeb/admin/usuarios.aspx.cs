using ClinicaWeb.ServiciosWS;
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ClinicaWeb.admin
{   

    public partial class usuarios : System.Web.UI.Page
    {
        private UsuarioWSClient boUsuario = new UsuarioWSClient();
        private BindingList<usuario> usuariosList;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                CargarUsuarios();
            }
        }

        private void CargarUsuarios(string filtro = "", string estado = "", string rol = "")
        {
            boUsuario = new UsuarioWSClient();
            var lista = boUsuario.listarUsuario();

            if (!string.IsNullOrWhiteSpace(filtro))
                lista = lista.Where(e => e.username.IndexOf(filtro, StringComparison.OrdinalIgnoreCase) >= 0).ToArray();

            if (!string.IsNullOrWhiteSpace(estado))
            {
                bool activo = estado == "activo";
                lista = lista.Where(e => Convert.ToBoolean(e.activo) == activo).ToArray();
            }
            if (!string.IsNullOrWhiteSpace(rol))
                lista = lista.Where(e => e.rol.ToString().Equals(rol, StringComparison.OrdinalIgnoreCase)).ToArray();

            Session["usuarios"] = lista;
            gvUsuarios.DataSource = lista;
            gvUsuarios.DataBind();
        }

        protected void IrNuevoUsuario(object sender, EventArgs e)
        {
            Response.Redirect("agregar-usuario.aspx");
        }

        protected void gvUsuarios_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvUsuarios.PageIndex = e.NewPageIndex;

            // Recuperar la lista de usuarios desde la sesión
            var lista = Session["usuarios"];  // O tipo adecuado según tu lista

            gvUsuarios.DataSource = lista;  // Actualizar el GridView
            gvUsuarios.DataBind();  // Renderizar la tabla
        }

        protected void gvUsuarios_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                bool estado = Convert.ToBoolean(DataBinder.Eval(e.Row.DataItem, "Activo"));
                e.Row.Cells[3].Text = estado ? "Activo" : "Inactivo";

                // Si está inactivo, desactiva el botón eliminar
                if (!estado)
                {
                    LinkButton btnEliminar = (LinkButton)e.Row.FindControl("btnEliminar");
                    if (btnEliminar != null)
                    {
                        btnEliminar.Enabled = false;
                        btnEliminar.CssClass = "btn btn-sm btn-secondary disabled";
                        btnEliminar.OnClientClick = "";  // Quita el confirm
                    }
                }
            }
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            boUsuario = new UsuarioWSClient();
            var lista = boUsuario.listarUsuario();
            int idUsuario = Int32.Parse(((LinkButton)sender).CommandArgument);
            usuario usuarioSeleccionado = lista.SingleOrDefault(x => x.idUsuario == idUsuario);
            Session["usuarioSeleccionado"] = usuarioSeleccionado;
            Response.Redirect("agregar-usuario.aspx?accion=modificar");
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            var boton = (LinkButton)sender;
            int idUsuario = Int32.Parse(boton.CommandArgument);

            boUsuario = new UsuarioWSClient();
            var lista = boUsuario.listarUsuario();
            var usuario = lista.FirstOrDefault(u => u.idUsuario == idUsuario);

            if (usuario != null && !usuario.activo)
            {
                string script = "alert('Este usuario ya se encuentra inactivo.');";
                ScriptManager.RegisterStartupScript(this, GetType(), "UsuarioInactivo", script, true);
                return;
            }

            // Eliminar (inactivar) usuario
            boUsuario.eliminarUsuarioPorId(idUsuario);

            // Refrescar lista
            var listaActualizada = boUsuario.listarUsuario();
            Session["usuarios"] = listaActualizada;
            gvUsuarios.DataSource = listaActualizada;
            gvUsuarios.DataBind();

            // Evitar reenvío accidental
            Response.Redirect("usuarios.aspx");
        }

        protected void txtBuscar_TextChanged(object sender, EventArgs e)
        {
            string filtro = txtBuscar.Text.Trim();
            string estado = ddlEstado.SelectedValue; 
            string rol = ddlRol.SelectedValue;
            CargarUsuarios(filtro, estado, rol);
        }

        protected void ddlEstado_SelectedIndexChanged(object sender, EventArgs e)
        {
            string filtro = txtBuscar.Text.Trim();
            string estado = ddlEstado.SelectedValue;
            string rol = ddlRol.SelectedValue;
            CargarUsuarios(filtro, estado, rol);
        }
        protected void ddlRol_SelectedIndexChanged(object sender, EventArgs e)
        {
            string filtro = txtBuscar.Text.Trim();
            string estado = ddlEstado.SelectedValue;
            string rol = ddlRol.SelectedValue;
            CargarUsuarios(filtro, estado, rol);
        }
    }
}