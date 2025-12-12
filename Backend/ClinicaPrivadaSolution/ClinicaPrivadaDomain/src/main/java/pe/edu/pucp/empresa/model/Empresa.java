package pe.edu.pucp.empresa.model;

import java.util.ArrayList;

public class Empresa {
    private static int i=1;
    private int idEmpresa;
    private String razonSocial;
    private String ruc;
    private String telefonoDeContacto;
    private byte[] logo;
    private String linkInstagram;
    private String linkFacebook;
    private boolean activo;
    
    //Relaciones
    private ArrayList<Local> locales;
    
    //Constructores
    public Empresa(){
        this.locales = new ArrayList<Local>();
    }
    
    public Empresa(String razonSocial, String ruc, String telefonoDeContacto, 
                    String linkInstagram, String linkFacebook){
        this.idEmpresa = i;
        this.razonSocial = razonSocial;
        this.ruc = ruc;
        this.telefonoDeContacto = telefonoDeContacto;
        this.linkInstagram = linkInstagram;
        this.linkFacebook = linkFacebook;
        this.locales = new ArrayList<Local>();
        i++;
    }

    //Getters y Setters
    public int getIdEmpresa() {
        return this.idEmpresa;
    }

    
    public void setIdEmpresa(int idEmpresa) {
        this.idEmpresa = idEmpresa;
    }
    
    public String getRazonSocial() {
        return razonSocial;
    }

    public void setRazonSocial(String razonSocial) {
        this.razonSocial = razonSocial;
    }

    public String getRuc() {
        return this.ruc;
    }

    public void setRuc(String ruc) {
        this.ruc = ruc;
    }
    
    public String getTelefonoDeContacto() {
        return this.telefonoDeContacto;
    }

    public void setTelefonoDeContacto(String telefonoDeContacto) {
        this.telefonoDeContacto = telefonoDeContacto;
    }
    
    public byte[] getLogo() {
        return this.logo;
    }
    
    public void setLogo(byte[] logo) {
        this.logo = logo;
    }

    public String getLinkInstagram() {
        return this.linkInstagram;
    }

    public void setLinkInstagram(String linkInstagram) {
        this.linkInstagram = linkInstagram;
    }

    public String getLinkFacebook() {
        return linkFacebook;
    }

    public void setLinkFacebook(String linkFacebook) {
        this.linkFacebook = linkFacebook;
    }
    
    public ArrayList<Local> getLocales() {
        return new ArrayList<Local>(locales);
    }
    
    public void agregarLocal(Local local) {
        this.locales.add(local);
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }
}
