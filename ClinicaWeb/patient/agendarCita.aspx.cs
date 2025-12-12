using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ClinicaWeb.ServiciosWS;

namespace ClinicaWeb.patient
{
    public partial class agendarCita : System.Web.UI.Page
    {
        private MedicoWSClient medicoWS = new MedicoWSClient();
        private LocalWSClient localWS = new LocalWSClient();
        private EspecialidadWSClient especialidadWS = new EspecialidadWSClient();
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["idLocal"] = "x";
            Session["idEspecialidad"] = "x";
            Session["fecha"] = "x";
            if (!IsPostBack)
            {
                cargarLocales();

                // Si viene de reservarCita con filtros
                string local = Request.QueryString["local"];
                string especialidad = Request.QueryString["especialidad"];
                string fechaSeleccionada = Request.QueryString["fecha"];

                if (!string.IsNullOrEmpty(local))
                {
                    ddlLocal.SelectedValue = local;
                    ddlLocal_SelectedIndexChanged(null, null); // Cargar especialidades
                }

                if (!string.IsNullOrEmpty(especialidad))
                {
                    ddlEspecialidad.SelectedValue = especialidad;
                }

                if (!string.IsNullOrEmpty(fechaSeleccionada))
                {
                    fecha.Value = fechaSeleccionada;
                }
                else
                {
                    fecha.Value = DateTime.Now.ToString("yyyy-MM-dd");
                }

                // Restringir el rango de fechas válidas
                fecha.Attributes["min"] = DateTime.Now.ToString("yyyy-MM-dd");
                fecha.Attributes["max"] = DateTime.Now.AddMonths(1).ToString("yyyy-MM-dd");

                // Si todos los filtros están presentes, ejecutamos búsqueda
                if (!string.IsNullOrEmpty(local) && !string.IsNullOrEmpty(especialidad) && !string.IsNullOrEmpty(fechaSeleccionada))
                {
                    btnBuscar_Click(null, null);
                }
                else
                {
                    cargarMedicos();
                    ddlEspecialidad.Items.Insert(0, new ListItem("[Seleccione un Local]", "0"));
                }
            }
        }


        private void cargarLocales()
        {
            var todosLosLocales = localWS.listarLocales();

            // Solo locales activos
            var localesActivos = new List<local>();
            foreach (var loc in todosLosLocales)
            {
                if (loc.activo)
                {
                    localesActivos.Add(loc);
                }
            }

            ddlLocal.DataSource = localesActivos;
            ddlLocal.DataTextField = "direccion";
            ddlLocal.DataValueField = "idLocal";
            ddlLocal.DataBind();

            ddlLocal.Items.Insert(0, new ListItem("[Seleccione]", "0"));
        }
        private void cargarMedicos()
        {
            var medicos = medicoWS.listarMedico();

            // Filtrar los médicos activos
            var medicosActivos = new List<medico>();
            foreach (var m in medicos)
            {
                if (m.activo)
                {
                    medicosActivos.Add(m);
                }
            }

            rptMedicos.DataSource = medicosActivos;
            rptMedicos.DataBind();
        }

        protected string ObtenerSrcFoto(object objFoto)
        {
            if (objFoto == null || !(objFoto is byte[] bytes) || bytes.Length == 0)
                return "https://cdn-icons-png.flaticon.com/512/147/147144.png"; // Avatar genérico
            return "data:image/png;base64," + Convert.ToBase64String(bytes);
        }

        protected void ddlLocal_SelectedIndexChanged(object sender, EventArgs e)
        {
            int idLocal = int.Parse(ddlLocal.SelectedValue);

            ddlEspecialidad.Items.Clear(); // Limpia el dropdown

            if (idLocal == 0)
            {
                ddlEspecialidad.Items.Insert(0, new ListItem("[Seleccione un Local]", "0"));
                return;
            }

            var especialidadesBase = especialidadWS.listarPorIdLocal(idLocal) ?? new especialidad[0];

            foreach (var esp in especialidadesBase)
            {
                ddlEspecialidad.Items.Add(new ListItem(esp.nombre, esp.idEspecialidad.ToString()));
            }

            ddlEspecialidad.Items.Insert(0, new ListItem("[Seleccione]", "0"));
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            int idLocal = int.Parse(ddlLocal.SelectedValue);
            int idEspecialidad = int.Parse(ddlEspecialidad.SelectedValue);
            string fechaSeleccionada = fecha.Value;

            // Validación
            if (idLocal == 0 || idEspecialidad == 0 || string.IsNullOrEmpty(fechaSeleccionada))
            {
                cargarMedicos();
                lblMensaje.Visible = false;
                return;
            }

            DateTime fechaCita;
            if (!DateTime.TryParse(fechaSeleccionada, out fechaCita))
            {
                cargarMedicos();
                lblMensaje.Visible = false;
                return;
            }

            string diaSemana = fechaCita.ToString("dddd").ToUpper();

            var medicosFiltrados = medicoWS.obtenerMedicosParaCitaMedica(idLocal, idEspecialidad, diaSemana);

            rptMedicos.DataSource = medicosFiltrados;
            rptMedicos.DataBind();

            lblMensaje.Visible = (medicosFiltrados == null || medicosFiltrados.Length == 0);
            Session["idLocal"] = idLocal.ToString();
            Session["idEspecialidad"] = idEspecialidad.ToString();
            Session["fecha"] = fechaSeleccionada;
        }

        protected void AgendarCita_Command(object sender, CommandEventArgs e)
        {
            string codigoMedico = e.CommandArgument.ToString();
            string fechaSeleccionada = fecha.Value;
            string idLocalSeleccionado = ddlLocal.SelectedValue;
            if (idLocalSeleccionado != "0" && Session["idEspecialidad"].ToString() != "x" && Session["fecha"].ToString() != "x")
            {
                Response.Redirect($"reservarCita.aspx?codigoMedico={codigoMedico}&fecha={fechaSeleccionada}&idLocal={idLocalSeleccionado}");
            }
                
        }


    }
}