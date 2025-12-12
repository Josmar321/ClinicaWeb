using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ClinicaWeb.doctor
{
    public partial class pacientes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void IrConfiguracionCuenta(object sender, EventArgs e)
        {
            Response.Redirect("configuracionCuenta.aspx");
        }

        protected void IrCerrarSesion(object sender, EventArgs e)
        {
           // Response.Redirect("../../logout.aspx");
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