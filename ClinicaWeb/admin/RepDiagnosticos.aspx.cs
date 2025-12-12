using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ClinicaWeb.ServiciosWS;
namespace ClinicaWeb.admin
{
    public partial class RepDiagnosticos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Request.QueryString["especialidad"] != null)
            {
                string nombreEspecialidad = Request.QueryString["especialidad"];
                DateTime fechaInicio = DateTime.Parse(Request.QueryString["inicio"]);
                DateTime fechaFin = DateTime.Parse(Request.QueryString["fin"]);

                var client = new ReporteDiagnosticosWSClient();
                byte[] reporte = client.generarReporteDiagnosticos(nombreEspecialidad, fechaInicio, fechaFin);

                Response.Clear();
                Response.ContentType = "application/pdf";
                Response.AddHeader("Content-Disposition", "inline; filename=ReporteDiagnosticos.pdf");
                Response.BinaryWrite(reporte);
                Response.End();
            }

            if (!IsPostBack)
            {
                CargarEspecialidades();
                txtFechaInicio.Attributes["min"] = "2000-01-01";
                txtFechaFin.Attributes["min"] = "2000-01-01";
                txtFechaInicio.Attributes["max"] = DateTime.Now.ToString("yyyy-MM-dd");
                txtFechaFin.Attributes["max"] = DateTime.Now.ToString("yyyy-MM-dd");
            }
        }

        private void CargarEspecialidades()
        {
            EspecialidadWSClient client = new EspecialidadWSClient();
            ddlEspecialidades.DataSource = client.listarEspecialidad();
            ddlEspecialidades.DataTextField = "nombre";
            ddlEspecialidades.DataValueField = "nombre";
            ddlEspecialidades.DataBind();
        }

        protected void btnGenerarReporte_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(ddlEspecialidades.SelectedValue) ||
                string.IsNullOrWhiteSpace(txtFechaInicio.Text) ||
                string.IsNullOrWhiteSpace(txtFechaFin.Text))
                return;

            string especialidad = ddlEspecialidades.SelectedValue;
            DateTime fechaInicio = DateTime.Parse(txtFechaInicio.Text);
            DateTime fechaFin = DateTime.Parse(txtFechaFin.Text);

            if (fechaFin < fechaInicio)
            {
                // puedes mostrar un mensaje si deseas
                return;
            }

            var client = new ReporteDiagnosticosWSClient();
            byte[] reporte = client.generarReporteDiagnosticos(especialidad, fechaInicio, fechaFin);

            Response.Clear();
            Response.ContentType = "application/pdf";
            Response.AddHeader("Content-Disposition", "inline; filename=ReporteDiagnosticos.pdf");
            Response.BinaryWrite(reporte);
            Response.End();
        }
    }
}