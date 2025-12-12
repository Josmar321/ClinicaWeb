using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using ClinicaWeb.ServiciosWS;
using System.Collections.Generic;

namespace ClinicaWeb.admin
{
    public partial class modificar_local : System.Web.UI.Page
    {
        private LocalWSClient boLocal = new LocalWSClient();
        private DepartamentoWSClient boDepartamento = new DepartamentoWSClient();
        private CiudadWSClient boCiudad = new CiudadWSClient();
        private EspecialidadWSClient boEspecialidad = new EspecialidadWSClient();
        private MedicoWSClient boMedico = new MedicoWSClient();
        private ConsultorioWSClient boConsultorio = new ConsultorioWSClient();

        private List<consultorio> Consultorios
        {
            get => Session["Consultorios"] as List<consultorio> ?? new List<consultorio>();
            set => Session["Consultorios"] = value;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string idStr = Request.QueryString["id"];
                if (string.IsNullOrEmpty(idStr))
                {
                    Response.Redirect("locales.aspx");
                    return;
                }

                int idLocal = int.Parse(idStr);
                hfIdLocal.Value = idLocal.ToString();

                CargarDepartamentos();
                CargarEspecialidades();
                CargarMedicos();
                CargarDatosLocal(idLocal);
            }
        }

        private void CargarDepartamentos()
        {
            ddlDepartamento.Items.Clear();
            ddlDepartamento.Items.Add(new ListItem("Seleccione un departamento", ""));
            foreach (var d in boDepartamento.listarDepartamentos())
                ddlDepartamento.Items.Add(new ListItem(d.nombre, d.id.ToString()));
        }

        private void CargarEspecialidades()
        {
            chkEspecialidades.Items.Clear();
            foreach (var esp in boEspecialidad.listarEspecialidad())
            {
                if (esp.activo)
                    chkEspecialidades.Items.Add(new ListItem(esp.nombre, esp.idEspecialidad.ToString()));
            }
        }

        private void CargarCiudades(int idDepartamento)
        {
            var ciudades = boCiudad.listarCiudades().Where(c => c.departamento.id == idDepartamento);
            ddlCiudad.Items.Clear();
            ddlCiudad.Items.Add(new ListItem("Seleccione una ciudad", ""));
            foreach (var c in ciudades)
                ddlCiudad.Items.Add(new ListItem(c.nombre, c.id.ToString()));
        }

