using ClinicaWeb.ServiciosWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ClinicaWeb.admin
{
    public partial class ReporteAtencionXMedicos : System.Web.UI.Page
    {
        private ReporteMedicoWSClient boReporteMedico;
        private PersonaWSClient boPersona;
        private UsuarioWSClient boUsuario;
        private MedicoWSClient boMedico;
        protected void Page_Load(object sender, EventArgs e)
        {
            boReporteMedico = new ReporteMedicoWSClient();
            boMedico = new MedicoWSClient();

            byte[] reporte = boReporteMedico.generarReporteMedico(Session["docIdentidadMedico"].ToString());

            Response.Clear();
            Response.ContentType = "application/pdf";
            Response.AddHeader("Content-Disposition", "inline;filename=ReporteCitasPaciente.pdf");
            Response.BinaryWrite(reporte);
            Response.End();
        }
        
    }
}