<%@ Page Title="Gestión de Historial Clínico" Language="C#" MasterPageFile="~/doctor/DoctorMaster.Master" AutoEventWireup="true" CodeBehind="GestionHistorialClinico.aspx.cs" Inherits="ClinicaWeb.doctor.GestionHistorialClinico" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Gestión de Historial Clínico - NeoSalud
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="../css/gestion-historial.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="historial-container">
        <div class="historial-card">
            <!-- Encabezado -->
            <div class="historial-header">
                <h2><i class="fas fa-clipboard-medical me-2"></i>Historial Clínico de Pacientes</h2>
                <div class="historial-buscador">
                    <asp:TextBox ID="txtBuscarId" runat="server" CssClass="form-control" placeholder="Buscar por DNI..." />
                    <asp:LinkButton ID="btnBuscar" runat="server" CssClass="btn-buscar" OnClick="btnBuscar_Click">
                        <i class="fas fa-search"></i>
                    </asp:LinkButton>
                </div>
            </div>

            <!-- Cuerpo -->
            <div class="historial-body">
                <!-- Mensaje de error -->
                <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje-error" Visible="false" />

                <!-- Listado de pacientes -->
                <asp:Repeater ID="rptPacientes" runat="server" OnItemCommand="rptPacientes_ItemCommand">
                    <ItemTemplate>
                        <div class="paciente-item">
                            <div class="paciente-info">
                                <div class="paciente-avatar">
                                    <i class="fas fa-user-circle"></i>
                                </div>
                                <div class="paciente-datos">
                                    <h3><%# Eval("nombre") %> <%# Eval("primerApellido") %> <%# Eval("segundoApellido") %></h3>
                                    <p><strong>DNI:</strong> <%# Eval("docIdentidad") %></p>
                                </div>
                            </div>
                            <div class="paciente-estado">
                                <span class='badge-estado <%# Convert.ToBoolean(Eval("activo")) ? "badge-activo" : "badge-inactivo" %>'>
                                    <%# Convert.ToBoolean(Eval("activo")) ? "Activo" : "Inactivo" %>
                                </span>
                                <asp:LinkButton runat="server" CommandName="VerHistorial" 
                                    CommandArgument='<%# Eval("docIdentidad") %>' CssClass="btn-ver-historial">
                                    <i class="fas fa-history me-1"></i> Ver Historial
                                </asp:LinkButton>
                            </div>
                        </div>
                    </ItemTemplate>
                    <FooterTemplate>
                        <% if (rptPacientes.Items.Count == 0) { %>
                            <div class="mensaje-vacio">
                                <i class="fas fa-user-slash fa-2x mb-2"></i>
                                <p>Usted no tiene pacientes atendidos registrados</p>
                            </div>
                        <% } %>
                    </FooterTemplate>
                </asp:Repeater>
            </div>

            <!-- Paginación -->
            <div class="historial-paginacion">
                <asp:Repeater ID="rptPaginas" runat="server" OnItemCommand="rptPaginas_ItemCommand">
                    <ItemTemplate>
                        <asp:PlaceHolder runat="server" Visible='<%# Convert.ToInt32(Eval("Numero")) == Convert.ToInt32(Eval("Actual")) %>'>
                            <span class="pagina-activa"><%# Eval("Numero") %></span>
                        </asp:PlaceHolder>
                        <asp:LinkButton runat="server" CommandName="Paginar" 
                            CommandArgument='<%# Eval("Numero") %>' CssClass="pagina-link"
                            Visible='<%# Convert.ToInt32(Eval("Numero")) != Convert.ToInt32(Eval("Actual")) %>'>
                            <%# Eval("Numero") %>
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
</asp:Content>