using ClinicaWeb.ServiciosWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ClinicaWeb.patient
{
    public partial class VerReportePaciente : System.Web.UI.Page
    {
        private ReportePacienteWSClient boReportePaciente;
        private PersonaWSClient boPersona;
        private UsuarioWSClient boUsuario;
        protected void Page_Load(object sender, EventArgs e)
        {
            boReportePaciente = new ReportePacienteWSClient();
            string docIdentidadPaciente = "";
            if (Session["docIdentidadPaciente"] == null)
            {
                boUsuario = new UsuarioWSClient();
                boPersona = new PersonaWSClient();
                int id = boUsuario.obtenerUsuarioPorUsername(Session["Usuario"]?.ToString());
                docIdentidadPaciente = boPersona.obtenerDocIdentidadXIdUser(id);

                Session["docIdentidadPaciente"] = docIdentidadPaciente;
            }

            byte[] reporte = boReportePaciente.generarReportePacientes(docIdentidadPaciente);

            Response.Clear();
            Response.ContentType = "application/pdf";
            Response.AddHeader("Content-Disposition", "inline;filename=ReporteCitasPaciente.pdf");
            Response.BinaryWrite(reporte);
            Response.End();
        }
    }
}