        protected void ddlDepartamento_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (int.TryParse(ddlDepartamento.SelectedValue, out int idDep))
                CargarCiudades(idDep);
        }

        private void CargarDatosLocal(int idLocal)
        {
            var local = boLocal.obtenerLocalPorId(idLocal);

            txtDireccion.Text = local.direccion;
            txtUbigeo.Text = local.ubigeo;

            ddlDepartamento.SelectedValue = local.departamento.id.ToString();
            CargarCiudades(local.departamento.id);
            ddlCiudad.SelectedValue = local.ciudad.id.ToString();
            ddlEstado.SelectedValue = local.activo ? "1" : "0";

            foreach (ListItem item in chkEspecialidades.Items)
            {
                if (local.especialidades != null && local.especialidades.Any(e => e.idEspecialidad.ToString() == item.Value))
                {
                    item.Selected = true;
                }
            }

            if (local.consultorios != null)
            {
                Consultorios = local.consultorios.ToList();
            }
            else
            {
                Consultorios = new List<consultorio>();
            }
            RefrescarGridConsultorios();

        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            ActualizarValoresConsultoriosDesdeGrid();

            local localModificado = new local
            {
                idLocal = int.Parse(hfIdLocal.Value),
                direccion = txtDireccion.Text.Trim(),
                ubigeo = txtUbigeo.Text.Trim(),
                departamento = new departamento { id = int.Parse(ddlDepartamento.SelectedValue) },
                ciudad = new ciudad { id = int.Parse(ddlCiudad.SelectedValue) },
                activo = ddlEstado.SelectedValue == "1",
                empresa = new empresa { idEmpresa = 1 },
                consultorios = Consultorios.ToArray()
            };

            var especialidadesSeleccionadas = new List<especialidad>();
            var todasEspecialidades = boEspecialidad.listarEspecialidad();
            foreach (ListItem item in chkEspecialidades.Items)
            {
                if (item.Selected)
                {
                    int idEsp = int.Parse(item.Value);
                    var esp = todasEspecialidades.FirstOrDefault(eAux => eAux.idEspecialidad == idEsp);
                    if (esp != null)
                    {
                        esp.locales = null;
                        esp.medicos = null;
                        especialidadesSeleccionadas.Add(esp);
                    }
                }
            }

            localModificado.especialidades = especialidadesSeleccionadas.ToArray();

            try
            {
                int resultado = boLocal.modificarLocal(localModificado);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error al modificar local: " + ex.Message);
            }

            foreach (var consultorio in Consultorios)
            {
                if (consultorio.idConsultorio > 0)
                {
                    try
                    {
                        boConsultorio.modificarConsultorio(consultorio);
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine("Error al modificar consultorio ID " + consultorio.idConsultorio + ": " + ex.Message);
                    }
                }
            }

            Response.Redirect("locales.aspx");
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("locales.aspx");
        }

        protected void btnAgregarConsultorio_Click(object sender, EventArgs e)
        {
            if (int.TryParse(txtNumConsultorio.Text.Trim(), out int num) &&
                int.TryParse(txtPisoConsultorio.Text.Trim(), out int piso) &&
                !string.IsNullOrWhiteSpace(ddlDoctores.SelectedValue))
            {
                var consultorio = new consultorio
                {
                    numConsultorio = num,
                    piso = piso,
                    activo = true,
                    medico = new medico
                    {
                        codigoMedico = ddlDoctores.SelectedValue
                    }
                };

                var lista = Consultorios;
                lista.Add(consultorio);
                Consultorios = lista;
                RefrescarGridConsultorios();

                txtNumConsultorio.Text = "";
                txtPisoConsultorio.Text = "";
                txtCodigoMedico.Text = "";
                ddlDoctores.SelectedIndex = 0;
            }
        }



        protected void gvConsultorios_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                int numConsultorio = Convert.ToInt32(e.CommandArgument);
                var lista = Consultorios;
                var consultorio = lista.FirstOrDefault(c => c.numConsultorio == numConsultorio);
                if (consultorio != null)
                {
                    lista.Remove(consultorio);
                    Consultorios = lista;
                    RefrescarGridConsultorios();
                }

            }
        }

        private void RefrescarGridConsultorios()
        {
            var data = Consultorios.Select((c, i) => new
            {
                idConsultorio = c.idConsultorio,
                numConsultorio = c.numConsultorio,
                piso = c.piso,
                codigoMedico = c.medico?.codigoMedico ?? "",
                activo = c.activo ? "1" : "0"
            }).ToList();

            gvConsultorios.DataSource = data;
            gvConsultorios.DataBind();
        }

        private void CargarMedicos()
        {
            var lista = boMedico.listarMedico();
            ddlDoctores.Items.Clear();
            ddlDoctores.Items.Add(new ListItem("[Seleccione un médico]", ""));

            foreach (var m in lista)
            {
                string nombreCompleto = $"{m.nombre} {m.primerApellido} {m.segundoApellido}";
                ddlDoctores.Items.Add(new ListItem(nombreCompleto, m.docIdentidad));
            }
        }

        protected void ddlDoctores_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtCodigoMedico.Text = ddlDoctores.SelectedValue;
        }

        private void ActualizarValoresConsultoriosDesdeGrid()
        {
            for (int i = 0; i < gvConsultorios.Rows.Count; i++)
            {
                GridViewRow row = gvConsultorios.Rows[i];

                DropDownList ddlEstado = (DropDownList)row.FindControl("ddlEstadoConsultorio");
                DropDownList ddlMedico = (DropDownList)row.FindControl("ddlMedicoGrid");
                Label lblIdConsultorio = (Label)row.FindControl("lblIdConsultorio");

                if (ddlEstado != null && ddlMedico != null)
                {
                    consultorio consultorioAux = Consultorios[i];

                    consultorioAux.activo = ddlEstado.SelectedValue == "1";

                    if (consultorioAux.medico == null)
                        consultorioAux.medico = new medico();

                    consultorioAux.medico.codigoMedico = ddlMedico.SelectedValue;

                    if (lblIdConsultorio != null && int.TryParse(lblIdConsultorio.Text, out int idCons))
                    {
                        consultorioAux.idConsultorio = idCons;
                    }
                }
            }
        }

        protected void gvConsultorios_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DropDownList ddlMedico = (DropDownList)e.Row.FindControl("ddlMedicoGrid");

                if (ddlMedico != null)
                {
                    var lista = boMedico.listarMedico();
                    ddlMedico.Items.Clear();

                    ddlMedico.Items.Add(new ListItem("[Seleccione]", ""));

                    foreach (var m in lista)
                    {
                        string nombreCompleto = $"{m.nombre} {m.primerApellido} {m.segundoApellido}";
                        ddlMedico.Items.Add(new ListItem(nombreCompleto, m.docIdentidad));
                    }

                    // Asignar el valor actual (codigoMedico)
                    string codigoMedicoActual = DataBinder.Eval(e.Row.DataItem, "codigoMedico")?.ToString();
                    if (!string.IsNullOrEmpty(codigoMedicoActual))
                    {
                        var item = ddlMedico.Items.FindByValue(codigoMedicoActual);
                        if (item != null)
                            ddlMedico.ClearSelection();
                        item.Selected = true;
                    }
                }
            }
        }


    }
}
