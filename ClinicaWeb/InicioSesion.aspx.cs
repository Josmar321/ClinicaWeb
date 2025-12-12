using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using ClinicaWeb.ServiciosWS;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace ClinicaWeb
{
    public partial class InicioSesion : System.Web.UI.Page
    {
        private UsuarioWSClient usuarioWS = new UsuarioWSClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Verificar si hay una sesión activa
                if (Session["Usuario"] != null)
                {
                    // Si ya hay un usuario en sesión, redirigir al dashboard correspondiente
                    string rol = Session["rol"] as string;
                    if (rol != null)
                    {
                        RedirigirSegunRol(rol);
                    }
                }
                else
                {
                    // Si no hay sesión, asegurarse de que el formulario de inicio de sesión esté visible
                    HtmlGenericControl loginForm = (HtmlGenericControl)FindControl("loginForm");
                    if (loginForm != null)
                    {
                        loginForm.Visible = true;
                    }
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string usuario = Request.Form["usuario"];
            string contraseña = Request.Form["contraseña"];

            string resultado = ValidarCredenciales(usuario, contraseña);
            if (resultado != null) // Si la validación fue exitosa
            {
                // Guardar información del usuario en la sesión
                Session["Usuario"] = usuario;
                
                // Redirigir según el rol
                RedirigirSegunRol(resultado);
            }
            else
            {
                // Mostrar mensaje de error
                ScriptManager.RegisterStartupScript(this, GetType(), "ErrorLogin", 
                    "alert('Usuario o contraseña incorrectos');", true);
            }
        }

        private void RedirigirSegunRol(string rol)
        {
            
            switch (rol)
            {
                case "ADMINISTRADOR":
                    Session["rol"] = "ADMINISTRADOR"; // Guardar el rol en la sesión
                    Response.Redirect("admin/dashboard.aspx");
                    break;
                case "MEDICO":
                    Session["rol"] = "MEDICO"; // Guardar el rol en la sesión
                    Response.Redirect("doctor/dashboard.aspx");
                    break;
                case "PACIENTE":
                    Session["rol"] = "PACIENTE"; // Guardar el rol en la sesión
                    Response.Redirect("patient/dashboard.aspx");
                    break;
                default:
                    Response.Redirect("InicioSesion.aspx");
                    break;
            }
        }
        
        private string ValidarCredenciales(string usuario, string contraseña)
        {
            UsuarioWSClient boUsuario = new UsuarioWSClient();
            try
            {
                string rol = boUsuario.verificarUsuario(usuario, contraseña);
                if (rol != null)
                {
                    return rol;
                }
                else
                {
                    //System.Diagnostics.Debug.WriteLine("Usuario o contraseña incorrectos");
                    return null;
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error en validación: {ex.Message}");
                return null;
            }
        }
    }
}