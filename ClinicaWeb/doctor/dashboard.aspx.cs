using ClinicaWeb.ServiciosWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ClinicaWeb.doctor
{
    public partial class dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {/*
            if (Session["Usuario"] == null || Session["rol"] == null || Session["rol"].ToString() != "MEDICO")
            {
                Response.Redirect("InicioSesion.aspx");
            }*/
            if (Session["Usuario"] == null)
            {
                Response.Redirect("~/InicioSesion.aspx");
                return;
            }

            string rol = Session["rol"]?.ToString();

            if (rol != "MEDICO")
            {
                switch (rol)
                {
                    case "PACIENTE":
                        Response.Redirect("~/patient/dashboard.aspx");
                        break;
                    case "ADMINISTRADOR":
                        Response.Redirect("~/admin/dashboard.aspx");
                        break;
                    default:
                        Response.Redirect("~/dashboard.aspx");
                        break;
                }
            }
            if (!IsPostBack)
            {
                CargarMetricas();
                CargarUltimasCitas();
            }

        }
        private void CargarUltimasCitas()
        {
            CitaMedicaWSClient boCita = new CitaMedicaWSClient();
            PacienteWSClient boPaciente = new PacienteWSClient();
            MedicoWSClient boMedico = new MedicoWSClient();
            EspecialidadWSClient boEspecialidad = new EspecialidadWSClient();

            var citas = boCita.listarCitasMedicas();
            var pacientes = boPaciente.listarPaciente();
            var medicos = boMedico.listarMedico();
            var especialidades = boEspecialidad.listarEspecialidad();

            foreach (var cita in citas)
            {
                foreach (var pac in pacientes)
                {
                    if (pac.docIdentidad != cita.paciente.codigoPaciente) continue;
                    cita.paciente = pac;
                    break;
                }
                foreach (var med in medicos)
                {
                    if (med.docIdentidad != cita.medico.codigoMedico) continue;
                    cita.medico = med;
                    foreach (var esp in especialidades)
                    {
                        if (esp.idEspecialidad != cita.medico.especialidad.idEspecialidad) continue;
                        cita.medico.especialidad = esp;
                        break;
                    }
                    break;
                }
            }
            UsuarioWSClient boUsuario = new UsuarioWSClient();
            int id = boUsuario.obtenerUsuarioPorUsername(Session["Usuario"]?.ToString());
            medico medicoActual = boMedico.obtenerMedicoXUser(id);
            // Ordenamos por fecha descendente y tomamos las 5 más recientes
            var ultimasCitas = citas
                .Where(c => c.medico.codigoMedico == medicoActual.codigoMedico)
                .OrderByDescending(c => c.fecha)
                .Take(4)
                .Select(c => new
                {
                    fecha = c.fecha,
                    hora = c.hora,
                    paciente = $"{c.paciente.nombre} {c.paciente.primerApellido}",
                    medico = $"{c.medico.nombre} {c.medico.primerApellido}",
                    motivo = $"{c.medico.especialidad.nombre}",
                    estadoCss = GetCssEstado(c.estado.ToString()),
                    estadoTexto = GetTextoEstado(c.estado.ToString())
                })
                .ToList();

            rptUltimasCitas.DataSource = ultimasCitas;
            rptUltimasCitas.DataBind();
        }
        private string GetCssEstado(string estado)
        {
            switch (estado)
            {
                case "REALIZADA": return "completada";
                case "PROGRAMADA": return "confirmada";
                case "CANCELADA": return "cancelada";
                default: return "pendiente";
            }
        }

        private string GetTextoEstado(string estado)
        {
            switch (estado)
            {
                case "REALIZADA": return "Realizada";
                case "PROGRAMADA": return "Programada";
                case "CANCELADA": return "Cancelada";
                default: return "Pendiente";
            }
        }
        private void CargarMetricas()
        {

            UsuarioWSClient boUsuario = new UsuarioWSClient();
            MedicoWSClient boMedico = new MedicoWSClient();
            CitaMedicaWSClient boCita = new CitaMedicaWSClient();
            var citas = boCita.listarCitasMedicas();
            int id = boUsuario.obtenerUsuarioPorUsername(Session["Usuario"]?.ToString());
            medico med = boMedico.obtenerMedicoXUser(id);

            var ultimaCita = citas.Where(c => c.medico.codigoMedico == med.codigoMedico)
            .OrderByDescending(c => c.fecha)
            .FirstOrDefault();
            lblUltimaCita.Text = ultimaCita.fecha.ToString("dd-MMM ") + ultimaCita.hora.ToString("HH:mm");

            // Fechas de prueba (déjalas como están)
            int citasHoy = citas.Count(c => c.fecha.Date == DateTime.Today && c.medico.codigoMedico == med.codigoMedico);
            int enEspera = citas.Count(c => c.estado.ToString() == "PROGRAMADA" && c.fecha.Date == DateTime.Today && c.medico.codigoMedico == med.codigoMedico);
            int atendidosHoy = citas.Count(c => c.estado.ToString() == "REALIZADA" && c.fecha.Date == DateTime.Today && c.medico.codigoMedico == med.codigoMedico);
            //string mostrar = ultimaCita.fecha.ToString("dd/MM/yyyy") + ultimaCita.hora.ToString("HH:mm");
            
            lblCitasHoy.Text = citasHoy.ToString();
            lblEnEspera.Text = enEspera.ToString();
            lblAtendidos.Text = atendidosHoy.ToString();
        }
        protected void IrConfiguracionCuenta(object sender, EventArgs e)
        {
            Response.Redirect("configuracionCuenta.aspx");
        }

        protected void IrCerrarSesion(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("InicioSesion.aspx");
        }

        protected void IrDashboard(object sender, EventArgs e)
        {
            Response.Redirect("dashboard.aspx");
        }
        protected void IrAgenda(object sender, EventArgs e)
        {
            Response.Redirect("agenda.aspx");
        }
        protected void IrPacientes(object sender, EventArgs e)
        {
            Response.Redirect("pacientes.aspx");
        }
        protected void IrHorarios(object sender, EventArgs e)
        {
            Response.Redirect("horarios.aspx");
        }
        protected void IrReportes(object sender, EventArgs e)
        {
            Response.Redirect("reportes.aspx");
        }
        protected void IrNotificaciones(object sender, EventArgs e)
        {
            Response.Redirect("notificaciones.aspx");
        }
        protected void txtBuscar_TextChanged(object sender, EventArgs e)
        {
            // Aquí puedes implementar la lógica de búsqueda
            //string terminoBusqueda = txtBuscar.Text.Trim();
            // Por ahora solo redirigimos a la misma página
            Response.Redirect(Request.RawUrl);
        }
    }
}