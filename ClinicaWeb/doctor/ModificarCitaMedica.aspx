<%@ Page Title="Modificar Cita Médica" Language="C#" MasterPageFile="~/doctor/DoctorMaster.Master" AutoEventWireup="true" CodeBehind="ModificarCitaMedica.aspx.cs" Inherits="ClinicaWeb.doctor.ModificarCitaMedica" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Modificar Cita - NeoSalud
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="../css/modificar-cita.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="modificar-cita-container">
        <asp:Panel ID="pnlFormulario" runat="server">
            <div class="modificar-cita-card">
                <!-- Encabezado -->
                <div class="modificar-cita-header">
                    <h2><i class="fas fa-calendar-edit me-2"></i>Modificar Cita Médica</h2>
                </div>
                
                <!-- Cuerpo del formulario -->
                <div class="modificar-cita-body">
                    <!-- Mensaje de error -->
                    <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje-error" Visible="false" />
                    
                    <!-- Campo Código Paciente -->
                    <div class="form-group">
                        <label class="form-label">Código Paciente</label>
                        <asp:TextBox ID="txtCodigoPaciente" runat="server" CssClass="form-control" ReadOnly="true" />
                    </div>

                    <!-- Fila de Fecha y Hora -->
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label class="form-label">Fecha</label>
                            <div class="input-with-icon">
                                <i class="fas fa-calendar-alt"></i>
                                <asp:TextBox ID="txtFecha" runat="server" TextMode="Date" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="form-group col-md-6">
                            <label class="form-label">Hora</label>
                            <div class="input-with-icon">
                                <i class="fas fa-clock"></i>
                                <asp:TextBox ID="txtHora" runat="server" TextMode="Time" CssClass="form-control" />
                            </div>
                        </div>
                    </div>

                    <!-- Precio -->
                    <div class="form-group">
                        <label class="form-label">Precio (S/)</label>
                        <div class="input-with-icon">
                            <i class="fas fa-money-bill-wave"></i>
                            <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control" />
                        </div>
                    </div>

                    <!-- Fila de Estado y Modalidad -->
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label class="form-label">Estado</label>
                            <div class="input-with-icon">
                                <i class="fas fa-info-circle"></i>
                                <asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-select" />
                            </div>
                        </div>
                        <div class="form-group col-md-6">
                            <label class="form-label">Modalidad</label>
                            <div class="input-with-icon">
                                <i class="fas fa-laptop-house"></i>
                                <asp:DropDownList ID="ddlModalidad" runat="server" CssClass="form-select" />
                            </div>
                        </div>
                    </div>

                    <!-- Médico -->
                    <div class="form-group">
                        <label class="form-label">Médico</label>
                        <div class="input-with-icon">
                            <i class="fas fa-user-md"></i>
                            <asp:DropDownList ID="ddlMedico" runat="server" CssClass="form-select" />
                        </div>
                    </div>

                    <!-- Checkbox Activo -->
                    <div class="form-check">
                        <asp:CheckBox ID="chkActivo" runat="server" CssClass="form-check-input" />
                        <label class="form-check-label" for="<%=chkActivo.ClientID %>">Cita Activa</label>
                    </div>
                </div>

                <!-- Pie de página con botones -->
                <div class="modificar-cita-footer">
                    <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" 
                        CssClass="btn-cancelar" OnClick="btnCancelar_Click" CausesValidation="false" />
                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar Cambios" 
                        CssClass="btn-guardar" OnClick="btnGuardar_Click" />
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>