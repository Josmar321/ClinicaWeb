using ClinicaWeb.ServiciosWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ClinicaWeb.doctor
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
            string codMed = "";
            if (Session["docIdentidadMedico"] == null)
            {
                medico med = new medico();
                boUsuario = new UsuarioWSClient();
                boPersona = new PersonaWSClient();
                int id = boUsuario.obtenerUsuarioPorUsername(Session["Usuario"]?.ToString());
                med = boMedico.obtenerMedicoXUser(id);

                codMed = med.codigoMedico;
                Session["docIdentidadMedico"] = codMed;
            }

            byte[] reporte = boReporteMedico.generarReporteMedico(codMed);

            Response.Clear();
            Response.ContentType = "application/pdf";
            Response.AddHeader("Content-Disposition", "inline;filename=ReporteAtencionXMedicos.pdf");
            Response.BinaryWrite(reporte);
            Response.End();
        }
        
    }
}