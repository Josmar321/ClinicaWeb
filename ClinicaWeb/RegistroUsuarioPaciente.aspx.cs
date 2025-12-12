using ClinicaWeb.ServiciosWS;
using System;
using System.Web.UI;

namespace ClinicaWeb
{
    public partial class RegistroUsuarioPaciente : Page
    {
        private UsuarioWSClient boUsuario;
        private usuario usuario;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Inicializar para nuevo registro
                usuario = new usuario();
                Session["estadoActual"] = Estado.Nuevo;
            }
            else
            {
                // Recuperar el estado para postback
                Session["estadoActual"] = Estado.Nuevo;
            }
        }

        protected void btnSiguiente_Click(object sender, EventArgs e)
        {
            // Validación de campos vacíos
            bool camposVacios = string.IsNullOrWhiteSpace(txtUsername.Text) || 
                               string.IsNullOrWhiteSpace(txtPassword.Text) || 
                               string.IsNullOrWhiteSpace(txtConfirmPassword.Text);

            if (camposVacios)
            {
                string script = "alert('Por favor complete todos los campos antes de continuar.');";
                ScriptManager.RegisterStartupScript(this, GetType(), "alertCamposIncompletos", script, true);
                return;
            }

            // Validar que las contraseñas coincidan
            if (txtPassword.Text != txtConfirmPassword.Text)
            {
                string script = "alert('Las contraseñas no coinciden. Por favor verifique.');";
                ScriptManager.RegisterStartupScript(this, GetType(), "alertContraseñasNoCoinciden", script, true);
                return;
            }

            boUsuario = new UsuarioWSClient();

            usuario = new usuario();
            usuario.username = txtUsername.Text;
            usuario.password = txtPassword.Text;
            usuario.activo = true; // por defecto activo al registrar

            try
            {
                // Guardar el rol como PACIENTE en sesión
                Session["rolSeleccionado"] = "PACIENTE";
                Session["usuarioGuardar"] = usuario;
                
                // Insertar usuario
                int idUsuario = boUsuario.insertarUsuario(usuario, "PACIENTE");
                Session["idUsario"] = idUsuario;
                Session["usuarioUsername"] = usuario.username;
                Session["usuarioPassword"] = usuario.password;
                
                // Redirigir a registro de persona
                Response.Redirect("RegistroPersonaPaciente.aspx");
            }
            catch (Exception ex)
            {
                string script = $"alert('Error al registrar usuario: {ex.Message}');";
                ScriptManager.RegisterStartupScript(this, GetType(), "alertError", script, true);
                return;
            }
        }
    }
} 