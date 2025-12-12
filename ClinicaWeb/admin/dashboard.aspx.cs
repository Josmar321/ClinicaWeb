using ClinicaWeb.ServiciosWS;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ClinicaWeb.admin
{
    public partial class dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarMetricas();
                CargarHorarios();
                CargarUltimasCitas();
            }
            rptHorarios.ItemCommand += rptHorarios_ItemCommand;
            rptDisponibilidades.ItemCommand += rptDisponibilidades_ItemCommand;
            rptDisponibilidades.ItemDataBound += rptDisponibilidades_ItemDataBound;

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
                    cita.paciente= pac;
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
            // Ordenamos por fecha descendente y tomamos las 5 más recientes
            var ultimasCitas = citas
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
            CitaMedicaWSClient boCita = new CitaMedicaWSClient();
            var citas = boCita.listarCitasMedicas();

            // Fechas de prueba (déjalas como están)
            int citasHoy = citas.Count(c => c.fecha.Date == DateTime.Today);
            int citasAyer = citas.Count(c => c.fecha.Date == DateTime.Today.AddDays(-1));

            int enEspera = citas.Count(c => c.estado.ToString() == "PROGRAMADA" && c.fecha.Date == DateTime.Today);
            int atendidosHoy = citas.Count(c => c.estado.ToString() == "REALIZADA" && c.fecha.Date == DateTime.Today);
            int atendidosAyer = citas.Count(c => c.estado.ToString() == "REALIZADA" && c.fecha.Date == DateTime.Today.AddDays(-1));
            int canceladasHoy = citas.Count(c => c.estado.ToString() == "CANCELADA" && c.fecha.Date == DateTime.Today);
            int canceladasAyer = citas.Count(c => c.estado.ToString() == "CANCELADA" && c.fecha.Date == DateTime.Today.AddDays(-1));

            // Porcentaje de cambio para citas totales
            double porcentajeCambio = 0;
            if (citasAyer > 0)
                porcentajeCambio = ((double)(citasHoy - citasAyer) / citasAyer) * 100;
            else if (citasHoy > 0)
                porcentajeCambio = 100;
            else
                porcentajeCambio = 0;

            // Porcentaje de cambio para atendidos
            double porcentajeAtendidos = 0;
            if (atendidosAyer > 0)
                porcentajeAtendidos = ((double)(atendidosHoy - atendidosAyer) / atendidosAyer) * 100;
            else if (atendidosHoy > 0)
                porcentajeAtendidos = 100;
            else
                porcentajeAtendidos = 0;

            // Porcentaje de cambio para canceladas
            double porcentajeCanceladas = 0;
            if (canceladasAyer > 0)
                porcentajeCanceladas = ((double)(canceladasHoy - canceladasAyer) / canceladasAyer) * 100;
            else if (canceladasHoy > 0)
                porcentajeCanceladas = 100;
            else
                porcentajeCanceladas = 0;

            // Tendencias para cada métrica
            string tendenciaClase, icono;
            if (porcentajeCambio > 0)
            {
                tendenciaClase = "tendencia positiva";
                icono = "fa-arrow-up";
            }
            else if (porcentajeCambio < 0)
            {
                tendenciaClase = "tendencia negativa";
                icono = "fa-arrow-down";
            }
            else
            {
                tendenciaClase = "tendencia neutra";
                icono = "fa-arrows-left-right";
            }
            string porcentajeTexto = $"{Math.Abs(porcentajeCambio):0.#}% vs ayer";

            // Atendidos
            string tendenciaClaseAtendidos, iconoAtendidos;
            if (porcentajeAtendidos > 0)
            {
                tendenciaClaseAtendidos = "tendencia positiva";
                iconoAtendidos = "fa-arrow-up";
            }
            else if (porcentajeAtendidos < 0)
            {
                tendenciaClaseAtendidos = "tendencia negativa";
                iconoAtendidos = "fa-arrow-down";
            }
            else
            {
                tendenciaClaseAtendidos = "tendencia neutra";
                iconoAtendidos = "fa-arrows-left-right";
            }
            string porcentajeTextoAtendidos = $"{Math.Abs(porcentajeAtendidos):0.#}% vs ayer";

            // Canceladas
            string tendenciaClaseCanceladas, iconoCanceladas;
            if (porcentajeCanceladas > 0)
            {
                tendenciaClaseCanceladas = "tendencia positiva";
                iconoCanceladas = "fa-arrow-up";
            }
            else if (porcentajeCanceladas < 0)
            {
                tendenciaClaseCanceladas = "tendencia negativa";
                iconoCanceladas = "fa-arrow-down";
            }
            else
            {
                tendenciaClaseCanceladas = "tendencia neutra";
                iconoCanceladas = "fa-arrows-left-right";
            }
            string porcentajeTextoCanceladas = $"{Math.Abs(porcentajeCanceladas):0.#}% vs ayer";

            // Asignar a controles del frontend (debes tener estos controles en tu .aspx)
            litClaseTendencia.Text = tendenciaClase;
            litIconoTendencia.Text = icono;
            lblPorcentaje.Text = porcentajeTexto;

            lblCitasHoy.Text = citasHoy.ToString();
            lblEnEspera.Text = enEspera.ToString();
            lblAtendidos.Text = atendidosHoy.ToString();
            lblCanceladas.Text = canceladasHoy.ToString();

            // NUEVOS: para los porcentajes de atendidos y canceladas
            lblPorcentajeAtendidos.Text = porcentajeTextoAtendidos;
            litClaseTendenciaAtendidos.Text = tendenciaClaseAtendidos;
            litIconoTendenciaAtendidos.Text = iconoAtendidos;

            lblPorcentajeCanceladas.Text = porcentajeTextoCanceladas;
            litClaseTendenciaCanceladas.Text = tendenciaClaseCanceladas;
            litIconoTendenciaCanceladas.Text = iconoCanceladas;

            // Si tienes divs o iconos para cada métrica, asígnales la clase también
            divTendencia.Attributes["class"] = tendenciaClase;
            iconTendencia.Attributes["class"] = "fas " + icono;

            divTendenciaAtendidos.Attributes["class"] = tendenciaClaseAtendidos;
            iconTendenciaAtendidos.Attributes["class"] = "fas " + iconoAtendidos;

            divTendenciaCanceladas.Attributes["class"] = tendenciaClaseCanceladas;
            iconTendenciaCanceladas.Attributes["class"] = "fas " + iconoCanceladas;
        }

        private void CargarHorarios()
        {
            MedicoWSClient boMedico = new MedicoWSClient();
            DisponibilidadWSClient boDisponibilidad = new DisponibilidadWSClient();
            EspecialidadWSClient boEspecialidad = new EspecialidadWSClient();
            medico[] doctores = boMedico.listarMedico();

            // Obtener todas las especialidades una sola vez
            especialidad[] especialidades = boEspecialidad.listarEspecialidad();

            List<DoctorDisponibilidad> lista = new List<DoctorDisponibilidad>();
            if (doctores.Count() != 0)
            {
                foreach (medico doc in doctores)
                {
                    disponibilidad[] disponibilidades = boDisponibilidad.obtenerDisponibilidadXMedico(doc.docIdentidad);
                    if (disponibilidades == null)
                    {
                        continue;
                    }
                    int pendientes = 0;
                    if (disponibilidades != null)
                    {
                        foreach (disponibilidad disp in disponibilidades)
                        {
                            if (disp.activo == false) pendientes++;
                        }
                    }

                    // Buscar la especialidad correspondiente al código del doctor
                    string nombreEspecialidad = "";
                    if (especialidades != null)
                    {
                        especialidad esp = Array.Find(especialidades, e => e.idEspecialidad == doc.especialidad.idEspecialidad);
                        if (esp != null)
                            nombreEspecialidad = esp.nombre;
                    }
                    if (pendientes == 0) continue;
                    lista.Add(new DoctorDisponibilidad
                    {
                        CodigoMedico = doc.docIdentidad,
                        Nombre = doc.nombre,
                        Especialidad = nombreEspecialidad,
                        Pendientes = pendientes
                    });
                }
            }
            rptHorarios.DataSource = lista;
            rptHorarios.DataBind();
        }

        protected void rptHorarios_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "VerDisponibilidades")
            {
                string[] args = e.CommandArgument.ToString().Split('|');
                string codigoMedico = args[0];
                string nombreMedico = args[1];

                // Guardar en ViewState para uso posterior
                ViewState["CodigoMedicoSeleccionado"] = codigoMedico;

                // Cargar disponibilidades
                MedicoWSClient boMedico = new MedicoWSClient();
                DisponibilidadWSClient boDisponibilidad = new DisponibilidadWSClient();
                disponibilidad[] disponibilidades = boDisponibilidad.obtenerDisponibilidadXMedico(codigoMedico);

                rptDisponibilidades.DataSource = disponibilidades;
                rptDisponibilidades.DataBind();

                // Mostrar el nombre en el modal
                ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirModal", $"document.getElementById('nombreMedicoModal').innerText = '{nombreMedico}'; var modal = new bootstrap.Modal(document.getElementById('modalDisponibilidades')); modal.show();", true);
            }
        }

        protected void rptDisponibilidades_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "CambiarEstado")
            {
                int idDisponibilidad = int.Parse(e.CommandArgument.ToString());
                string codigoMedico = ViewState["CodigoMedicoSeleccionado"].ToString();

                DisponibilidadWSClient boDisponibilidad = new DisponibilidadWSClient();
                // Obtener la disponibilidad actual
                disponibilidad disp = boDisponibilidad.obtenerDisponibilidadPorId(idDisponibilidad);
                if (disp != null)
                {
                    disp.activo = !disp.activo;
                    boDisponibilidad.modificarDisponibilidad(disp);
                }

                // Recargar disponibilidades
                disponibilidad[] disponibilidades = boDisponibilidad.obtenerDisponibilidadXMedico(codigoMedico);
                rptDisponibilidades.DataSource = disponibilidades;
                rptDisponibilidades.DataBind();

                // Reabrir el modal
                ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirModal", $"var modal = new bootstrap.Modal(document.getElementById('modalDisponibilidades')); modal.show();", true);
            }
        }

        protected void rptDisponibilidades_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var data = (disponibilidad)e.Item.DataItem; 
                var btn = (Button)e.Item.FindControl("btnCambiarEstado");
                if (btn != null)
                {
                    btn.CssClass += data.activo ? " btn-danger" : " btn-success";
                }
            }
        }
    }

    public class DoctorDisponibilidad
    {
        public string CodigoMedico { get; set; }
        public string Nombre { get; set; }
        public string Especialidad { get; set; }
        public int Pendientes { get; set; }
    }
}