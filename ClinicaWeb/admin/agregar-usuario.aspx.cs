using ClinicaWeb.ServiciosWS;
using System;
using System.Web.UI;

namespace ClinicaWeb.admin
{
    public partial class agregar_usuario : Page
    {
        private UsuarioWSClient boUsuario;
        private Estado estado;
        private usuario usuario;
        protected void Page_Load(object sender, EventArgs e)
        {
            string accion = Request.QueryString["accion"];

            if (!IsPostBack)
            {
                if (accion == null)
                {
                    estado = Estado.Nuevo;
                    usuario = new usuario();
                    lblTitulo.Text = "Registrar Usuario";
                    panelEstado.Visible = false; // Ocultar dropdown de estado al registrar
                    Session["estadoActual"] = estado;
                    btnGuardar.Text = "<i class='fa-solid fa-arrow-right me-1'></i> Siguiente";
                }
                else if (accion == "modificar")
                {
                    estado = Estado.Modificar;
                    lblTitulo.Text = "Modificar Usuario";
                    usuario = (usuario)Session["usuarioSeleccionado"];

                    // Mostrar valores en los campos
                    txtIDUsuario.Text = usuario.idUsuario.ToString();
                    txtUsername.Text = usuario.username;
                    ddlRol.SelectedValue = usuario.rol.ToString();
                    ddlEstado.SelectedValue = usuario.activo ? "Activo" : "Inactivo";

                    panelEstado.Visible = true; // Mostrar solo en modificación

                    // Guardar en sesión el estado actual
                    Session["estadoActual"] = estado;
                    btnGuardar.Text = "<i class='fa-solid fa-floppy-disk me-1'></i> Guardar";
                }
            }
            else
            {
                // Recuperar el estado para postback
                estado = (Estado)Session["estadoActual"];
            }
        }


        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            // Validación de campos vacíos
            bool camposVacios = string.IsNullOrWhiteSpace(txtUsername.Text) || string.IsNullOrWhiteSpace(ddlRol.SelectedValue);
            if (estado == Estado.Nuevo)
                camposVacios = camposVacios || string.IsNullOrWhiteSpace(txtPassword.Text);

            if (camposVacios)
            {
                string script = "alert('Por favor complete todos los campos antes de guardar.');";
                ScriptManager.RegisterStartupScript(this, GetType(), "alertCamposIncompletos", script, true);
                return;
            }

            boUsuario = new UsuarioWSClient();

            // ✅ Recuperar el usuario desde sesión si es modificación
            if (estado == Estado.Modificar)
            {
                usuario = (usuario)Session["usuarioSeleccionado"];
            }
            else
            {
                usuario = new usuario();
                usuario.activo = true; // por defecto activo al registrar
            }

            usuario.username = txtUsername.Text;
            Session["usuarioUsername"] = usuario.username;
            if (!string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                usuario.password = txtPassword.Text; // solo actualiza si se ingresa una nueva
                Session["usuarioPassword"] = usuario.password; // Guardar la contraseña en sesión
            }

            usuario.activo = (ddlEstado.SelectedValue == "Activo");

            try
            {
                Session["rolSeleccionado"] = ddlRol.SelectedValue; // Guardar el rol seleccionado en sesión
                if (estado == Estado.Nuevo)
                {
                    Session["usuarioGuardar"] = usuario;
                    int idUsuario = boUsuario.insertarUsuario(usuario, ddlRol.SelectedValue);
                    Session["idUsario"] = idUsuario;
                    Response.Redirect("RegistroPersona.aspx");
                }
                else
                {
                    boUsuario.modificarUsuario(usuario, ddlRol.SelectedValue);
                    Response.Redirect("usuarios.aspx");
                }
            }
            catch (Exception ex)
            {
                lblMensajeError.Text = ex.Message;
                string script = "mostrarModalError();";
                ScriptManager.RegisterStartupScript(this, GetType(), "modalError", script, true);
                return;
            }
        }



        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            Response.Redirect("usuarios.aspx");
        }
        
        protected void IrConfiguracionCuenta(object sender, EventArgs e)
        {
            Response.Redirect("configuracion-cuenta.aspx");
        }

        protected void IrCerrarSesion(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("cerrarSesion.aspx");
        }

        protected void IrNuevoUsuario(object sender, EventArgs e)
        {
            Response.Redirect("agregar-usuario.aspx");
        }
    }
}