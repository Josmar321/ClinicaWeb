using ClinicaWeb.ServiciosWS;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace ClinicaWeb
{
    public partial class RegistroPersonaPaciente : System.Web.UI.Page
    {
        private PersonaWSClient persona;
        private PacienteWSClient boPaciente;
        private CiudadWSClient boCiudad;
        private DepartamentoWSClient boDepartamento;
        private TipoDeSangreWSClient boTipoSangre;
        private EspecialidadWSClient boEspecialidad;
        private paciente paciente;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Verificar que el usuario esté en sesión
                if (Session["idUsario"] == null)
                {
                    Response.Redirect("InicioSesion.aspx");
                    return;
                }

                InicializarServicios();
                CargarDepartamentos();
                CargarTipoDeSangre();
            }
        }

        private void InicializarServicios()
        {
           /* persona = new PersonaWSClient();
            bopaciente = new PacienteWSClient();
            boCiudad = new CiudadWSClient();
            departamento = new DepartamentoWSClient();
            tipoSangre = new TipoDeSangreWSClient();*/
        }

        private void CargarTipoDeSangre()
        {
            boTipoSangre = new TipoDeSangreWSClient();
            var tiposSangre = boTipoSangre.listarTipoSangre();
            ddlTipoSangre.Items.Clear();
            ddlTipoSangre.Items.Add(new ListItem("Seleccion tipo de sangre", ""));
            foreach (var tipo in tiposSangre)
            {
                ddlTipoSangre.Items.Add(new ListItem(tipo.tipo, tipo.id.ToString()));
            }
        }
    
        private void CargarDepartamentos()
        {
            boDepartamento = new DepartamentoWSClient();
            var departamentos = boDepartamento.listarDepartamentos();

            ddlDepartamento.Items.Clear();
            ddlDepartamento.Items.Add(new ListItem("Seleccione un departamento", ""));

            foreach (var dep in departamentos)
            {
                ddlDepartamento.Items.Add(new ListItem(dep.nombre, dep.id.ToString()));
            }
        }
        private void CargarCiudades(int departamentoId)
        {
            boCiudad = new CiudadWSClient();
            var lista = boCiudad.listarCiudades();
            var ciudades = lista.Where(e => e.departamento.id == departamentoId).ToArray();

            ddlCiudad.Items.Clear();
            ddlCiudad.Items.Add(new ListItem("Seleccione una ciudad", ""));

            foreach (var ciudad in ciudades)
            {
                ddlCiudad.Items.Add(new ListItem(ciudad.nombre, ciudad.id.ToString()));
            }
        }


        protected void ddlDepartamento_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(ddlDepartamento.SelectedValue))
            {
                CargarCiudades(int.Parse(ddlDepartamento.SelectedValue));
            }
            else
            {
                ddlCiudad.Items.Clear();
                ddlCiudad.Items.Add(new ListItem("Seleccione ciudad", ""));
            }
        }

        private byte[] ConvertirImagenABytes()
        {
            if (fileFoto.HasFile)
            {
                try
                {
                    // Validar el tipo de archivo
                    string extension = Path.GetExtension(fileFoto.FileName).ToLower();
                    string[] extensionesPermitidas = { ".jpg", ".jpeg", ".png", ".gif", ".bmp" };

                    if (!extensionesPermitidas.Contains(extension))
                    {
                        MostrarMensaje("Solo se permiten archivos de imagen (JPG, PNG, GIF, BMP)", false);
                        return null;
                    }

                    // Validar el tamaño del archivo (máximo 5MB)
                    if (fileFoto.PostedFile.ContentLength > 5 * 1024 * 1024)
                    {
                        MostrarMensaje("El archivo es demasiado grande. Máximo 5MB permitido.", false);
                        return null;
                    }

                    using (Stream fs = fileFoto.PostedFile.InputStream)
                    {
                        using (BinaryReader br = new BinaryReader(fs))
                        {
                            return br.ReadBytes((Int32)fs.Length);
                        }
                    }
                }
                catch (Exception ex)
                {
                    MostrarMensaje("Error al procesar la imagen: " + ex.Message, false);
                    return null;
                }
            }
            return null;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (!ValidarCampos())
            {
                return;
            }

            try
            {
                paciente = new paciente();
                paciente.docIdentidad = txtDocIdentidad.Text;
                paciente.nombre = txtNombre.Text;
                paciente.primerApellido = txtPrimerApellido.Text;
                paciente.segundoApellido = txtSegundoApellido.Text;
                paciente.telefono = txtTelefono.Text;
                paciente.direccion = txtDireccion.Text;
                paciente.email = txtEmail.Text;

                string fechaTexto = txtFechaNacimiento.Text;
                DateTime fechaNacimiento;
                if (DateTime.TryParse(fechaTexto, out fechaNacimiento))
                {
                    paciente.fechaNacimiento = fechaNacimiento;
                    paciente.fechaNacimientoSpecified = true;
                }
                else
                {
                    MostrarMensaje("La fecha ingresada no es válida.", false);
                    return;
                }

                paciente.sexo = ddlSexo.SelectedValue[0];
                paciente.activo = true;

                // Manejo correcto de la foto
                byte[] fotoBytes = ConvertirImagenABytes();
                paciente.foto = fotoBytes ?? new byte[0];

                paciente.departamento = new departamento();
                paciente.departamento.id = int.Parse(ddlDepartamento.SelectedValue);
                paciente.ciudad = new ciudad();
                paciente.ciudad.id = int.Parse(ddlCiudad.SelectedValue);

                paciente.usuario = new usuario();
                paciente.usuario.idUsuario = Convert.ToInt32(Session["idUsario"]);
                paciente.peso = Convert.ToDouble(txtPeso.Text);
                paciente.altura = Convert.ToDouble(txtAltura.Text);
                paciente.tipoSangre = new tipoDeSangre
                {
                    id = int.Parse(ddlTipoSangre.SelectedValue)
                };


                boPaciente = new PacienteWSClient();
                boPaciente.insertarPaciente(paciente);
             /*   Task.Run(async () =>
                {
                    await EnviarCorreoCredencialesAsync(paciente.email, paciente.nombre,
                        Session["usuarioUsername"].ToString(), Session["usuarioPassword"].ToString(), Session["rolSeleccionado"].ToString());
                });*/
                MostrarMensaje("Paciente registrado exitosamente", true);
                
                // Limpiar sesión
                Session.Remove("idUsario");
                Session.Remove("usuarioUsername");
                Session.Remove("usuarioPassword");
                Session.Remove("rolSeleccionado");
                
                // Redirigir al inicio de sesión después de 3 segundos
                string script = "setTimeout(function() { window.location.href = 'InicioSesion.aspx'; }, 3000);";
                ScriptManager.RegisterStartupScript(this, GetType(), "redirect", script, true);
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al registrar paciente: " + ex.Message, false);
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            // Limpiar sesión y redirigir
            Session.Remove("idUsario");
            Session.Remove("usuarioUsername");
            Session.Remove("usuarioPassword");
            Response.Redirect("InicioSesion.aspx");
        }

        private bool ValidarCampos()
        {
            // Validar campos requeridos
            if (string.IsNullOrWhiteSpace(txtDocIdentidad.Text) ||
                string.IsNullOrWhiteSpace(txtNombre.Text) ||
                string.IsNullOrWhiteSpace(txtPrimerApellido.Text) ||
                string.IsNullOrWhiteSpace(txtTelefono.Text) ||
                string.IsNullOrWhiteSpace(txtDireccion.Text) ||
                string.IsNullOrWhiteSpace(txtEmail.Text) ||
                string.IsNullOrWhiteSpace(txtFechaNacimiento.Text) ||
                ddlSexo.SelectedValue == "" ||
                ddlDepartamento.SelectedValue == "" ||
                ddlCiudad.SelectedValue == "" ||
                ddlTipoSangre.SelectedValue == "" ||
                string.IsNullOrWhiteSpace(txtPeso.Text) ||
                string.IsNullOrWhiteSpace(txtAltura.Text))
            {
                MostrarMensaje("Por favor complete todos los campos requeridos.", false);
                return false;
            }

            // Validar email
            if (!System.Text.RegularExpressions.Regex.IsMatch(txtEmail.Text, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
            {
                MostrarMensaje("Por favor ingrese un email válido.", false);
                return false;
            }

            // Validar peso y altura
            if (!double.TryParse(txtPeso.Text, out double peso) || peso <= 0)
            {
                MostrarMensaje("Por favor ingrese un peso válido.", false);
                return false;
            }

            if (!double.TryParse(txtAltura.Text, out double altura) || altura <= 0)
            {
                MostrarMensaje("Por favor ingrese una altura válida.", false);
                return false;
            }

            return true;
        }

        private void MostrarMensaje(string mensaje, bool esExitoso)
        {
            lblMensaje.Text = mensaje;
            lblMensaje.CssClass = esExitoso ? "message-result success" : "message-result error";
            lblMensaje.Visible = true;
        }
    }
}