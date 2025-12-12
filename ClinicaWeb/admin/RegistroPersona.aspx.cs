using ClinicaWeb.ServiciosWS;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebGrease.Activities;
using SendGrid;
using SendGrid.Helpers.Mail;

namespace ClinicaWeb.admin
{
    public partial class RegistroPersona : System.Web.UI.Page
    {
        private PersonaWSClient boPersona;
        private PacienteWSClient boPaciente;
        private MedicoWSClient boMedico;
        private AdministradorWSClient boAdministrador;
        private EspecialidadWSClient boEspecialidad;
        private medico medico;
        private administrador admin;
        private paciente paciente;
        private CiudadWSClient boCiudad;
        private DepartamentoWSClient boDepartamento;
        
        private TipoDeSangreWSClient boTipoSangre;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarDepartamentos();
                CargarEspecialidades();
                CargarTipoDeSangre();
                MostrarPanelSegunRol();
               
            }
        }

        

        protected void ddlDepartamento_SelectedIndexChanged(object sender, EventArgs e)
        {
            
            if (ddlDepartamento.SelectedValue != "")
            {
                CargarCiudades(Convert.ToInt32(ddlDepartamento.SelectedValue));
            }
            else
            {
                ddlCiudad.Items.Clear();
                ddlCiudad.Items.Insert(0, new ListItem("Seleccione ciudad", ""));
            }
            
        }

        private void MostrarPanelSegunRol()
        {

            string rol = Session["rolSeleccionado"].ToString();
            

            switch (rol)
            {
                case "PACIENTE":
                    pnlPaciente.Visible = true;
                    break;
                case "MEDICO":
                    pnlMedico.Visible = true;
                    break;
                case "ADMINISTRADOR":
                    pnlAdministrador.Visible = true;
                    break;
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
        private void CargarEspecialidades()
        {
            boEspecialidad = new EspecialidadWSClient();
            var especialidades = boEspecialidad.listarEspecialidad();

            ddlEspecialidad.Items.Clear();
            ddlEspecialidad.Items.Add(new ListItem("Seleccione especialidad", ""));

            foreach (var esp in especialidades)
            {
                ddlEspecialidad.Items.Add(new ListItem(esp.nombre, esp.idEspecialidad.ToString()));
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
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                if (!ValidarFormulario())
                {
                    return;
                }

                string rol = Session["rolSeleccionado"].ToString();
                
                // Insertar según el rol
                switch (rol)
                {
                    case "PACIENTE":
                        boPaciente = new PacienteWSClient();
                        InsertarPaciente();
                        break;
                    case "MEDICO":
                        boMedico = new MedicoWSClient();
                        InsertarMedico();
                        break;
                    case "ADMINISTRADOR":
                        boAdministrador = new AdministradorWSClient();
                        InsertarAdministrador();
                        break;
                    default:
                        MostrarMensaje("Rol no válido", false);
                        return;
                }

                // Solo redirigir si no hubo errores
                if (string.IsNullOrEmpty(lblMensaje.Text) || lblMensaje.CssClass.Contains("success"))
                {
                    Response.Redirect("~/admin/usuarios.aspx");
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al guardar: " + ex.Message, false);
            }
        }

        private bool ValidarFormulario()
        {
            
            if (string.IsNullOrEmpty(txtDocIdentidad.Text))
            {
                MostrarMensaje("El documento de identidad es requerido", false);
                return false;
            }

            if (string.IsNullOrEmpty(txtNombre.Text))
            {
                MostrarMensaje("El nombre es requerido", false);
                return false;
            }

            if (string.IsNullOrEmpty(txtPrimerApellido.Text))
            {
                MostrarMensaje("El primer apellido es requerido", false);
                return false;
            }

            if (string.IsNullOrEmpty(txtEmail.Text))
            {
                MostrarMensaje("El email es requerido", false);
                return false;
            }

            if (string.IsNullOrEmpty(txtFechaNacimiento.Text))
            {
                MostrarMensaje("La fecha de nacimiento es requerida", false);
                return false;
            }

            if (ddlSexo.SelectedValue == "")
            {
                MostrarMensaje("El sexo es requerido", false);
                return false;
            }

            if (ddlDepartamento.SelectedValue == "")
            {
                MostrarMensaje("El departamento es requerido", false);
                return false;
            }

            if (ddlCiudad.SelectedValue == "")
            {
                MostrarMensaje("La ciudad es requerida", false);
                return false;
            }

            string rol = Session["rolSeleccionado"].ToString();
            switch (rol)
            {
                case "PACIENTE":
                    if (ddlTipoSangre.SelectedValue == "")
                    {
                        MostrarMensaje("El tipo de sangre es requerido", false);
                        return false;
                    }
                    if (string.IsNullOrEmpty(txtPeso.Text))
                    {
                        MostrarMensaje("El peso es requerido", false);
                        return false;
                    }
                    if (string.IsNullOrEmpty(txtAltura.Text))
                    {
                        MostrarMensaje("La altura es requerida", false);
                        return false;
                    }
                    break;
                case "MEDICO":
                    if (string.IsNullOrEmpty(txtNumeroColegiatura.Text))
                    {
                        MostrarMensaje("El número de colegiatura es requerido", false);
                        return false;
                    }
                    if (ddlEspecialidad.SelectedValue == "")
                    {
                        MostrarMensaje("La especialidad es requerida", false);
                        return false;
                    }
                    break;
            }

            return true;
            
        }
        private void InsertarPaciente()
        {
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
                Task.Run(async () =>
                {
                    await EnviarCorreoCredencialesAsync(paciente.email, paciente.nombre, 
                        Session["usuarioUsername"].ToString(), Session["usuarioPassword"].ToString(), Session["rolSeleccionado"].ToString());
                });
                MostrarMensaje("Paciente registrado exitosamente", true);
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al registrar paciente: " + ex.Message, false);
            }
        }

        private void InsertarMedico()
        {
            try
            {
                medico = new medico();
                medico.docIdentidad = txtDocIdentidad.Text;
                medico.nombre = txtNombre.Text;
                medico.primerApellido = txtPrimerApellido.Text;
                medico.segundoApellido = txtSegundoApellido.Text;
                medico.telefono = txtTelefono.Text;
                medico.direccion = txtDireccion.Text;
                medico.email = txtEmail.Text;
                
                string fechaTexto = txtFechaNacimiento.Text;
                DateTime fechaNacimiento;
                if (DateTime.TryParse(fechaTexto, out fechaNacimiento))
                {
                    medico.fechaNacimiento = fechaNacimiento;
                    medico.fechaNacimientoSpecified = true;
                }
                else
                {
                    MostrarMensaje("La fecha ingresada no es válida.", false);
                    return;
                }
                
                medico.sexo = ddlSexo.SelectedValue[0];
                medico.activo = true;

                // Manejo correcto de la foto
                byte[] fotoBytes = ConvertirImagenABytes();
                medico.foto = fotoBytes ?? new byte[0];


                medico.departamento = new departamento();
                medico.departamento.id = int.Parse(ddlDepartamento.SelectedValue);
                medico.ciudad = new ciudad();
                medico.ciudad.id = int.Parse(ddlCiudad.SelectedValue);

                medico.usuario = new usuario();
                medico.usuario.idUsuario = Convert.ToInt32(Session["idUsario"]);
                medico.numeroColegiatura = txtNumeroColegiatura.Text;
                medico.especialidad = new especialidad();
                medico.especialidad.idEspecialidad = int.Parse(ddlEspecialidad.SelectedValue);

                boMedico = new MedicoWSClient();
                boMedico.insertarMedico(medico);
                Task.Run(async () =>
                {
                    await EnviarCorreoCredencialesAsync(medico.email, medico.nombre,
                        Session["usuarioUsername"].ToString(), Session["usuarioPassword"].ToString(), Session["rolSeleccionado"].ToString());
                });
                MostrarMensaje("Médico registrado exitosamente", true);
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al registrar médico: " + ex.Message, false);
            }
        }

        private void InsertarAdministrador()
        {
            try
            {
                admin = new administrador();
                admin.docIdentidad = txtDocIdentidad.Text;
                admin.nombre = txtNombre.Text;
                admin.primerApellido = txtPrimerApellido.Text;
                admin.segundoApellido = txtSegundoApellido.Text;
                admin.telefono = txtTelefono.Text;
                admin.direccion = txtDireccion.Text;
                admin.email = txtEmail.Text;
                
                string fechaTexto = txtFechaNacimiento.Text;
                DateTime fechaNacimiento;
                if (DateTime.TryParse(fechaTexto, out fechaNacimiento))
                {
                    admin.fechaNacimiento = fechaNacimiento;
                    admin.fechaNacimientoSpecified = true;
                }
                else
                {
                    MostrarMensaje("La fecha ingresada no es válida.", false);
                    return;
                }
                
                admin.sexo = ddlSexo.SelectedValue[0];
                admin.activo = true;

                // Manejo correcto de la foto
                byte[] fotoBytes = ConvertirImagenABytes();
                admin.foto = fotoBytes ?? new byte[0];

                admin.departamento = new departamento();
                admin.departamento.id = int.Parse(ddlDepartamento.SelectedValue);
                admin.ciudad = new ciudad();
                admin.ciudad.id = int.Parse(ddlCiudad.SelectedValue);

                admin.usuario = new usuario();
                admin.usuario.idUsuario = Convert.ToInt32(Session["idUsario"]);
                
                boAdministrador.insertarAdministrador(admin);
                Task.Run(async () =>
                {
                    await EnviarCorreoCredencialesAsync(admin.email, admin.nombre,
                        Session["usuarioUsername"].ToString(), Session["usuarioPassword"].ToString(), Session["rolSeleccionado"].ToString());
                });
                MostrarMensaje("Administrador registrado exitosamente", true);
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al registrar administrador: " + ex.Message, false);
            }
        }

        private void LimpiarFormulario()
        { 
            /*
            txtDocIdentidad.Text = "";
            txtNombre.Text = "";
            txtPrimerApellido.Text = "";
            txtSegundoApellido.Text = "";
            txtTelefono.Text = "";
            txtDireccion.Text = "";
            txtEmail.Text = "";
            txtFechaNacimiento.Text = "";
            ddlSexo.SelectedIndex = 0;
            ddlDepartamento.SelectedIndex = 0;
            ddlCiudad.Items.Clear();
            ddlCiudad.Items.Insert(0, new ListItem("Seleccione ciudad", ""));
            fileFoto.Dispose();

            if (pnlPaciente.Visible)
            {
                ddlTipoSangre.SelectedIndex = 0;
                txtPeso.Text = "";
                txtAltura.Text = "";
            }
            else if (pnlMedico.Visible)
            {
                txtNumeroColegiatura.Text = "";
            }*/
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            // Verificar si es registro de paciente
            if (Session["registroPaciente"] != null && (bool)Session["registroPaciente"])
            {
                Response.Redirect("../InicioSesion.aspx");
            }
            else
            {
                Response.Redirect("~/admin/usuarios.aspx");
            }
        }

        private void MostrarMensaje(string mensaje, bool esExito)
        {
            lblMensaje.Text = mensaje;
            lblMensaje.CssClass = "message-result " + (esExito ? "success" : "error");
            lblMensaje.Visible = true;
        }

        private async Task EnviarCorreoCredencialesAsync(string correoDestino,string nombreDestino,string usuario,string contrasena, string rol) {

            var apiKey = "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";
            var client = new SendGridClient(apiKey);

            var from = new EmailAddress("nelvier200@gmail.com", "NEOSALUD");
            var subject = "Credenciales de acceso - NEOSALUD";
            var to = new EmailAddress(correoDestino, nombreDestino);
            var plainTextContent = $"Se registró su usuario en la clínica privada NEOSALUD. Usuario: {usuario} - Contraseña: {contrasena}";
            var htmlContent = @"
            <div style='font-family: Arial, sans-serif; max-width: 600px; margin: auto; border: 1px solid #e0e0e0; border-radius: 8px; padding: 20px; background-color: #f9f9f9;'>
              <h2 style='color: #2c3e50;'>👨‍⚕️ Bienvenido a NEOSALUD</h2>
              <p>Hola <strong>{nombre}</strong>,</p>
              <p>Su usuario ha sido registrado exitosamente con el rol de <strong>{rol}</strong>.</p>

              <div style='background-color: #ffffff; padding: 15px; border: 1px solid #dcdcdc; border-radius: 6px; margin-top: 20px;'>
                <p style='margin: 0 0 10px 0;'><strong>👤 Usuario:</strong> {usuario}</p>
                <p style='margin: 0 0 10px 0;'><strong>🔒 Contraseña:</strong> {contrasena}</p>
              </div>

              <p style='margin-top: 20px;'>Le recomendamos cambiar su contraseña luego de iniciar sesión por primera vez.</p>

              <p style='margin-top: 30px; font-size: 0.9em; color: #888;'>Este es un mensaje automático, por favor no responder.</p>
              <p style='font-size: 0.9em; color: #888;'>NEOSALUD - Plataforma de gestión médica</p>
            </div>";
            htmlContent = htmlContent.Replace("{nombre}", nombreDestino)
                         .Replace("{usuario}", usuario)
                         .Replace("{contrasena}", contrasena)
                         .Replace("{rol}",rol);

            var msg = MailHelper.CreateSingleEmail(from, to, subject, plainTextContent, htmlContent);

            var response = await client.SendEmailAsync(msg);

            Console.WriteLine($"Resultado: {response.StatusCode}");

        }
    }
}