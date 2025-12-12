
using ClinicaWeb.ServiciosWS;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ClinicaWeb.admin
{
    public partial class nueva_especialidad : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string id = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(id))
                {
                    // Modo edición
                    CargarEspecialidad(Convert.ToInt32(id));
                }
                else
                {
                    // Modo registro
                    txtIdEspecialidad.Text = ObtenerSiguienteId().ToString();
                }
            }
        }

        private void CargarEspecialidad(int id)
        {
            // Instanciar el cliente del servicio SOAP
            EspecialidadWSClient client = new EspecialidadWSClient();

            try
            {
                // Llamar al servicio y obtener la lista de especialidades
                var especialidades = client.listarEspecialidad(); 

                // Buscar la especialidad con el ID deseado
                var especialidad = especialidades.FirstOrDefault(e => e.idEspecialidad == id);

                if (especialidad != null)
                {
                    txtIdEspecialidad.Text = especialidad.idEspecialidad.ToString();
                    txtNombre.Text = especialidad.nombre;
                    if (especialidad.activo)
                        ddlEstado.SelectedValue = "1";
                    else ddlEstado.SelectedValue = "0";
                }
                else
                {
                    //lblMensaje.Text = "Especialidad no encontrada.";
                    System.Console.WriteLine("Especialidad no encontrada en cargar");
                }
            }
            catch (Exception ex)
            {
                //lblMensaje.Text = "Error al cargar especialidad: " + ex.Message;
                System.Console.WriteLine("Error al cargar especialidad en cargar: " + ex.Message);
            }
        }


        private int ObtenerSiguienteId()
        {
            EspecialidadWSClient client = new EspecialidadWSClient();

            try
            {
                var especialidades = client.listarEspecialidad();
                if (especialidades.Length == 0)
                    return 1;
                else
                    return especialidades.Max(e => e.idEspecialidad) + 1;
            }
            catch
            {
                return -1;
            }
        }


    
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                string id = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(id))
                {
                    // Actualizar
                    ActualizarEspecialidad(Convert.ToInt32(id));
                }
                else
                {
                    // Insertar
                    InsertarEspecialidad();
                }
                Response.Redirect("especialidades.aspx");
            }
            catch (Exception ex)
            {
                System.Console.WriteLine("Error al cargar especialidad: " + ex.Message);
            }
        }

        private void InsertarEspecialidad()
        {
            // Instanciar el cliente del servicio SOAP
            EspecialidadWSClient client = new EspecialidadWSClient();

            try
            {
                
                especialidad nuevaEspecialidad = new especialidad();
                nuevaEspecialidad.idEspecialidad = Int32.Parse(txtIdEspecialidad.Text);
                nuevaEspecialidad.nombre = txtNombre.Text;
                nuevaEspecialidad.activo = ddlEstado.SelectedValue == "1" ? true : false;
                client.insertarEspecialidad(nuevaEspecialidad);
                //Response.Redirect("especialidades.aspx");
            }
            catch (Exception ex)
            {
                System.Console.WriteLine("Error al cargar especialidad al insertar: " + ex.Message);
            }
        }

        private void ActualizarEspecialidad(int id)
        {
            EspecialidadWSClient client = new EspecialidadWSClient();

            try
            {
                especialidad esp = new especialidad();
                esp.idEspecialidad = id;
                esp.nombre = txtNombre.Text;
                esp.activo = ddlEstado.SelectedValue == "1"? true :false;

                client.modificarEspecialidad(esp); // Este método debe existir en tu servicio
            }
            catch (Exception ex)
            {
                System.Console.WriteLine("Error al cargar especialidad: " + ex.Message);
            }
        }


        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("especialidades.aspx");
        }
    }
}