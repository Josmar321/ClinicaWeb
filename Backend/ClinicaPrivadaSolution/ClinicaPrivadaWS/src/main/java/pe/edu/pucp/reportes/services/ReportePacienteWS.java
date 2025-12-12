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

@WebService(serviceName = "ReportePacienteWS", targetNamespace = "http://services.pucp.edu.pe")
public class ReportePacienteWS {
    @WebMethod(operationName = "generarReportePacientes")
    public byte[] generarReportePacientes(@WebParam(name = "codigoPaciente") String codigoPaciente) {
        byte[] reporte = null;
        try{
            //Referenciamos el archivo Jasper
            JasperReport jr = (JasperReport) JRLoader.loadObject(getClass().getResourceAsStream("/pe/edu/pucp/reportes/Reporte_Citas_MedicasXPaciente.jasper"));
            
            //Establecemos los parametros que necesita el reporte
            HashMap parametros = new HashMap();
            parametros.put("codigoPaciente", codigoPaciente);
            
            //Referenciamos la imagen del logo y los subreportes
            URL rutaLogo = getClass().getResource("/pe/edu/pucp/reportes/logoNeoSalud.png");
            URL subreporteMedicos = getClass().getResource("/pe/edu/pucp/reportes/RepPacienteCitasXMedico.jasper");
            
            //Generamos los objetos necesarios en el reporte
            Image logo = (new ImageIcon(rutaLogo)).getImage();
            String rutaSubreporteMedicos = URLDecoder.decode(subreporteMedicos.getPath(), "UTF-8");
            
            //Colocamos los parámetros
            parametros.put("logo", logo);
            parametros.put("rutaSubreporteMedicos",rutaSubreporteMedicos);
            
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
}
