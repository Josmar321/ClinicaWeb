
package pe.edu.pucp.reportes.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.awt.Image;
import java.net.URL;
import java.net.URLDecoder;
import java.sql.Connection;
import java.util.HashMap;
import javax.swing.ImageIcon;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.util.JRLoader;
import pe.edu.pucp.config.DBManager;
import pe.edu.pucp.servlets.ReporteAtencionXMedico;


@WebService(serviceName = "ReporteMedicoWS", targetNamespace = "http://services.pucp.edu.pe")
public class ReporteMedicoWS {
    @WebMethod(operationName = "generarReporteMedico")
    public byte [] generarReporteMedico(@WebParam(name = "codigoMedico") String codMed) {
        byte[] reporte = null;
        try{
            //Referenciamos el archivo Jasper
            JasperReport jr = (JasperReport) JRLoader.loadObject(getClass().getResourceAsStream("/pe/edu/pucp/reportes/RepMed.jasper"));
            //Establecemos los parametros que necesita el reporte
            HashMap parametros = new HashMap();
            parametros.put("codigoMedico", codMed);
            URL rutaLogo = getClass().getResource("/pe/edu/pucp/reportes/logoNeoSalud.png");
            Image logo = (new ImageIcon(rutaLogo)).getImage();
             
            parametros.put("logo", logo);
            //Establecemos la conexión
            Connection con = DBManager.getInstance().getConnection();
            //Poblamos el reporte
            JasperPrint jp = JasperFillManager.fillReport(jr, parametros, con);
            //Mostramos por pantalla
            reporte = JasperExportManager.exportReportToPdf(jp);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return reporte;
    }
}
