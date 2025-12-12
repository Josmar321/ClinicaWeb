<%@ Page Language="C#" MasterPageFile="~/doctor/DoctorMaster.Master" AutoEventWireup="true" CodeBehind="HistorialClinicoPaciente.aspx.cs" Inherits="ClinicaWeb.doctor.HistorialClinicoPaciente" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Historial Clínico - NeoSalud
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="../Content/doctor/HistorialClinico.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4 historial-container">
        <div class="card shadow-sm historial-card">
            <div class="card-header text-white historial-header">
                <h4 class="mb-0"><i class="fas fa-clipboard-list me-2"></i>Historial Clínico del Paciente</h4>
            </div>
            <div class="card-body">
                <asp:Label ID="lblMensaje" runat="server" CssClass="alert alert-danger" Visible="false" />
                
                <asp:Panel ID="pnlContenido" runat="server" Visible="false">
                    
                    <div class="card mb-4 patient-info-card">
                        <div class="card-body info-paciente-header">
                            <div class="row align-items-center">
                                <div class="col-md-8">
                                    <h5 class="mb-1 patient-name"><asp:Label ID="lblNombrePaciente" runat="server" /></h5>
                                    <p class="text-muted mb-1"><i class="fas fa-id-card me-1"></i><strong>DNI:</strong> <asp:Label ID="lblDniPaciente" runat="server" /></p>
                                    <p class="text-muted mb-0"><i class="fas fa-envelope me-1"></i><strong>Email:</strong> <asp:Label ID="lblEmailPaciente" runat="server" /></p>
                                </div>
                                <div class="col-md-4 text-md-end">
                                    <strong>Código Paciente:</strong>
                                    <span class="badge bg-secondary patient-code"><asp:Label ID="lblCodigoPaciente" runat="server" /></span>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer patient-notes" id="divObs" runat="server">
                            <strong><i class="fas fa-notes-medical me-2"></i>Observaciones Generales:</strong>
                            <asp:Label ID="lblObsGenerales" runat="server" />
                        </div>
                    </div>

                    <div class="card appointments-card">
                        <div class="card-header d-flex justify-content-between align-items-center appointments-header">
                            <h5 class="mb-0"><i class="fas fa-calendar-check me-2"></i>Citas Médicas</h5>
                            <asp:Button ID="btnAgregarCita" runat="server" Text="Agregar Nueva Cita" CssClass="btn btn-primary btn-sm btn-add-appointment" OnClick="btnAgregarCita_Click" />
                        </div>
                        <div class="card-body">
                            <asp:Repeater ID="rptCitas" runat="server" OnItemCommand="rptCitas_ItemCommand">
                                <ItemTemplate>
                                    <div class="card mb-3 cita-card appointment-item">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between">
                                                <div>
                                                    <strong>Fecha:</strong> <%# ((DateTime)Eval("fecha")).ToString("dd/MM/yyyy") %>
                                                    <strong class="ms-3">Hora:</strong> <%# ((DateTime)Eval("hora")).ToString("HH:mm") %>
                                                </div>
                                                <span class="badge appointment-status <%# GetStatusBadgeClass(Eval("estado").ToString()) %>"><%# Eval("estado") %></span>
                                            </div>
                                            <hr />
                                     
                                            <p class="mb-1"><strong>Modalidad:</strong> <%# Eval("modalidad") %></p>
                                            <p class="mb-2"><strong>Precio:</strong> S/ <%# Eval("precio","{0:N2}") %></p>
                                            <div class="text-end">
                                                <asp:LinkButton runat="server" CommandName="Editar" CommandArgument='<%# Eval("idCita") %>' CssClass="btn btn-outline-primary btn-sm btn-edit-appointment">
                                                    <i class="fas fa-pen me-1"></i> Editar Cita
                                                </asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <% if (rptCitas.Items.Count == 0) { %>
                                        <div class="alert alert-light text-center no-appointments">
                                            <i class="fas fa-calendar-times me-2"></i>Este paciente no tiene citas registradas.
                                        </div>
                                    <% } %>
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </asp:Panel>
            </div>
            <div class="card-footer historial-footer">
                <asp:Button runat="server" ID="btnVolver" Text="Volver al Listado" CssClass="btn btn-secondary btn-back" OnClick="btnVolver_Click" />
            </div>
        </div>
    </div>
</asp:Content>