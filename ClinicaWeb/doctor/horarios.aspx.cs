using ClinicaWeb.ServiciosWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ClinicaWeb.doctor
{
    public partial class horarios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnToggleLunes_Click(object sender, EventArgs e)
        {
            bool activo = ViewState["LunesActivo"] as bool? ?? true;
            activo = !activo;
            ViewState["LunesActivo"] = activo;

            lblEstadoLunes.Text = activo ? "Activo" : "Inactivo";
            lblEstadoLunes.CssClass = "estado-turno " + (activo ? "activo" : "inactivo");
            btnToggleLunes.CssClass = "btn-toggle";
            btnToggleLunes.Text = activo ? "<i class='fas fa-toggle-on'></i>" : "<i class='fas fa-toggle-off'></i>";

            // Bloquear/desbloquear campos y tarjeta
            txtInicioLunes.Enabled = activo;
            txtFinLunes.Enabled = activo;
            horasTurnoLunes.Attributes["class"] = activo ? "horas-turno" : "horas-turno deshabilitado";
            //cardLunes.Attributes["class"] = activo ? "dia-horario" : "dia-horario bloqueado";
        }

        protected void btnToggleMartes_Click(object sender, EventArgs e)
        {
            // Ejemplo simple: alternar estado usando ViewState
            bool activo = ViewState["MartesActivo"] as bool? ?? true;
            activo = !activo;
            ViewState["MartesActivo"] = activo;

            lblEstadoMartes.Text = activo ? "Activo" : "Inactivo";
            lblEstadoMartes.CssClass = "estado-turno " + (activo ? "activo" : "inactivo");
            btnToggleMartes.CssClass = "btn-toggle";
            btnToggleMartes.Text = activo ? "<i class='fas fa-toggle-on'></i>" : "<i class='fas fa-toggle-off'></i>";
            // Bloquear/desbloquear campos y tarjeta
            txtInicioMartes.Enabled = activo;
            txtFinMartes.Enabled = activo;
            horasTurnoMartes.Attributes["class"] = activo ? "horas-turno" : "horas-turno deshabilitado";
            //cardMartes.Attributes["class"] = activo ? "dia-horario" : "dia-horario bloqueado";
        }
        protected void btnToggleMiercoles_Click(object sender, EventArgs e)
        {
            // Ejemplo simple: alternar estado usando ViewState
            bool activo = ViewState["MiercolesActivo"] as bool? ?? true;
            activo = !activo;
            ViewState["MiercolesActivo"] = activo;

            lblEstadoMiercoles.Text = activo ? "Activo" : "Inactivo";
            lblEstadoMiercoles.CssClass = "estado-turno " + (activo ? "activo" : "inactivo");
            btnToggleMiercoles.CssClass = "btn-toggle";
            btnToggleMiercoles.Text = activo ? "<i class='fas fa-toggle-on'></i>" : "<i class='fas fa-toggle-off'></i>";
            // Bloquear/desbloquear campos y tarjeta
            txtInicioMiercoles.Enabled = activo;
            txtFinMiercoles.Enabled = activo;
            horasTurnoMiercoles.Attributes["class"] = activo ? "horas-turno" : "horas-turno deshabilitado";
            //cardMiercoles.Attributes["class"] = activo ? "dia-horario" : "dia-horario bloqueado";
        }
        protected void btnToggleJueves_Click(object sender, EventArgs e)
        {
            // Ejemplo simple: alternar estado usando ViewState
            bool activo = ViewState["JuevesActivo"] as bool? ?? true;
            activo = !activo;
            ViewState["JuevesActivo"] = activo;

            lblEstadoJueves.Text = activo ? "Activo" : "Inactivo";
            lblEstadoJueves.CssClass = "estado-turno " + (activo ? "activo" : "inactivo");
            btnToggleJueves.CssClass = "btn-toggle";
            btnToggleJueves.Text = activo ? "<i class='fas fa-toggle-on'></i>" : "<i class='fas fa-toggle-off'></i>";
            // Bloquear/desbloquear campos y tarjeta
            txtInicioJueves.Enabled = activo;
            txtFinJueves.Enabled = activo;
            horasTurnoJueves.Attributes["class"] = activo ? "horas-turno" : "horas-turno deshabilitado";
            //cardJueves.Attributes["class"] = activo ? "dia-horario" : "dia-horario bloqueado";
        }
        protected void btnToggleViernes_Click(object sender, EventArgs e)
        {
            // Ejemplo simple: alternar estado usando ViewState
            bool activo = ViewState["ViernesActivo"] as bool? ?? true;
            activo = !activo;
            ViewState["ViernesActivo"] = activo;

            lblEstadoViernes.Text = activo ? "Activo" : "Inactivo";
            lblEstadoViernes.CssClass = "estado-turno " + (activo ? "activo" : "inactivo");
            btnToggleViernes.CssClass = "btn-toggle";
            btnToggleViernes.Text = activo ? "<i class='fas fa-toggle-on'></i>" : "<i class='fas fa-toggle-off'></i>";
            // Bloquear/desbloquear campos y tarjeta
            txtInicioViernes.Enabled = activo;
            txtFinViernes.Enabled = activo;
            horasTurnoViernes.Attributes["class"] = activo ? "horas-turno" : "horas-turno deshabilitado";
            //cardViernes.Attributes["class"] = activo ? "dia-horario" : "dia-horario bloqueado";
        }

        protected void btnPublicar_Click(object sender, EventArgs e)
        {
            DisponibilidadWSClient client = new DisponibilidadWSClient();
            UsuarioWSClient boUsuario = new UsuarioWSClient();
            PersonaWSClient boPersona = new PersonaWSClient();
            MedicoWSClient boMedico = new MedicoWSClient();
            int id = boUsuario.obtenerUsuarioPorUsername(Session["Usuario"]?.ToString());
            medico med = boMedico.obtenerMedicoXUser(id);

            // Lunes
            disponibilidad dispLunes = new disponibilidad();
            dispLunes.horaInicio = DateTime.Parse(txtInicioLunes.Text);
            dispLunes.horaInicioSpecified = true;
            dispLunes.horaFin = DateTime.Parse(txtFinLunes.Text);
            dispLunes.horaFinSpecified = true;
            dispLunes.activo = ViewState["LunesActivo"] as bool? ?? true;
            dispLunes.medico = new medico();
            dispLunes.medico.codigoMedico = med.codigoMedico; // Asignar el código del médico
            if (dispLunes.activo) {
                dispLunes.activo = false;
                client.insertarDisponibilidad(dispLunes, "LUNES");
            };

            // Martes
            disponibilidad dispMartes = new disponibilidad();
            dispMartes.dia = dia.MARTES;
            dispMartes.horaInicio = DateTime.Parse(txtInicioMartes.Text);
            dispMartes.horaInicioSpecified = true;
            dispMartes.horaFin = DateTime.Parse(txtFinMartes.Text);
            dispMartes.horaFinSpecified = true;
            dispMartes.activo = ViewState["MartesActivo"] as bool? ?? true;
            dispMartes.medico = new medico();
            dispMartes.medico.codigoMedico = med.codigoMedico; // Asignar el código del médico
            if (dispMartes.activo)
            {
                dispMartes.activo = false;
                client.insertarDisponibilidad(dispMartes, "MARTES");
            }
            ;

            // Miércoles
            disponibilidad dispMiercoles = new disponibilidad();
            dispMiercoles.dia = dia.MIERCOLES;
            dispMiercoles.horaInicio = DateTime.Parse(txtInicioMiercoles.Text);
            dispMiercoles.horaInicioSpecified = true;
            dispMiercoles.horaFin = DateTime.Parse(txtFinMiercoles.Text);
            dispMiercoles.horaFinSpecified = true;
            dispMiercoles.activo = ViewState["MiercolesActivo"] as bool? ?? true;
            dispMiercoles.medico = new medico();
            dispMiercoles.medico.codigoMedico = med.codigoMedico; // Asignar el código del médico
            if (dispMiercoles.activo)
            {
                dispMiercoles.activo = false;
                client.insertarDisponibilidad(dispMiercoles, "MIERCOLES");
            }
            ;

            // Jueves
            disponibilidad dispJueves = new disponibilidad();
            dispJueves.dia = dia.JUEVES;
            dispJueves.horaInicio = DateTime.Parse(txtInicioJueves.Text);
            dispJueves.horaInicioSpecified = true;
            dispJueves.horaFin = DateTime.Parse(txtFinJueves.Text);
            dispJueves.horaFinSpecified = true;
            dispJueves.activo = ViewState["JuevesActivo"] as bool? ?? true;
            dispJueves.medico = new medico();
            dispJueves.medico.codigoMedico = med.codigoMedico; // Asignar el código del médico
            if (dispJueves.activo)
            {
                dispJueves.activo = false;
                client.insertarDisponibilidad(dispJueves, "JUEVES");
            }
            ;

            // Viernes
            disponibilidad dispViernes = new disponibilidad();
            dispViernes.dia = dia.VIERNES;
            dispViernes.horaInicio = DateTime.Parse(txtInicioViernes.Text);
            dispViernes.horaInicioSpecified = true;
            dispViernes.horaFin = DateTime.Parse(txtFinViernes.Text);
            dispViernes.horaFinSpecified = true;
            dispViernes.activo = ViewState["ViernesActivo"] as bool? ?? true;
            dispViernes.medico = new medico();
            dispViernes.medico.codigoMedico = med.codigoMedico; // Asignar el código del médico
            if (dispViernes.activo)
            {
                dispViernes.activo = false;
                client.insertarDisponibilidad(dispViernes, "VIERNES");
            }
            ;

            // Opcional: mostrar mensaje de éxito
            // lblMensaje.Text = "Disponibilidad publicada correctamente.";
        }
    }
}