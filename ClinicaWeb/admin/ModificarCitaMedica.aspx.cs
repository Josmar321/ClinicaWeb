using System;
using ClinicaWeb.ServiciosWS;

namespace ClinicaWeb.admin
{
    public partial class ModificarCitaMedica : System.Web.UI.Page
    {
        private CitaMedicaWSClient wsCitas = new CitaMedicaWSClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ddlEstado.Items.Clear();
                ddlEstado.Items.Add("PROGRAMADA");
                ddlEstado.Items.Add("CANCELADA");
                ddlEstado.Items.Add("REALIZADA");

                ddlModalidad.Items.Clear();
                ddlModalidad.Items.Add("PRESENCIAL");
                ddlModalidad.Items.Add("VIRTUAL");

                // Cargar médicos en el combo (igual que en insertar)
                var wsMedicos = new MedicoWSClient();
                var listaMedicos = wsMedicos.listarMedico();
                ddlMedico.Items.Clear();
                foreach (var m in listaMedicos)
                {
                    string nombreCompleto = m.nombre + " " + m.primerApellido + " " + m.segundoApellido;
                    ddlMedico.Items.Add(new System.Web.UI.WebControls.ListItem(nombreCompleto, m.codigoMedico));
                }

                string idCitaStr = Request.QueryString["idCitaMedica"];
                int idCita = int.Parse(idCitaStr); // Lanza excepción si hay error
                CargarDatosCita(idCita);
            }
        }

        private void CargarDatosCita(int idCita)
        {
            var todasCitas = wsCitas.listarCitasMedicas();
            var cita = Array.Find(todasCitas, c => c.idCita == idCita);

            if (cita == null)
            {
                lblMensaje.Text = "No se encontró la cita médica.";
                pnlFormulario.Visible = false;
                return;
            }

            txtFecha.Text = cita.fecha.ToString("yyyy-MM-dd");
            txtHora.Text = cita.hora.ToString("HH:mm"); // Solo hora y minutos
            txtPrecio.Text = cita.precio.ToString();
            ddlEstado.SelectedValue = cita.estado.ToString();
            ddlModalidad.SelectedValue = cita.modalidad.ToString();
            txtCodigoPaciente.Text = cita.paciente?.codigoPaciente ?? "";
            if (cita.medico != null && !string.IsNullOrEmpty(cita.medico.codigoMedico))
            {
                var item = ddlMedico.Items.FindByValue(cita.medico.codigoMedico);
                if (item != null) ddlMedico.ClearSelection();
                if (item != null) item.Selected = true;
            }
            txtIdConsultorio.Text = cita.consultorio?.idConsultorio.ToString() ?? "";
            txtIdHistorial.Text = cita.historialClinico?.idHistorial.ToString() ?? "";
            chkActivo.Checked = cita.activo;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                string idCitaStr = Request.QueryString["idCitaMedica"];
                if (!int.TryParse(idCitaStr, out int idCita))
                {
                    lblMensaje.Text = "ID de cita no válido.";
                    return;
                }

                DateTime fecha = DateTime.Parse(txtFecha.Text);
                DateTime hora = DateTime.Parse(txtHora.Text); // Esto es hora en formato DateTime (fecha dummy)
                double precio = double.Parse(txtPrecio.Text);
                var estado = (ClinicaWeb.ServiciosWS.estadoCita)Enum.Parse(typeof(ClinicaWeb.ServiciosWS.estadoCita), ddlEstado.SelectedValue);
                var modalidad = (ClinicaWeb.ServiciosWS.modalidad)Enum.Parse(typeof(ClinicaWeb.ServiciosWS.modalidad), ddlModalidad.SelectedValue);
                string codigoPaciente = txtCodigoPaciente.Text;
                string codigoMedico = ddlMedico.SelectedValue;
                int idConsultorio = int.Parse(txtIdConsultorio.Text);
                int idHistorial = int.Parse(txtIdHistorial.Text);

                citaMedica cita = new citaMedica
                {
                    idCita = idCita,
                    fecha = fecha,
                    fechaSpecified = true,
                    hora = hora,
                    horaSpecified = true,
                    precio = precio,
                    estado = estado,
                    estadoSpecified = true,
                    modalidad = modalidad,
                    modalidadSpecified = true,
                    paciente = new paciente { codigoPaciente = codigoPaciente },
                    medico = new medico { codigoMedico = codigoMedico },
                    consultorio = new consultorio { idConsultorio = idConsultorio },
                    historialClinico = new historialClinico { idHistorial = idHistorial },
                    activo = chkActivo.Checked
                };

                int res = wsCitas.modificarCitaMedica(cita);

                if (res > 0)
                    Response.Redirect($"HistorialClinicoPaciente.aspx?codigo={cita.paciente.codigoPaciente}");
                else
                    lblMensaje.Text = "No se pudo modificar la cita médica.";
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al modificar la cita: " + ex.Message;
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            string codPaciente = txtCodigoPaciente.Text;
            Response.Redirect($"HistorialClinicoPaciente.aspx?codigo={codPaciente}");
        }
    }
}
