using ClinicaWeb.ServiciosWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ClinicaWeb.doctor
{
    public partial class DoctorMaster : System.Web.UI.MasterPage
    {
        private PersonaWSClient boPersona;
        private UsuarioWSClient boUsuario;
        protected void Page_Load(object sender, EventArgs e)
        {
          
            if (!IsPostBack)
            {
                
                if (Session["Usuario"] == null || Session["rol"]?.ToString() != "MEDICO")
                {
                    string rol = Session["rol"]?.ToString();
                    switch (rol)
                    {
                        case "PACIENTE":
                            Response.Redirect("~/patient/dashboard.aspx");
                            break;
                        case "ADMINISTRADOR":
                            Response.Redirect("~/admin/dashboard.aspx");
                            break;
                        default:
                            Response.Redirect("~/InicioSesion.aspx");
                            break;
                    }
                    
                }
                
                if (Session["NombreDoctor"] == null)
                {
                    boUsuario = new UsuarioWSClient();
                    boPersona = new PersonaWSClient();
                    int id = boUsuario.obtenerUsuarioPorUsername(Session["Usuario"]?.ToString());
                    string nombre = boPersona.obtenerNombreXIdUser(id);

                    Session["NombreDoctor"] = nombre ?? "Doctor";
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
                    ViewState["FotoDoctor"] = imageUrl;
                }
                else
                {
                    ViewState["FotoDoctor"] = null;
                }
            }
            catch (Exception ex)
            {
                // Si hay error al cargar la foto, no mostrar nada
                ViewState["FotoDoctor"] = null;
            }
        }
        protected void IrDashboard(object sender, EventArgs e) => Response.Redirect("dashboard.aspx");
        protected void IrAgenda(object sender, EventArgs e) => Response.Redirect("agenda.aspx");
        protected void IrPacientes(object sender, EventArgs e) => Response.Redirect("pacientes.aspx");
        protected void IrDiagnosticos(object sender, EventArgs e)
        {
            Response.Redirect("~/doctor/GestionDiagnosticos.aspx");
        }
        protected void IrHistorial(object sender, EventArgs e)
        {
            Response.Redirect("~/doctor/GestionHistorialClinico.aspx");
        }
        protected void IrHorarios(object sender, EventArgs e) => Response.Redirect("horarios.aspx");
        protected void IrReportes(object sender, EventArgs e) => Response.Redirect("reportes.aspx");
        protected void IrNotificaciones(object sender, EventArgs e)
        {
            Response.Redirect("notificaciones.aspx");
        }

        protected void IrConfigCuenta(object sender, EventArgs e)
        {
            Response.Redirect("configuracionCuenta.aspx");
        }

        protected void CerrarSesion(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("../InicioSesion.aspx");
        }
    }
}
