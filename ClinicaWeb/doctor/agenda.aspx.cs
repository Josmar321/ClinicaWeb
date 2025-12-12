using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ClinicaWeb.ServiciosWS;

namespace ClinicaWeb.doctor
{
    public partial class agenda : System.Web.UI.Page
    {
        private CitaMedicaWSClient citaWS = new CitaMedicaWSClient();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DateTime hoy = DateTime.Now;
                Calendar1.SelectedDate = hoy;
                Calendar1.VisibleDate = hoy;
                lblFechaTitulo.InnerText = $"Citas del {hoy:dd 'de' MMMM 'del' yyyy}";
                cargarCitasPorFecha(hoy);
            }
        }

        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
            DateTime fechaSeleccionada = Calendar1.SelectedDate;
            lblFechaTitulo.InnerText = $"Citas del {fechaSeleccionada:dd 'de' MMMM 'del' yyyy}";
            cargarCitasPorFecha(fechaSeleccionada);
        }

        private void cargarCitasPorFecha(DateTime fecha)
        {
            UsuarioWSClient boUsuario = new UsuarioWSClient();
            MedicoWSClient boMedico = new MedicoWSClient();

            // Obtener el nombre de usuario desde la sesión
            string username = Session["Usuario"]?.ToString();
            if (string.IsNullOrEmpty(username)) return;

            int idUsuario = boUsuario.obtenerUsuarioPorUsername(username);

            // Obtener el médico correspondiente
            medico med = boMedico.obtenerMedicoXUser(idUsuario);
            if (med == null) return;

            // Obtener todas las citas del día
            var todasLasCitas = citaWS.obtenerCitasPorFecha(fecha, fecha) ?? new citaMedica[0];

            // Filtrar solo las del médico logueado
            var citasDelMedico = todasLasCitas
            .Where(c =>
                c.medico != null &&
                c.medico.codigoMedico == med.codigoMedico &&
                c.estado != estadoCita.CANCELADA
            )
            .ToList();

            var citasVista = citasDelMedico.Select(c => new
            {
                paciente = $"{c.paciente?.nombre} {c.paciente?.primerApellido}".Trim() == ""
                            ? "Sin nombre"
                            : $"{c.paciente?.nombre} {c.paciente?.primerApellido}",
                hora = c.hora.ToString("hh:mm tt"),
                direccionLocal = c.consultorio?.local?.direccion ?? "Sin dirección",
                numConsultorio = c.consultorio != null && c.consultorio.numConsultorio != 0
                                 ? c.consultorio.numConsultorio.ToString()
                                 : "N/A",
                pisoConsultorio = c.consultorio != null && c.consultorio.piso != 0
                                 ? c.consultorio.piso.ToString()
                                 : "N/A",
                modalidad = c.modalidad.ToString(),
                estado = c.estado.ToString(),
            }).ToList();

            rptCitas.DataSource = citasVista;
            rptCitas.DataBind();
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
    }
}