using System;
using ClinicaWeb.ServiciosWS;

namespace ClinicaWeb.admin
{
    public partial class admin_perfil : System.Web.UI.Page
    {
        private AdministradorWSClient ws = new AdministradorWSClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string codigoAdmin = Request.QueryString["codigoAdmin"];
                if (!string.IsNullOrEmpty(codigoAdmin))
                {
                    var admin = ws.obtenerAdministradorPorId(codigoAdmin);
                    if (admin != null)
                    {
                        lblNombreCompleto.Text = $"{admin.nombre} {admin.primerApellido} {admin.segundoApellido}";
                        lblCodigo.Text = admin.docIdentidad;
                        lblEmail.Text = admin.email;
                        lblTelefono.Text = admin.telefono;
                        lblDireccion.Text = admin.direccion;
                        lblGenero.Text = admin.sexo == 'M' ? "Masculino" : "Femenino";
                        lblFechaNacimiento.Text = admin.fechaNacimiento.ToShortDateString();
                        lblEstado.Text = admin.activo ? "Activo" : "Inactivo";
                    }
                }
            }
        }

        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            Response.Redirect("administradores.aspx");
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            // Aquí puedes implementar redirección al formulario de edición
            string codigo = lblCodigo.Text;
            Session["rolSeleccionado"] = "ADMINISTRADOR";
            Response.Redirect($"ModificarPersona.aspx?rol=ADMINISTRADOR&id={codigo}");
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            string codigo = lblCodigo.Text;
            ws.eliminarAdministrador(codigo);
            Response.Redirect("administradores.aspx");
        }
    }
}
