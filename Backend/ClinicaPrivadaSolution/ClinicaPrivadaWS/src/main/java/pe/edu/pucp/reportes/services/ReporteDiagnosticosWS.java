package pe.edu.pucp.reportes.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.awt.Image;
import java.io.InputStream;
import java.net.URL;
import java.util.Date;
import java.sql.Connection;
import java.util.HashMap;
import javax.swing.ImageIcon;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.util.JRLoader;
import pe.edu.pucp.config.DBManager;

@WebService(serviceName = "ReporteDiagnosticosWS", targetNamespace = "http://services.pucp.edu.pe")
public class ReporteDiagnosticosWS {
    @WebMethod(operationName = "generarReporteDiagnosticos")
    public byte[] generarReporteDiagnosticos(@WebParam(name = "nombreEspecialidad") String nombreEspecialidad,
            @WebParam(name = "fechaInicio") Date fechaInicio,
            @WebParam(name = "fechaFin") Date fechaFin) {
        byte[] reporte = null;
        try{
            //Referenciamos el archivo Jasper
            JasperReport jr = (JasperReport) JRLoader.loadObject(getClass().getResourceAsStream("/pe/edu/pucp/reportes/RepDiagnosticos.jasper"));
            
            //Establecemos los parametros que necesita el reporte
            HashMap parametros = new HashMap();
            parametros.put("nombreEspecialidad", nombreEspecialidad);
            parametros.put("fechaInicio", fechaInicio);
            parametros.put("fechaFin", fechaFin);
            
            //Referenciamos la imagen del logo y los subreportes
            URL rutaLogo = getClass().getResource("/pe/edu/pucp/reportes/logoNeoSalud.png");
            
            //Generamos los objetos necesarios en el reporte
            Image logo = (new ImageIcon(rutaLogo)).getImage();
            
            //Colocamos los parámetros
            parametros.put("logo", logo);
            
            //Establecemos la conexión
            Connection con = DBManager.getInstance().getConnection();
            
            //Poblamos el reporte
            JasperPrint jp = JasperFillManager.fillReport(jr, parametros, con);
            
            //Enviar a C# el PDF en formato de arreglo de byte[]
            reporte = JasperExportManager.exportReportToPdf(jp);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return reporte;
    }
    
    @WebMethod(operationName = "generarReporteDiagnosticosMedico")
    public byte[] generarReporteDiagnosticosMedico(
            @WebParam(name = "codigoMedico") String codigoMedico,
            @WebParam(name = "fechaInicio") Date fechaInicio,
            @WebParam(name = "fechaFin") Date fechaFin) {
        
        byte[] reportePDF = null;
        try {

            InputStream reporteStream = ReporteDiagnosticosWS.class.getResourceAsStream("/pe/edu/pucp/reportes/ReporteDiagnosticosXMedico.jasper");
            JasperReport jr = (JasperReport) JRLoader.loadObject(reporteStream);

            HashMap<String, Object> parametros = new HashMap<>();
            

            parametros.put("P_CODIGO_MEDICO", codigoMedico);
            parametros.put("P_FECHA_INICIO", fechaInicio);
            parametros.put("P_FECHA_FIN", fechaFin);
            
            // Cargar el logo
            URL rutaLogo = getClass().getResource("/pe/edu/pucp/reportes/logoNeoSalud.png");
            Image logo = (new ImageIcon(rutaLogo)).getImage();
            parametros.put("P_LOGO", logo); 
            
            // Obtener conexión a la BD
            Connection con = DBManager.getInstance().getConnection();
            
            // Llenar el reporte 
            JasperPrint jp = JasperFillManager.fillReport(jr, parametros, con);
            
            // Exportar a PDF 
            reportePDF = JasperExportManager.exportReportToPdf(jp);

        } catch (Exception ex) {
            System.out.println("Error al generar reporte: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return reportePDF;
    }
    
}


