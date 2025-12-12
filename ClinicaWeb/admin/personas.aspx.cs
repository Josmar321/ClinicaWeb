using ClinicaWeb.ServiciosWS;
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ClinicaWeb.admin
{   

    public partial class personas : System.Web.UI.Page
    {
        private AdministradorWSClient boAdmin = new AdministradorWSClient();
        private MedicoWSClient boMedico = new MedicoWSClient();
        private PacienteWSClient boPaciente = new PacienteWSClient();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                CargarPersonas();
            }
        }

        private void CargarPersonas(string filtro = "", string estado = "", string rol = "")
        {
            boAdmin = new AdministradorWSClient();
            boMedico = new MedicoWSClient();
            boPaciente = new PacienteWSClient();
            var listaFinal = new List<PersonaResumen>();

            // Administradores
            var admins = boAdmin.listarAdministrador();
            foreach (var a in admins)
            {
                listaFinal.Add(new PersonaResumen
                {
                    DocIdentidad = a.docIdentidad,
                    NombreCompleto = $"{a.nombre} {a.primerApellido} {a.segundoApellido}",
                    Activo = a.activo,
                    Rol = "ADMINISTRADOR"
                });
            }
            
            // Médicos
            var medicos = boMedico.listarMedico();
            foreach (var m in medicos)
            {
                listaFinal.Add(new PersonaResumen
                {
                    DocIdentidad = m.docIdentidad,
                    NombreCompleto = $"{m.nombre} {m.primerApellido} {m.segundoApellido}",
                    Activo = m.activo,
                    Rol = "MEDICO"
                });
            }
            
            
            // Pacientes
            var pacientes = boPaciente.listarPaciente();
            foreach (var p in pacientes)
            {
                listaFinal.Add(new PersonaResumen
                {
                    DocIdentidad = p.docIdentidad,
                    NombreCompleto = $"{p.nombre} {p.primerApellido} {p.segundoApellido}",
                    Activo = p.activo,
                    Rol = "PACIENTE"
                });
            }

            // Filtrar por estado si se especifica
            if (!string.IsNullOrWhiteSpace(estado))
            {
                bool estadoBool = estado == "activo";
                listaFinal = listaFinal.Where(p => p.Activo == estadoBool).ToList();
            }

            // Filtrar por rol si se especifica
            if (!string.IsNullOrWhiteSpace(rol))
            {
                listaFinal = listaFinal.Where(p => p.Rol.Equals(rol, StringComparison.OrdinalIgnoreCase)).ToList();
            }
            //Buscador
            if (!string.IsNullOrWhiteSpace(filtro))
            {
                listaFinal = listaFinal
                    .Where(e =>
                        e.DocIdentidad.IndexOf(filtro, StringComparison.OrdinalIgnoreCase) >= 0 ||
                        e.NombreCompleto.IndexOf(filtro, StringComparison.OrdinalIgnoreCase) >= 0
                    )
                    .ToList();
            }



            gvPersonas.DataSource = listaFinal;
            gvPersonas.DataBind();
            Session["personas"] = listaFinal;
        }


        protected void IrNuevaPersona(object sender, EventArgs e)
        {
            Response.Redirect("agregar-persona.aspx");
        }

        protected void gvPersonas_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvPersonas.PageIndex = e.NewPageIndex;

            // Recuperar la lista de usuarios desde la sesión
            var lista = Session["personas"];  // O tipo adecuado según tu lista

            gvPersonas.DataSource = lista;  // Actualizar el GridView
            gvPersonas.DataBind();  // Renderizar la tabla
        }

        protected void gvPersonas_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                e.Row.Cells[1].Text = DataBinder.Eval(e.Row.DataItem, "NombreCompleto").ToString();
                bool estado = Convert.ToBoolean(DataBinder.Eval(e.Row.DataItem, "Activo"));
                e.Row.Cells[3].Text = estado ? "Activo" : "Inactivo";

                // Si está inactivo, desactiva el botón eliminar
                if (!estado)
                {
                    LinkButton btnEliminar = (LinkButton)e.Row.FindControl("btnEliminar");
                    if (btnEliminar != null)
                    {
                        btnEliminar.Enabled = false;
                        btnEliminar.CssClass = "btn btn-sm btn-secondary disabled";
                        btnEliminar.OnClientClick = "";  // Quita el confirm
                    }
                }
            }
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            /*
            boPersona = new PersonaWSClient();
            var lista = boPersona.listarPersona();
            string docIdentidad = (((LinkButton)sender).CommandArgument);
            persona personaSeleccionada = lista.SingleOrDefault(x => x.docIdentidad == docIdentidad);
            Session["personaSeleccionada"] = personaSeleccionada;
            Response.Redirect("agregar-persona.aspx?accion=modificar");
            */
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            var argumentos = ((LinkButton)sender).CommandArgument.Split('|');
            string doc = argumentos[0];
            string rol = argumentos[1];

            // Verificar si ya está inactivo
            var lista = Session["personas"] as List<PersonaResumen>;
            var persona = lista?.FirstOrDefault(p => p.DocIdentidad == doc && p.Rol == rol);

            if (persona != null && !persona.Activo)
            {
                string script = "alert('Esta persona ya se encuentra inactiva.');";
                ScriptManager.RegisterStartupScript(this, GetType(), "PersonaInactiva", script, true);
                return;
            }

            // Lógica de inactivación
            switch (rol)
            {
                case "ADMINISTRADOR":
                    boAdmin.eliminarAdministrador(doc); // asegúrate de que esta función inactiva, no borra
                    break;
                case "MEDICO":
                    boMedico.eliminarMedico(doc);
                    break;
                case "PACIENTE":
                    boPaciente.eliminarPaciente(doc);
                    break;
            }

            CargarPersonas(); // Refrescar lista
        }

        protected void btnVisualizar_Click(object sender, EventArgs e)
        {
            var argumentos = ((LinkButton)sender).CommandArgument.Split('|');
            string doc = argumentos[0];
            string rol = argumentos[1];

            switch (rol)
            {
                case "ADMINISTRADOR":
                    var admin = boAdmin.listarAdministrador().FirstOrDefault(x => x.docIdentidad == doc);
                    Session["personaDetalle"] = admin;
                    break;
                case "MEDICO":
                    var medico = boMedico.listarMedico().FirstOrDefault(x => x.docIdentidad == doc);
                    Session["personaDetalle"] = medico;
                    break;
                case "PACIENTE":
                    var paciente = boPaciente.listarPaciente().FirstOrDefault(x => x.docIdentidad == doc);
                    Session["personaDetalle"] = paciente;
                    break;
            }

            Response.Redirect("detalle-persona.aspx");
        }

        protected void txtBuscar_TextChanged(object sender, EventArgs e)
        {
            string filtro = txtBuscar.Text.Trim();
            string estado = ddlEstado.SelectedValue;
            string rol = ddlRol.SelectedValue;
            CargarPersonas(filtro, estado, rol);
        }

        protected void ddlEstado_SelectedIndexChanged(object sender, EventArgs e)
        {
            string filtro = txtBuscar.Text.Trim();
            string estado = ddlEstado.SelectedValue;
            string rol = ddlRol.SelectedValue;
            CargarPersonas(filtro, estado, rol);
        }
        protected void ddlRol_SelectedIndexChanged(object sender, EventArgs e)
        {
            string filtro = txtBuscar.Text.Trim();
            string estado = ddlEstado.SelectedValue;
            string rol = ddlRol.SelectedValue;
            CargarPersonas(filtro, estado, rol);
        }
    }
}