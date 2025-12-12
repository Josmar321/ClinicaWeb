using System;
using ClinicaWeb.ServiciosWS;

namespace ClinicaWeb.admin
{
    public partial class InsertarCitaMedica : System.Web.UI.Page
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

                // --- Cargar médicos como DropDown ---
                var wsMedicos = new MedicoWSClient();
                var listaMedicos = wsMedicos.listarMedico();
                foreach (var m in listaMedicos)
                {
                    string nombreCompleto = m.nombre + " " + m.primerApellido + " " + m.segundoApellido;
                    ddlMedico.Items.Add(new System.Web.UI.WebControls.ListItem(nombreCompleto, m.codigoMedico));
                }
            }
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            try
            {
                string codigoPaciente = Request.QueryString["codigo"];
                DateTime fecha = DateTime.Parse(txtFecha.Text);

                // Parsear hora (HH:mm) a DateTime, usando una fecha dummy
                DateTime hora = DateTime.Parse(txtHora.Text);

                double precio = double.Parse(txtPrecio.Text);
                var estado = (ClinicaWeb.ServiciosWS.estadoCita)Enum.Parse(
                    typeof(ClinicaWeb.ServiciosWS.estadoCita), ddlEstado.SelectedValue);
                var modalidad = (ClinicaWeb.ServiciosWS.modalidad)Enum.Parse(
                    typeof(ClinicaWeb.ServiciosWS.modalidad), ddlModalidad.SelectedValue);
                string codigoMedico = ddlMedico.SelectedValue;
                int idConsultorio = int.Parse(txtIdConsultorio.Text);
                int idHistorial = int.Parse(txtIdHistorial.Text);

                citaMedica cita = new citaMedica
                {
                    fecha = fecha,
                    fechaSpecified = true,
                    hora = hora,
                    horaSpecified = true,  // Por si tu WS requiere saber si fue seteado
                    precio = precio,
                    estado = estado,
                    estadoSpecified = true,
                    modalidad = modalidad,
                    modalidadSpecified = true,
                    paciente = new paciente { codigoPaciente = codigoPaciente },
                    medico = new medico { codigoMedico = codigoMedico },
                    consultorio = new consultorio { idConsultorio = idConsultorio },
                    historialClinico = new historialClinico { idHistorial = idHistorial },
                    activo = true
                };

                int res = wsCitas.insertarCitaMedica(cita);

                if (res > 0)
                    Response.Redirect($"HistorialClinicoPaciente.aspx?codigo={codigoPaciente}");
                else
                    lblMensaje.Text = "No se pudo registrar la cita.";
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al registrar: " + ex.Message;
            }
        }



        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            string codigoPaciente = Request.QueryString["codigo"];
            Response.Redirect($"HistorialClinicoPaciente.aspx?codigo={codigoPaciente}");
        }
    }
}
