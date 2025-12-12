using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ClinicaWeb.ServiciosWS;
namespace ClinicaWeb.admin
{
    public partial class especialidades : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                CargarEspecialidades();
        }

        private void CargarEspecialidades(string filtro = "", string estado = "")
        {
            EspecialidadWSClient client = new EspecialidadWSClient();
            var lista = client.listarEspecialidad();

            if (!string.IsNullOrWhiteSpace(filtro))
                lista = lista.Where(e => e.nombre.IndexOf(filtro, StringComparison.OrdinalIgnoreCase) >= 0).ToArray();

            if (!string.IsNullOrWhiteSpace(estado))
            {
                bool activo = estado == "activo";
                lista = lista.Where(e => Convert.ToBoolean(e.activo) == activo).ToArray();
            }

            rptEspecialidades.DataSource = lista;
            rptEspecialidades.DataBind();
        }

        protected void IrNuevaEspecialidad(object sender, EventArgs e)
        {
            Response.Redirect("nueva-especialidad.aspx");
        }

        protected void rptEspecialidades_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Editar")
            {
                string id = e.CommandArgument.ToString();
                Response.Redirect("nueva-especialidad.aspx?id=" + id);
            }
            else if (e.CommandName == "VerMedicos")
            {
                int idEspecialidad = Convert.ToInt32(e.CommandArgument);
                EspecialidadWSClient client = new EspecialidadWSClient();
                var lista = client.listarEspecialidad();
                var nombreEspecialidad= lista.Where(a => a.idEspecialidad == idEspecialidad).ToArray()[0].nombre;

                CargarMedicosPorEspecialidad(idEspecialidad);

                // Script para mostrar el modal y actualizar el título
                ScriptManager.RegisterStartupScript(
                    this,
                    this.GetType(),
                    "mostrarModal",
                    $@"document.getElementById('modalMedicosLabel').innerText = 'Médicos de {nombreEspecialidad}';
                       var modal = new bootstrap.Modal(document.getElementById('modalMedicos')); 
                       modal.show();",
                    true
                );
            }
        }

        private void CargarMedicosPorEspecialidad(int idEspecialidad)
        {
            MedicoWSClient client = new MedicoWSClient();
            var medicos = client.listarMedico();
            // Filtrar los médicos por el id de especialidad
            var medicosFiltrados = medicos.Where(m => m.especialidad.idEspecialidad == idEspecialidad).ToArray();
            
            rptMedicos.DataSource = medicosFiltrados;
            rptMedicos.DataBind();
        }

        protected void txtBuscar_TextChanged(object sender, EventArgs e)
        {
            string filtro = txtBuscar.Text.Trim();
            string estado = ddlEstado.SelectedValue;
            CargarEspecialidades(filtro, estado);
        }

        protected void ddlEstado_SelectedIndexChanged(object sender, EventArgs e)
        {
            string filtro = txtBuscar.Text.Trim();
            string estado = ddlEstado.SelectedValue;
            CargarEspecialidades(filtro, estado);
        }
    }
}