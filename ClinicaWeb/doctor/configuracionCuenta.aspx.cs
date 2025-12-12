using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace ClinicaWeb.doctor
{
    public partial class configuracionCuenta : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Simular carga de correo actual
               // txtCorreo.Text = Session["CorreoDoctor"] != null ? Session["CorreoDoctor"].ToString() : "doctor@email.com";
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            //...
        }
    }
}