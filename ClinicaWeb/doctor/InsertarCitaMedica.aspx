<%@ Page Title="Registrar Cita Médica" Language="C#" MasterPageFile="~/doctor/DoctorMaster.Master" AutoEventWireup="true" CodeBehind="InsertarCitaMedica.aspx.cs" Inherits="ClinicaWeb.doctor.InsertarCitaMedica" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Registrar Cita - NeoSalud
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="../css/registrar-cita.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="registrar-cita-container">
        <div class="registrar-cita-card">
            <!-- Encabezado -->
            <div class="registrar-cita-header">
                <h2><i class="fas fa-calendar-plus me-2"></i>Registrar Nueva Cita Médica</h2>
            </div>
            
            <!-- Cuerpo del formulario -->
            <div class="registrar-cita-body">
                <!-- Mensaje de error -->
                <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje-error" Visible="false" />
                
                <!-- Fila de Fecha y Hora -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="<%=txtFecha.ClientID %>" class="form-label">Fecha</label>
                        <div class="input-with-icon">
                            <i class="fas fa-calendar-alt"></i>
                            <asp:TextBox ID="txtFecha" runat="server" TextMode="Date" CssClass="form-control" required="true" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="<%=txtHora.ClientID %>" class="form-label">Hora</label>
                        <div class="input-with-icon">
                            <i class="fas fa-clock"></i>
                            <asp:TextBox ID="txtHora" runat="server" TextMode="Time" CssClass="form-control" required="true" />
                        </div>
                    </div>
                </div>

                <!-- Precio -->
                <div class="form-group">
                    <label for="<%=txtPrecio.ClientID %>" class="form-label">Precio (S/)</label>
                    <div class="input-with-icon">
                        <i class="fas fa-money-bill-wave"></i>
                        <asp:TextBox ID="txtPrecio" runat="server" TextMode="Number" step="0.01" CssClass="form-control" required="true" />
                    </div>
                </div>

                <!-- Fila de Estado y Modalidad -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="<%=ddlEstado.ClientID %>" class="form-label">Estado</label>
                        <div class="input-with-icon">
                            <i class="fas fa-info-circle"></i>
                            <asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="<%=ddlModalidad.ClientID %>" class="form-label">Modalidad</label>
                        <div class="input-with-icon">
                            <i class="fas fa-laptop-house"></i>
                            <asp:DropDownList ID="ddlModalidad" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>
                    </div>
                </div>

                <!-- Médico -->
                <div class="form-group">
                    <label for="<%=ddlMedico.ClientID %>" class="form-label">Médico</label>
                    <div class="input-with-icon">
                        <i class="fas fa-user-md"></i>
                        <asp:DropDownList ID="ddlMedico" runat="server" CssClass="form-select" required="true"></asp:DropDownList>
                    </div>
                </div>

                <!-- Consultorio -->
                <div class="form-group">
                    <label for="<%=txtIdConsultorio.ClientID %>" class="form-label">ID Consultorio</label>
                    <div class="input-with-icon">
                        <i class="fas fa-clinic-medical"></i>
                        <asp:TextBox ID="txtIdConsultorio" runat="server" CssClass="form-control" required="true" />
                    </div>
                </div>
            </div>
            
            <!-- Pie de página con botones -->
            <div class="registrar-cita-footer">
                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" 
                    CssClass="btn-cancelar" OnClick="btnCancelar_Click" CausesValidation="false" />
                <asp:Button ID="btnRegistrar" runat="server" Text="Registrar Cita" 
                    CssClass="btn-registrar" OnClick="btnRegistrar_Click" />
            </div>
        </div>
    </div>
</asp:Content>