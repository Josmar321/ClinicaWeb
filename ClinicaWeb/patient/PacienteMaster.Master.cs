using ClinicaWeb.ServiciosWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ClinicaWeb.patient
{
    public partial class PacienteMaster : System.Web.UI.MasterPage
    {
        private PersonaWSClient boPersona;
        private UsuarioWSClient boUsuario;
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!IsPostBack)
            {
                
                if (Session["Usuario"] == null || Session["rol"]?.ToString() != "PACIENTE")
                {
                    string rol = Session["rol"]?.ToString();
                    switch (rol)
                    {
                        case "MEDICO":
                            Response.Redirect("~/doctor/dashboard.aspx");
                            break;
                        case "ADMINISTRADOR":
                            Response.Redirect("~/admin/dashboard.aspx");
                            break;
                        default:
                            Response.Redirect("~/InicioSesion.aspx");
                            break;
                    }

                }
                if (Session["NombrePaciente"] == null)
                {
                    boUsuario = new UsuarioWSClient();
                    boPersona = new PersonaWSClient();
                    int id = boUsuario.obtenerUsuarioPorUsername(Session["Usuario"]?.ToString());
                    string nombre = boPersona.obtenerNombreXIdUser(id);

                    Session["NombrePaciente"] = nombre ?? "Paciente";
                }
                cargarFoto();
            }
        }
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
                    ViewState["FotoPaciente"] = imageUrl;
                }
                else
                {
                    ViewState["FotoPaciente"] = null;
                }
            }
            catch (Exception ex)
            {
                // Si hay error al cargar la foto, no mostrar nada
                ViewState["FotoPaciente"] = null;
                System.Diagnostics.Debug.WriteLine($"Error al cargar foto del administrador: {ex.Message}");
            }
        }
        protected void IrInicio(object sender, EventArgs e) => Response.Redirect("dashboard.aspx");
        protected void IrCitas(object sender, EventArgs e) => Response.Redirect("citas.aspx");
        protected void IrHistorial(object sender, EventArgs e) => Response.Redirect("historial.aspx");
        protected void IrMedicos(object sender, EventArgs e) => Response.Redirect("medicos.aspx");
        protected void IrNotificaciones(object sender, EventArgs e)
        {
            Response.Redirect("notificaciones.aspx");
        }

        protected void IrPerfilPaciente(object sender, EventArgs e)
        {
            Response.Redirect("perfilPaciente.aspx");
        }

        protected void CerrarSesion(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("../InicioSesion.aspx");
        }
    }
}