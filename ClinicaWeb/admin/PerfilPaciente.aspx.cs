using System;
using ClinicaWeb.ServiciosWS;

namespace ClinicaWeb.admin
{
    public partial class PerfilPaciente : System.Web.UI.Page
    {
        private PacienteWSClient ws = new PacienteWSClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string codigoPaciente = Request.QueryString["doc"];
                if (!string.IsNullOrEmpty(codigoPaciente))
                {
                    var paciente = ws.obtenerPacientePorId(codigoPaciente);
                    if (paciente != null)
                    {
                        lblNombreCompleto.Text = $"{paciente.nombre} {paciente.primerApellido} {paciente.segundoApellido}";
                        lblCodigo.Text = paciente.docIdentidad;
                        lblEmail.Text = paciente.email;
                        lblTelefono.Text = paciente.telefono;
                        lblDireccion.Text = paciente.direccion;
                        lblGenero.Text = paciente.sexo == 'M' ? "Masculino" : "Femenino";
                        lblFechaNacimiento.Text = paciente.fechaNacimiento.ToShortDateString();
                        lblEstado.Text = paciente.activo ? "Activo" : "Inactivo";

                        lblPeso.Text = paciente.peso.ToString("0.0") + " kg";
                        lblAltura.Text = paciente.altura.ToString("0.00") + " m";
                        lblTipoSangre.Text = paciente.tipoSangre?.tipo ?? "Sin especificar";
                        lblCiudad.Text = paciente.ciudad?.nombre ?? "No asignada";
                        lblDepartamento.Text = paciente.departamento?.nombre ?? "No asignado";
                    }
                }
            }
        }

        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            Response.Redirect("pacientes.aspx");
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            string codigo = lblCodigo.Text;
            Session["rolSeleccionado"] = "PACIENTE";
            Response.Redirect($"ModificarPersona.aspx?rol=PACIENTE&id={codigo}");
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            string codigo = lblCodigo.Text;
            ws.eliminarPaciente(codigo);
            Response.Redirect("pacientes.aspx");
        }
    }
}
