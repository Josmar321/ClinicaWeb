<%@ Page Title="Gestión de Diagnósticos" Language="C#" MasterPageFile="~/doctor/DoctorMaster.Master" AutoEventWireup="true" CodeBehind="GestionDiagnosticos.aspx.cs" Inherits="ClinicaWeb.doctor.GestionDiagnosticos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Gestión de Diagnósticos - NeoSalud
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="../css/gestion-diagnosticos.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="gestion-container">
        <div class="gestion-card">
            <!-- Encabezado principal -->
            <div class="gestion-header">
                <h2>Gestión de Pacientes y Diagnósticos</h2>
            </div>

            <!-- Sección de reportes -->
            <div class="reporte-section">
                <h3><i class="fas fa-file-pdf me-2"></i>Generar Reporte Personal de Citas</h3>
                <div class="filtro-fechas">
                    <div class="filtro-group">
                        <label for="<%=txtFechaInicio.ClientID %>">Fecha de Inicio:</label>
                        <asp:TextBox ID="txtFechaInicio" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                    </div>
                    <div class="filtro-group">
                        <label for="<%=txtFechaFin.ClientID %>">Fecha de Fin:</label>
                        <asp:TextBox ID="txtFechaFin" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                    </div>
                    <div class="filtro-group" style="align-self: flex-end;">
                        <asp:Button ID="btnGenerarReporte" runat="server" Text="Generar PDF" CssClass="btn-reporte" OnClick="btnGenerarReporte_Click" />
                    </div>
                </div>
                <asp:Label ID="lblReporteError" runat="server" CssClass="mensaje-error" Visible="false" />
            </div>
            
            <!-- Listado de pacientes -->
            <div class="pacientes-listado">
                <div class="d-flex align-items-center justify-content-between mb-3">
                    <h3><i class="fas fa-user-injured me-2"></i>Mis Pacientes Atendidos</h3>
                    <div class="d-flex" style="max-width: 400px;">
                        <asp:TextBox ID="txtBuscarId" runat="server" CssClass="form-control" placeholder="Buscar por DNI..." />
                        <asp:LinkButton ID="btnBuscar" runat="server" CssClass="btn-gestionar ms-2" OnClick="btnBuscar_Click">
                            <i class="fas fa-search"></i>
                        </asp:LinkButton>
                    </div>
                </div>
                
                <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje-error mb-3 d-block" />
                
                <asp:Repeater ID="rptPacientes" runat="server" OnItemCommand="rptPacientes_ItemCommand">
                    <ItemTemplate>
                        <div class="paciente-item">
                            <div class="paciente-info">
                                <div class="paciente-datos">
                                    <h3><%# Eval("nombre") %> <%# Eval("primerApellido") %> <%# Eval("segundoApellido") %></h3>
                                    <p><strong>DNI:</strong> <%# Eval("docIdentidad") %></p>
                                    <span class='badge-estado <%# Convert.ToBoolean(Eval("activo")) ? "badge-activo" : "badge-inactivo" %>'>
                                        <%# Convert.ToBoolean(Eval("activo")) ? "Activo" : "Inactivo" %>
                                    </span>
                                </div>
                                <asp:LinkButton runat="server" CommandName="Gestionar" CommandArgument='<%# Eval("docIdentidad") %>' CssClass="btn-gestionar">
                                    <i class="fas fa-notes-medical me-1"></i> Gestionar
                                </asp:LinkButton>
                            </div>
                        </div>
                    </ItemTemplate>
                    <FooterTemplate>
                        <% if (rptPacientes.Items.Count == 0) { %>
                            <div class="mensaje-vacio">
                                <i class="fas fa-user-slash fa-2x mb-2"></i>
                                <p class="mb-0">No se encontraron pacientes que usted haya atendido.</p>
                            </div>
                        <% } %>
                    </FooterTemplate>
                </asp:Repeater>
            </div>

            <!-- Paginación -->
            <div class="paginacion-gestion">
                <asp:Repeater ID="rptPaginas" runat="server" OnItemCommand="rptPaginas_ItemCommand">
                    <ItemTemplate>
                        <asp:PlaceHolder runat="server" Visible='<%# Convert.ToInt32(Eval("Numero")) == Convert.ToInt32(Eval("Actual")) %>'>
                            <span class="activo-pagina"><%# Eval("Numero") %></span>
                        </asp:PlaceHolder>
                        <asp:LinkButton runat="server" CommandName="Paginar" CommandArgument='<%# Eval("Numero") %>'
                            CssClass="btn-pagina" Visible='<%# Convert.ToInt32(Eval("Numero")) != Convert.ToInt32(Eval("Actual")) %>'>
                            <%# Eval("Numero") %>
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
</asp:Content>