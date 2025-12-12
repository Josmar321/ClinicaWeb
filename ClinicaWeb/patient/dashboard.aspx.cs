using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ClinicaWeb.ServiciosWS;

namespace ClinicaWeb.patient
{
    public partial class dashboard : System.Web.UI.Page
    {
        private CitaMedicaWSClient citaMedicaWS = new CitaMedicaWSClient();
        private ConsultorioWSClient consultorioWS = new ConsultorioWSClient();
        private LocalWSClient localWS = new LocalWSClient();
        private UsuarioWSClient usuarioWS = new UsuarioWSClient();
        private PacienteWSClient pacienteWS = new PacienteWSClient();
        private MedicoWSClient medicoWS = new MedicoWSClient();
        private DisponibilidadWSClient disponibilidadWS = new DisponibilidadWSClient();
        private CitaMedicaWSClient citaWS = new CitaMedicaWSClient();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarProximaCita();
                cargarHistorialCitas();
            }
        }

        private void cargarProximaCita()
        {
            string username = Session["Usuario"]?.ToString();
            if (string.IsNullOrEmpty(username)) return;

            int idUsuario = usuarioWS.obtenerUsuarioPorUsername(username);
            if (idUsuario <= 0) return;

            var paciente = pacienteWS.obtenerPacienteXUser(idUsuario);
            if (paciente == null) return;

            var citas = citaMedicaWS.listarCitasPorPaciente(paciente.codigoPaciente)?.ToList() ?? new List<citaMedica>();

            // Enriquecer datos igual que en citas.aspx
            foreach (var cita in citas)
            {
                if (cita.consultorio != null && cita.consultorio.idConsultorio > 0)
                {
                    var consultorioCompleto = consultorioWS.obtenerConsultorioPorId(cita.consultorio.idConsultorio);
                    cita.consultorio.numConsultorio = consultorioCompleto.numConsultorio;
                    cita.consultorio.piso = consultorioCompleto.piso;
                    cita.consultorio.local = localWS.obtenerLocalPorId(consultorioCompleto.local.idLocal);
                }

                if (cita.medico != null && !string.IsNullOrEmpty(cita.medico.codigoMedico))
                {
                    var medicoCompleto = medicoWS.obtenerMedicoPorId(cita.medico.codigoMedico);
                    cita.medico.nombre = medicoCompleto.nombre;
                    cita.medico.primerApellido = medicoCompleto.primerApellido;
                    cita.medico.segundoApellido = medicoCompleto.segundoApellido;
                    cita.medico.especialidad = medicoCompleto.especialidad;
                }
            }

            var ahora = DateTime.Now;
            var proximaCita = citas
                .Where(c => c.estado.ToString() == "PROGRAMADA" && (c.fecha + c.hora.TimeOfDay) > ahora)
                .OrderBy(c => c.fecha)
                .ThenBy(c => c.hora)
                .FirstOrDefault();

            if (proximaCita != null)
            {
                // Mostrar la cita en controles del frontend (debes agregarlos en .aspx)
                lblFechaCita.Text = proximaCita.fecha.ToString("dd 'de' MMMM, yyyy");
                lblHoraCita.Text = proximaCita.hora.ToString(@"hh\:mm") + " " + (proximaCita.hora.Hour < 12 ? "AM" : "PM");
                lblDoctorCita.Text = $"Dr. {proximaCita.medico.nombre} {proximaCita.medico.primerApellido} {proximaCita.medico.segundoApellido}";
                lblEspecialidadCita.Text = proximaCita.medico.especialidad?.nombre ?? "-";
                lblDireccionCita.Text = $"{proximaCita.consultorio?.local?.direccion ?? "Sin dirección"} - Consultorio {proximaCita.consultorio?.numConsultorio}";
                pnlProximaCita.Visible = true;
                lblSinCitas.Visible = false;

            }
            else
            {
                // Ocultar bloque si no hay citas
                pnlProximaCita.Visible = false;
                lblSinCitas.Visible = true;

            }
        }

        private void cargarHistorialCitas()
        {
            string username = Session["Usuario"]?.ToString();
            if (string.IsNullOrEmpty(username)) return;

            int idUsuario = usuarioWS.obtenerUsuarioPorUsername(username);
            if (idUsuario <= 0) return;

            var paciente = pacienteWS.obtenerPacienteXUser(idUsuario);
            if (paciente == null) return;

            var citas = citaMedicaWS.listarCitasPorPaciente(paciente.codigoPaciente)?.ToList() ?? new List<citaMedica>();

            // Enriquecer datos igual que en citas.aspx
            foreach (var cita in citas)
            {
                if (cita.medico != null && !string.IsNullOrEmpty(cita.medico.codigoMedico))
                {
                    var medicoCompleto = medicoWS.obtenerMedicoPorId(cita.medico.codigoMedico);
                    if (medicoCompleto != null)
                    {
                        cita.medico.nombre = medicoCompleto.nombre;
                        cita.medico.primerApellido = medicoCompleto.primerApellido;
                        cita.medico.especialidad = medicoCompleto.especialidad;
                    }
                }
            }

            var citasRealizadas = citas
                .Where(c => c.estado.ToString() == "REALIZADA")
                .OrderByDescending(c => c.fecha)
                .ToList();

            if (citasRealizadas.Count > 0)
            {
                rptHistorialCitas.DataSource = citasRealizadas;
                rptHistorialCitas.DataBind();
                lblSinHistorial.Visible = false;
            }
            else
            {
                lblSinHistorial.Visible = true;
            }
        }


    }
}