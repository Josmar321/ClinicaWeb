// ModificarPersona.aspx.cs
using ClinicaWeb.ServiciosWS;
using System;
using System.IO;
using System.Linq;
using System.Web.UI.WebControls;

namespace ClinicaWeb.admin
{
    public partial class ModificarPersona : System.Web.UI.Page
    {
        private PacienteWSClient boPaciente = new PacienteWSClient();
        private MedicoWSClient boMedico = new MedicoWSClient();
        private AdministradorWSClient boAdministrador = new AdministradorWSClient();
        private CiudadWSClient boCiudad = new CiudadWSClient();
        private DepartamentoWSClient boDepartamento = new DepartamentoWSClient();
        private EspecialidadWSClient boEspecialidad = new EspecialidadWSClient();
        private TipoDeSangreWSClient boTipoSangre = new TipoDeSangreWSClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarDepartamentos();
                CargarEspecialidades();
                CargarTipoDeSangre();

                string id = Request.QueryString["id"];
                string rol = Request.QueryString["rol"];
                Session["rolSeleccionado"] = rol;
                Session["idPersona"] = id;

                MostrarPanelSegunRol();

                switch (rol)
                {
                    case "PACIENTE":
                        var paciente = boPaciente.obtenerPacientePorId(id);
                        CargarDatosPaciente(paciente);
                        break;
                    case "MEDICO":
                        var medico = boMedico.obtenerMedicoPorId(id);
                        CargarDatosMedico(medico);
                        break;
                    case "ADMINISTRADOR":
                        var admin = boAdministrador.obtenerAdministradorPorId(id);
                        CargarDatosAdministrador(admin);
                        break;
                }
            }
        }

        private void MostrarPanelSegunRol()
        {
            string rol = Session["rolSeleccionado"].ToString();
            pnlPaciente.Visible = rol == "PACIENTE";
            pnlMedico.Visible = rol == "MEDICO";
            pnlAdministrador.Visible = rol == "ADMINISTRADOR";
        }

        protected void ddlDepartamento_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlDepartamento.SelectedValue != "")
                CargarCiudades(Convert.ToInt32(ddlDepartamento.SelectedValue));
        }

        private void CargarDepartamentos()
        {
            ddlDepartamento.Items.Clear();
            //ddlDepartamento.Items.Add(new ListItem("Seleccione un departamento", ""));
            foreach (var dep in boDepartamento.listarDepartamentos())
            {
                ddlDepartamento.Items.Add(new ListItem(dep.nombre, dep.id.ToString()));
            }
        }

        private void CargarCiudades(int departamentoId)
        {
            var ciudades = boCiudad.listarCiudades()
                .Where(c => c.departamento.id == departamentoId)
                .ToList();
            ddlCiudad.Items.Clear();
            ddlCiudad.Items.Add(new ListItem("Seleccione una ciudad", ""));
            foreach (var c in ciudades)
                ddlCiudad.Items.Add(new ListItem(c.nombre, c.id.ToString()));
        }

        private void CargarEspecialidades()
        {
            ddlEspecialidad.Items.Clear();
            //ddlEspecialidad.Items.Add(new ListItem("Seleccione especialidad", ""));
            foreach (var esp in boEspecialidad.listarEspecialidad())
                ddlEspecialidad.Items.Add(new ListItem(esp.nombre, esp.idEspecialidad.ToString()));
        }

        private void CargarTipoDeSangre()
        {
            ddlTipoSangre.Items.Clear();
            //ddlTipoSangre.Items.Add(new ListItem("Seleccione tipo de sangre", ""));
            foreach (var ts in boTipoSangre.listarTipoSangre())
                ddlTipoSangre.Items.Add(new ListItem(ts.tipo, ts.id.ToString()));
        }

        private void CargarDatosPaciente(paciente p)
        {
            txtDocIdentidad.Text = p.docIdentidad;
            txtNombre.Text = p.nombre;
            txtPrimerApellido.Text = p.primerApellido;
            txtSegundoApellido.Text = p.segundoApellido;
            txtTelefono.Text = p.telefono;
            txtDireccion.Text = p.direccion;
            txtEmail.Text = p.email;
            txtFechaNacimiento.Text = p.fechaNacimiento.ToString("yyyy-MM-dd");
            ddlSexo.SelectedValue = p.sexo.ToString();
            ddlDepartamento.SelectedValue = p.departamento.id.ToString();
            CargarCiudades(p.departamento.id);
            ddlCiudad.SelectedValue = p.ciudad.id.ToString();
            ddlTipoSangre.SelectedValue = p.tipoSangre.id.ToString();
            txtPeso.Text = p.peso.ToString();
            txtAltura.Text = p.altura.ToString();
        }

        private void CargarDatosMedico(medico m)
        {
            txtDocIdentidad.Text = m.docIdentidad;
            txtNombre.Text = m.nombre;
            txtPrimerApellido.Text = m.primerApellido;
            txtSegundoApellido.Text = m.segundoApellido;
            txtTelefono.Text = m.telefono;
            txtDireccion.Text = m.direccion;
            txtEmail.Text = m.email;
            txtFechaNacimiento.Text = m.fechaNacimiento.ToString("yyyy-MM-dd");
            ddlSexo.SelectedValue = m.sexo.ToString();
            ddlDepartamento.SelectedValue = m.departamento.id.ToString();
            CargarCiudades(m.departamento.id);
            ddlCiudad.SelectedValue = m.ciudad.id.ToString();
            txtNumeroColegiatura.Text = m.numeroColegiatura;
            ddlEspecialidad.SelectedValue = m.especialidad.idEspecialidad.ToString();
        }

        private void CargarDatosAdministrador(administrador a)
        {
            txtDocIdentidad.Text = a.docIdentidad;
            txtNombre.Text = a.nombre;
            txtPrimerApellido.Text = a.primerApellido;
            txtSegundoApellido.Text = a.segundoApellido;
            txtTelefono.Text = a.telefono;
            txtDireccion.Text = a.direccion;
            txtEmail.Text = a.email;
            txtFechaNacimiento.Text = a.fechaNacimiento.ToString("yyyy-MM-dd");
            ddlSexo.SelectedValue = a.sexo.ToString();
            ddlDepartamento.SelectedValue = a.departamento.id.ToString();
            CargarCiudades(a.departamento.id);
            ddlCiudad.SelectedValue = a.ciudad.id.ToString();
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            string rol = Session["rolSeleccionado"].ToString();

            if (rol == "PACIENTE")
            {
                Response.Redirect("pacientes.aspx");
            }
            else if (rol == "MEDICO")
            {
                Response.Redirect("medicos.aspx");
            }
            else if (rol == "ADMINISTRADOR")
            {
                Response.Redirect("administradores.aspx");
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            string rol = Session["rolSeleccionado"].ToString();
            string id = Session["idPersona"].ToString();

            // Lógica de actualización para cada rol
            if (rol == "PACIENTE")
            {
                var p = boPaciente.obtenerPacientePorId(id);
                p.nombre = txtNombre.Text;
                p.primerApellido = txtPrimerApellido.Text;
                p.segundoApellido = txtSegundoApellido.Text;
                p.telefono = txtTelefono.Text;
                p.direccion = txtDireccion.Text;
                p.email = txtEmail.Text;
                p.fechaNacimiento = DateTime.Parse(txtFechaNacimiento.Text);
                p.sexo = ddlSexo.SelectedValue[0];
                p.ciudad = new ciudad { id = int.Parse(ddlCiudad.SelectedValue) };
                p.departamento = new departamento { id = int.Parse(ddlDepartamento.SelectedValue) };
                p.tipoSangre = new tipoDeSangre { id = int.Parse(ddlTipoSangre.SelectedValue) };
                p.peso = double.Parse(txtPeso.Text);
                p.altura = double.Parse(txtAltura.Text);

                if (fileFoto.HasFile &&
                    (fileFoto.PostedFile.ContentType == "image/jpeg" ||
                     fileFoto.PostedFile.ContentType == "image/png"))
                {
                    using (var binaryReader = new BinaryReader(fileFoto.PostedFile.InputStream))
                    {
                        p.foto = binaryReader.ReadBytes(fileFoto.PostedFile.ContentLength);
                    }
                }

                boPaciente.modificarPaciente(p);
                Response.Redirect("pacientes.aspx");
            }
            else if (rol == "MEDICO")
            {
                var m = boMedico.obtenerMedicoPorId(id);

                m.nombre = txtNombre.Text;
                m.primerApellido = txtPrimerApellido.Text;
                m.segundoApellido = txtSegundoApellido.Text;
                m.telefono = txtTelefono.Text;
                m.direccion = txtDireccion.Text;
                m.email = txtEmail.Text;
                m.fechaNacimiento = DateTime.Parse(txtFechaNacimiento.Text);
                m.sexo = ddlSexo.SelectedValue[0];
                m.ciudad = new ciudad { id = int.Parse(ddlCiudad.SelectedValue) };
                m.departamento = new departamento { id = int.Parse(ddlDepartamento.SelectedValue) };
                m.numeroColegiatura = txtNumeroColegiatura.Text;
                m.especialidad = new especialidad { idEspecialidad = int.Parse(ddlEspecialidad.SelectedValue) };

                if (fileFoto.HasFile &&
                    (fileFoto.PostedFile.ContentType == "image/jpeg" ||
                     fileFoto.PostedFile.ContentType == "image/png"))
                {
                    using (var binaryReader = new BinaryReader(fileFoto.PostedFile.InputStream))
                    {
                        m.foto = binaryReader.ReadBytes(fileFoto.PostedFile.ContentLength);
                    }
                }

                boMedico.modificarMedico(m);
                Response.Redirect("medicos.aspx");
            }
            else if (rol == "ADMINISTRADOR")
            {
                var a = boAdministrador.obtenerAdministradorPorId(id);
                a.nombre = txtNombre.Text;
                a.primerApellido = txtPrimerApellido.Text;
                a.segundoApellido = txtSegundoApellido.Text;
                a.telefono = txtTelefono.Text;
                a.direccion = txtDireccion.Text;
                a.email = txtEmail.Text;
                a.fechaNacimiento = DateTime.Parse(txtFechaNacimiento.Text);
                a.sexo = ddlSexo.SelectedValue[0];
                a.ciudad = new ciudad { id = int.Parse(ddlCiudad.SelectedValue) };
                a.departamento = new departamento { id = int.Parse(ddlDepartamento.SelectedValue) };

                if (fileFoto.HasFile &&
                    (fileFoto.PostedFile.ContentType == "image/jpeg" ||
                     fileFoto.PostedFile.ContentType == "image/png"))
                {
                    using (var binaryReader = new BinaryReader(fileFoto.PostedFile.InputStream))
                    {
                        a.foto = binaryReader.ReadBytes(fileFoto.PostedFile.ContentLength);
                    }
                }


                boAdministrador.modificarAdministrador(a);
                Response.Redirect("administradores.aspx");
            }
        }
    }
}
