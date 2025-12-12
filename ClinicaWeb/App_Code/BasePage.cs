using System;
using System.Web.UI;

namespace ClinicaWeb
{
    public class BasePage : Page
    {
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            VerificarAutenticacion();
        }

        protected void VerificarAutenticacion()
        {
            if (Session["Usuario"] == null)
            {
                // Si no hay sesión activa, redirigir al login
                Response.Redirect("~/InicioSesion.aspx");
                return;
            }

            // Obtener la ruta actual
            string currentPath = Request.Path.ToLower();
            
            // Verificar el rol del usuario
            string rol = Session["Rol"]?.ToString()?.ToLower();
            
            // Verificar acceso según el rol
            if (!TieneAcceso(currentPath, rol))
            {
                Response.Redirect("~/InicioSesion.aspx");
            }
        }

        private bool TieneAcceso(string path, string rol)
        {
            if (string.IsNullOrEmpty(rol)) return false;

            // Definir las rutas permitidas para cada rol
            switch (rol)
            {
                case "admin":
                    return path.Contains("/admin/");
                case "doctor":
                    return path.Contains("/doctor/");
                case "paciente":
                    return path.Contains("/paciente/");
                default:
                    return false;
            }
        }
    }
} 