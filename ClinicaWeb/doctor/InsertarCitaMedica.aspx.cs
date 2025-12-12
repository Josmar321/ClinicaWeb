using System;
using System.Web.UI.WebControls; // Necesario para ListItem
using ClinicaWeb.ServiciosWS;

namespace ClinicaWeb.doctor
{
    public partial class InsertarCitaMedica : System.Web.UI.Page
    {
        // Asegúrate de que los nombres de los endpoints coincidan con tu Web.config
        private CitaMedicaWSClient wsCitas = new CitaMedicaWSClient();
        private PacienteWSClient wsPacientes = new PacienteWSClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Llenar DropDowns de Estado y Modalidad
                ddlEstado.Items.Add("PROGRAMADA");
                ddlEstado.Items.Add("CANCELADA");
                ddlEstado.Items.Add("REALIZADA");

                ddlModalidad.Items.Add("PRESENCIAL");
                ddlModalidad.Items.Add("VIRTUAL");

                // --- Cargar médicos usando tu método original para el nombre completo ---
                try
                {
                    // 1. Limpiar la lista antes de llenarla.
                    ddlMedico.Items.Clear();

                    // 2. Añadir el ítem por defecto PRIMERO. Su valor es "" para la validación.
                    ddlMedico.Items.Add(new ListItem("Seleccione un médico...", ""));

                    // 3. Llenar el resto con el bucle, como lo tenías antes.
                    var wsMedicos = new MedicoWSClient();
                    var listaMedicos = wsMedicos.listarMedico();
                    if (listaMedicos != null)
                    {
                        foreach (var m in listaMedicos)
                        {
                            string nombreCompleto = $"{m.nombre} {m.primerApellido} {m.segundoApellido}";
                            ddlMedico.Items.Add(new ListItem(nombreCompleto, m.codigoMedico));
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblMensaje.Text = "Error al cargar la lista de médicos: " + ex.Message;
                    lblMensaje.Visible = true;
                }

                // Aquí deberías cargar la lista de consultorios también
            }
        }

        // En el archivo InsertarCitaMedica.aspx.cs

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            // --- Primero, las validaciones que ya teníamos ---
            if (string.IsNullOrEmpty(ddlMedico.SelectedValue))
            {
                lblMensaje.Text = "Por favor, seleccione un médico de la lista.";
                lblMensaje.Visible = true;
                return;
            }
            // ... (añade otras validaciones si las tienes) ...

            try
            {
                string codigoPaciente = Request.QueryString["codigo"];

                // ==================================================================
                // ===       LÓGICA NUEVA: OBTENER EL ID DEL HISTORIAL            ===
                // ==================================================================

                // 1. Creamos un cliente para el servicio de Historial Clínico
                HistorialClinicoWSClient wsHistorial = new HistorialClinicoWSClient();

                // 2. Usamos el código del paciente para buscar su historial
                historialClinico historial = wsHistorial.obtenerHistorialConCitas(codigoPaciente);

                // 3. Validamos si el historial existe
                if (historial == null || historial.idHistorial <= 0)
                {
                    lblMensaje.Text = "Error crítico: No se encontró un historial clínico para este paciente.";
                    lblMensaje.Visible = true;
                    return;
                }

                // --- FIN DE LA LÓGICA NUEVA ---


                // Ahora, creamos el objeto CitaMedica usando el ID del historial que encontramos
                citaMedica cita = new citaMedica
                {
                    fecha = DateTime.Parse(txtFecha.Text),
                    fechaSpecified = true,
                    hora = DateTime.Parse(txtHora.Text),
                    horaSpecified = true,
                    precio = double.Parse(txtPrecio.Text),
                    estado = (estadoCita)Enum.Parse(typeof(estadoCita), ddlEstado.SelectedValue),
                    estadoSpecified = true,
                    modalidad = (modalidad)Enum.Parse(typeof(modalidad), ddlModalidad.SelectedValue),
                    modalidadSpecified = true,
                    paciente = new paciente { codigoPaciente = codigoPaciente },
                    medico = new medico { codigoMedico = ddlMedico.SelectedValue },
                    consultorio = new consultorio { idConsultorio = int.Parse(txtIdConsultorio.Text) },

                    // Usamos el objeto historial que obtuvimos del servicio
                    historialClinico = historial,

                    activo = true
                };

                int res = wsCitas.insertarCitaMedica(cita);

                if (res > 0)
                    Response.Redirect($"HistorialClinicoPaciente.aspx?codigo={codigoPaciente}&success=1");
                else
                    lblMensaje.Text = "No se pudo registrar la cita.";
                lblMensaje.Visible = true;
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al registrar: " + ex.Message;
                lblMensaje.Visible = true;
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            string codigoPaciente = Request.QueryString["codigo"];
            Response.Redirect($"HistorialClinicoPaciente.aspx?codigo={codigoPaciente}");
        }
    }
}