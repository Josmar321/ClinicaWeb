using System;
using ClinicaWeb.ServiciosWS;

namespace ClinicaWeb.admin
{
    public partial class PerfilMedico : System.Web.UI.Page
    {
        private MedicoWSClient wsMedico = new MedicoWSClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string codigo = Request.QueryString["codigoMedico"];
                if (!string.IsNullOrEmpty(codigo))
                    CargarDatos(codigo);
            }
        }

        private void CargarDatos(string codigo)
        {
            var medico = wsMedico.obtenerMedicoPorId(codigo);
            if (medico == null) return;

            lblNombreCompleto.Text = "Dr. " + medico.nombre + " " + medico.primerApellido + " " + medico.segundoApellido;
            lblCodigo.Text = medico.codigoMedico ?? "-";
            lblEmail.Text = medico.email ?? "-";
            lblColegiatura.Text = medico.numeroColegiatura ?? "-";
            lblTelefono.Text = medico.telefono ?? "-";
            lblDireccion.Text = medico.direccion ?? "-";
            lblGenero.Text = medico.sexo == 'M' ? "Masculino" : medico.sexo == 'F' ? "Femenino" : "-";
            lblFechaNacimiento.Text = medico.fechaNacimiento.ToShortDateString();
            lblEstado.Text = medico.activo ? "Activo" : "Inactivo";
            lblEspecialidad.Text = medico.especialidad?.nombre ?? "-";
        }

        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            Response.Redirect("medicos.aspx");
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            string codigo = lblCodigo.Text;
            Session["rolSeleccionado"] = "MEDICO";
            Response.Redirect($"ModificarPersona.aspx?rol=MEDICO&id={codigo}");
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            string codigo = Request.QueryString["codigoMedico"];
            if (!string.IsNullOrEmpty(codigo))
            {
                wsMedico.eliminarMedico(codigo);
                Response.Redirect("medicos.aspx");
            }
        }
    }
}
