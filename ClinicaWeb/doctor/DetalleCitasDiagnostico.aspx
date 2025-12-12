<%@ Page Title="Detalle de Citas" Language="C#" MasterPageFile="~/doctor/DoctorMaster.Master" AutoEventWireup="true" CodeBehind="DetalleCitasDiagnostico.aspx.cs" Inherits="ClinicaWeb.doctor.DetalleCitasDiagnostico" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Detalle de Paciente - NeoSalud
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="../css/detalle-citas.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="detalle-container">
        <div class="detalle-card">
            <!-- Encabezado -->
            <div class="detalle-header">
                <h2><i class="fas fa-calendar-check me-2"></i>Historial de Citas</h2>
            </div>

            <!-- Panel de error -->
            <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="mensaje-error">
                <i class="fas fa-exclamation-circle me-2"></i>
                <asp:Label ID="lblMensajeError" runat="server"></asp:Label>
            </asp:Panel>

            <!-- Contenido principal -->
            <asp:Panel ID="pnlContenido" runat="server">
                <!-- Información del paciente -->
                <div class="paciente-info">
                    <div class="paciente-avatar">
                        <i class="fas fa-user-circle"></i>
                    </div>
                    <div class="paciente-datos">
                        <h3><asp:Label ID="lblNombrePaciente" runat="server" Text="Nombre del Paciente..."></asp:Label></h3>
                        <p><strong>DNI:</strong> <asp:Label ID="lblDniPaciente" runat="server" Text="..."></asp:Label></p>
                    </div>
                </div>

                <!-- Listado de citas -->
                <div class="citas-listado">
                    <h4><i class="fas fa-list-ul me-2"></i>Citas Registradas</h4>
                    
                    <asp:Repeater ID="rptCitas" runat="server" OnItemCommand="rptCitas_ItemCommand">
                        <ItemTemplate>
                            <div class='cita-item <%# Eval("estado").ToString() == "REALIZADA" ? "cita-realizada" : 
                                                  (Eval("estado").ToString() == "CANCELADA" ? "cita-cancelada" : "cita-pendiente") %>'>
                                <div class="cita-fecha">
                                    <div class="cita-dia"><%# ((DateTime)Eval("fecha")).ToString("dd") %></div>
                                    <div class="cita-mes"><%# ((DateTime)Eval("fecha")).ToString("MMM") %></div>
                                    <div class="cita-hora"><%# ((DateTime)Eval("hora")).ToString("HH:mm") %></div>
                                </div>
                                <div class="cita-info">
                                    <div class="cita-detalle">
                                        <h5><%# Eval("modalidad") %></h5>
                                        <span class='estado-cita <%# Eval("estado").ToString() == "REALIZADA" ? "estado-realizada" : 
                                                              (Eval("estado").ToString() == "CANCELADA" ? "estado-cancelada" : "estado-pendiente") %>'>
                                            <%# Eval("estado") %>
                                        </span>
                                    </div>
                                    <div class="cita-acciones">
                                        <asp:LinkButton runat="server" CommandName="GestionarDiagnostico" 
                                            CommandArgument='<%# Eval("idCita") %>' CssClass="btn-gestionar">
                                            <i class="fas fa-file-medical-alt me-1"></i> Gestionar Diagnóstico
                                        </asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                        <FooterTemplate>
                            <% if (rptCitas.Items.Count == 0) { %>
                                <div class="mensaje-vacio">
                                    <i class="fas fa-calendar-times fa-2x mb-2"></i>
                                    <p>Este paciente no tiene citas registradas</p>
                                </div>
                            <% } %>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
            </asp:Panel>

            <!-- Pie de página -->
            <div class="detalle-footer">
                <asp:Button ID="btnVolver" runat="server" Text="Volver al Listado" 
                    CssClass="btn-volver" OnClick="btnVolver_Click" />
            </div>
        </div>
    </div>
</asp:Content>