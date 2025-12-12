using ClinicaWeb.ServiciosWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ClinicaWeb.admin
{
    public partial class AdminMaster : System.Web.UI.MasterPage
    {
        private PersonaWSClient boPersona;
        private UsuarioWSClient boUsuario;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Usuario"] == null || Session["rol"] == null || Session["rol"].ToString() != "ADMINISTRADOR")
            {
                if (Session["Usuario"] == null)
                {
                    Response.Redirect("~/InicioSesion.aspx");
                    return;
                }

                string rol = Session["rol"]?.ToString();

                if (rol != "ADMINISTRADOR")
                {
                    switch (rol)
                    {
                        case "PACIENTE":
                            Response.Redirect("~/patient/dashboard.aspx");
                            break;
                        case "MEDICO":
                            Response.Redirect("~/doctor/dashboard.aspx");
                            break;
                        default:
                            Response.Redirect("~/dashboard.aspx");
                            break;
                    }
                }
            }

            // Verificar si es la primera carga de la página
            if (!IsPostBack)
            {
                // Configurar el nombre del administrador en la sesión si no existe
                if (Session["NombreAdmin"] == null)
                {
                    boUsuario = new UsuarioWSClient();
                    boPersona = new PersonaWSClient();
                    int id = boUsuario.obtenerUsuarioPorUsername(Session["Usuario"]?.ToString());
                    string nombre = boPersona.obtenerNombreXIdUser(id);
                    
                    Session["NombreAdmin"] = nombre ?? "Administrador";
                }

                // Cargar la foto del administrador
                cargarFoto();

                
            }
        }

        /// <summary>
        /// Carga la foto del administrador desde la base de datos
        /// </summary>
        private void cargarFoto()
        {
            try
            {
                boPersona = new PersonaWSClient();
                boUsuario = new UsuarioWSClient();
                int id = boUsuario.obtenerUsuarioPorUsername(Session["Usuario"]?.ToString());
                
                byte[] fotoBytes = boPersona.obtenerFotoXUser(id);
                
                if (fotoBytes != null && fotoBytes.Length > 0)
                {
                    // Convertir bytes a base64 para mostrar en la imagen
                    string base64String = Convert.ToBase64String(fotoBytes);
                    string imageUrl = "data:image/jpeg;base64," + base64String;
                    
                    // Guardar la URL de la imagen en ViewState para acceder desde el frontend
                    ViewState["FotoAdmin"] = imageUrl;
                }
                else
                {
                    ViewState["FotoAdmin"] = null;
                }
            }
            catch (Exception ex)
            {
                // Si hay error al cargar la foto, no mostrar nada
                ViewState["FotoAdmin"] = null;
                System.Diagnostics.Debug.WriteLine($"Error al cargar foto del administrador: {ex.Message}");
            }
        }
        

        
        #region Navegación del Menú Principal

        protected void btnDashboard_Click(object sender, EventArgs e)
        {
            try
            {
                RegistrarActividad("Navegó al Dashboard");
                Response.Redirect("dashboard.aspx");
            }
            catch (Exception ex)
            {
                // Log del error
                System.Diagnostics.Debug.WriteLine($"Error en btnDashboard_Click: {ex.Message}");
                Response.Redirect("dashboard.aspx");
            }
        }

        protected void btnUsuarios_Click(object sender, EventArgs e)
        {
            try
            {
                RegistrarActividad("Navegó a Gestión de Usuarios");
                Response.Redirect("usuarios.aspx");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error en btnUsuarios_Click: {ex.Message}");
                Response.Redirect("usuarios.aspx");
            }
        }

        protected void btnPersonas_Click(object sender, EventArgs e)
        {
            try
            {
                RegistrarActividad("Navegó a Gestión de Personas");
                Response.Redirect("personas.aspx");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error en btnPersonas_Click: {ex.Message}");
                Response.Redirect("personas.aspx");
            }
        }

        protected void btnAdministradores_Click(object sender, EventArgs e)
        {
            try
            {
                RegistrarActividad("Navegó a Gestión de Administradores");
                Response.Redirect("administradores.aspx");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error en btnAdministradores_Click: {ex.Message}");
                Response.Redirect("administradores.aspx");
            }
        }

        protected void btnMedicos_Click(object sender, EventArgs e)
        {
            try
            {
                RegistrarActividad("Navegó a Gestión de Médicos");
                Response.Redirect("medicos.aspx");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error en btnMedicos_Click: {ex.Message}");
                Response.Redirect("medicos.aspx");
            }
        }

        protected void btnPacientes_Click(object sender, EventArgs e)
        {
            try
            {
                RegistrarActividad("Navegó a Gestión de Pacientes");
                Response.Redirect("pacientes.aspx");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error en btnPacientes_Click: {ex.Message}");
                Response.Redirect("pacientes.aspx");
            }
        }

        protected void btnEspecialidades_Click(object sender, EventArgs e)
        {
            try
            {
                RegistrarActividad("Navegó a Gestión de Especialidades");
                Response.Redirect("especialidades.aspx");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error en btnEspecialidades_Click: {ex.Message}");
                Response.Redirect("especialidades.aspx");
            }
        }

        protected void btnLocales_Click(object sender, EventArgs e)
        {
            try
            {
                RegistrarActividad("Navegó a Gestión de Locales");
                Response.Redirect("locales.aspx");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error en btnLocales_Click: {ex.Message}");
                Response.Redirect("locales.aspx");
            }
        }

        protected void btnReportes_Click(object sender, EventArgs e)
        {
            try
            {
                RegistrarActividad("Navegó a Reportes");
                Response.Redirect("reportes.aspx");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error en btnReportes_Click: {ex.Message}");
                Response.Redirect("reportes.aspx");
            }
        }

        protected void btnConfiguracion_Click(object sender, EventArgs e)
        {
            try
            {
                RegistrarActividad("Navegó a Configuración");
                Response.Redirect("configuracion.aspx");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error en btnConfiguracion_Click: {ex.Message}");
                Response.Redirect("configuracion.aspx");
            }
        }

        #endregion

        #region Funciones del Perfil de Administrador

        protected void IrConfigCuenta(object sender, EventArgs e)
        {
            try
            {
                RegistrarActividad("Accedió a Configuración de Cuenta");
                // Redirigir a la página de configuración de cuenta del administrador
                Response.Redirect("admin-perfil.aspx");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error en IrConfigCuenta: {ex.Message}");
                // Fallback a dashboard si hay error
                Response.Redirect("dashboard.aspx");
            }
        }

        protected void CerrarSesion(object sender, EventArgs e)
        {
            try
            {
                RegistrarActividad("Cerro sesión");
                // Limpiar todas las variables de sesión
                Session.Clear();
                Session.Abandon();
                
                // Invalidar la cookie de autenticación si existe
                if (Request.Cookies["ASP.NET_SessionId"] != null)
                {
                    HttpCookie cookie = new HttpCookie("ASP.NET_SessionId");
                    cookie.Expires = DateTime.Now.AddDays(-1);
                    Response.Cookies.Add(cookie);
                }

                // Redirigir a la página de inicio de sesión
                Response.Redirect("../InicioSesion.aspx");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error en CerrarSesion: {ex.Message}");
                // Forzar la redirección incluso si hay error
                Response.Redirect("../InicioSesion.aspx");
            }
        }

        #endregion

        #region Funciones de Utilidad

        /// <summary>
        /// Obtiene el nombre del administrador actual
        /// </summary>
        public string GetNombreAdmin()
        {
            return Session["NombreAdmin"]?.ToString() ?? "Administrador";
        }

        /// <summary>
        /// Obtiene el ID del usuario administrador actual
        /// </summary>
        public string GetUsuarioId()
        {
            return Session["Usuario"]?.ToString() ?? "";
        }

        /// <summary>
        /// Verifica si el usuario actual es administrador
        /// </summary>
        public bool EsAdministrador()
        {
            return Session["rol"]?.ToString() == "ADMINISTRADOR";
        }

        /// <summary>
        /// Obtiene el rol del usuario actual
        /// </summary>
        public string GetRolUsuario()
        {
            return Session["rol"]?.ToString() ?? "";
        }

        /// <summary>
        /// Verifica si la sesión está activa
        /// </summary>
        public bool SesionActiva()
        {
            return Session["Usuario"] != null && Session["rol"] != null;
        }

        /// <summary>
        /// Registra una actividad del administrador (para auditoría)
        /// </summary>
        public void RegistrarActividad(string actividad)
        {
            try
            {
                string usuario = GetUsuarioId();
                string timestamp = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                
                // Aquí podrías implementar el logging a una base de datos
                System.Diagnostics.Debug.WriteLine($"Actividad Admin - Usuario: {usuario}, Actividad: {actividad}, Timestamp: {timestamp}");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error al registrar actividad: {ex.Message}");
            }
        }

        /// <summary>
        /// Muestra un mensaje de alerta usando SweetAlert2
        /// </summary>
        public void MostrarAlerta(string titulo, string mensaje, string tipo = "info")
        {
            string script = $@"
                Swal.fire({{
                    title: '{titulo}',
                    text: '{mensaje}',
                    icon: '{tipo}',
                    confirmButtonText: 'Aceptar'
                }});
            ";
            
            ScriptManager.RegisterStartupScript(this, GetType(), "Alerta", script, true);
        }

        /// <summary>
        /// Muestra un mensaje de confirmación
        /// </summary>
        public void MostrarConfirmacion(string titulo, string mensaje, string funcionConfirmacion)
        {
            string script = $@"
                Swal.fire({{
                    title: '{titulo}',
                    text: '{mensaje}',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Sí, continuar',
                    cancelButtonText: 'Cancelar'
                }}).then((result) => {{
                    if (result.isConfirmed) {{
                        {funcionConfirmacion}
                    }}
                }});
            ";
            
            ScriptManager.RegisterStartupScript(this, GetType(), "Confirmacion", script, true);
        }

        #endregion

        #region Funciones de Navegación Adicional

        /// <summary>
        /// Redirige a la página de registro de persona
        /// </summary>
        public void IrRegistroPersona()
        {
            try
            {
                RegistrarActividad("Navegó a Registro de Persona");
                Response.Redirect("RegistroPersona.aspx");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error en IrRegistroPersona: {ex.Message}");
                Response.Redirect("RegistroPersona.aspx");
            }
        }

        /// <summary>
        /// Redirige a la página de agregar usuario
        /// </summary>
        public void IrAgregarUsuario()
        {
            try
            {
                RegistrarActividad("Navegó a Agregar Usuario");
                Response.Redirect("agregar-usuario.aspx");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error en IrAgregarUsuario: {ex.Message}");
                Response.Redirect("agregar-usuario.aspx");
            }
        }

        /// <summary>
        /// Redirige a la página de agregar médico
        /// </summary>
        public void IrAgregarMedico()
        {
            try
            {
                RegistrarActividad("Navegó a Agregar Médico");
                Response.Redirect("agregar-medico.aspx");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error en IrAgregarMedico: {ex.Message}");
                Response.Redirect("agregar-medico.aspx");
            }
        }

        /// <summary>
        /// Redirige a la página de nueva especialidad
        /// </summary>
        public void IrNuevaEspecialidad()
        {
            try
            {
                RegistrarActividad("Navegó a Nueva Especialidad");
                Response.Redirect("nueva-especialidad.aspx");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error en IrNuevaEspecialidad: {ex.Message}");
                Response.Redirect("nueva-especialidad.aspx");
            }
        }

        /// <summary>
        /// Redirige a la página de nuevo local
        /// </summary>
        public void IrNuevoLocal()
        {
            try
            {
                RegistrarActividad("Navegó a Nuevo Local");
                Response.Redirect("nuevo-local.aspx");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error en IrNuevoLocal: {ex.Message}");
                Response.Redirect("nuevo-local.aspx");
            }
        }

        #endregion
    }
}