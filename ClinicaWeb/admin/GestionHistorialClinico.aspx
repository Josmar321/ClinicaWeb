<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GestionHistorialClinico.aspx.cs" Inherits="ClinicaWeb.admin.GestionHistorialClinico" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Historial Clínico - NeoSalud</title>
    <link rel="stylesheet" href="../../styles.css" />
    <link rel="stylesheet" href="../../styles/admin.css" />
    <link rel="stylesheet" href="../../styles/medicos.css" />
    <link rel="stylesheet" href="../../styles/historial.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <style>
        
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="contenedor-admin">
            <aside class="sidebar">
                <div class="logo-sidebar">
                    <i class="fas fa-heartbeat"></i>
                    <h2>NeoSalud</h2>
                </div>
                <nav class="menu-admin">
                    <ul>
                        <li><asp:LinkButton runat="server" ID="btnDashboard" OnClick="btnDashboard_Click"><i class="fas fa-home"></i> Dashboard</asp:LinkButton></li>
                        <li><asp:LinkButton runat="server" ID="btnUsuarios" OnClick="btnUsuarios_Click"><i class="fas fa-users"></i> Usuarios</asp:LinkButton></li>
                        <li><asp:LinkButton runat="server" ID="btnMedicos" OnClick="btnMedicos_Click"><i class="fas fa-user-md"></i> Médicos</asp:LinkButton></li>
                        <li><asp:LinkButton runat="server" ID="btnEspecialidades" OnClick="btnEspecialidades_Click"><i class="fas fa-stethoscope"></i> Especialidades</asp:LinkButton></li>
                        <li><asp:LinkButton runat="server" ID="btnLocales" OnClick="btnLocales_Click"><i class="fas fa-hospital"></i> Locales</asp:LinkButton></li>
                        <li><asp:LinkButton runat="server" ID="btnReportes" OnClick="btnReportes_Click"><i class="fas fa-chart-bar"></i> Reportes</asp:LinkButton></li>
                        <li><asp:LinkButton runat="server" ID="btnConfiguracion" OnClick="btnConfiguracion_Click"><i class="fas fa-cog"></i> Configuración</asp:LinkButton></li>
                    </ul>
                </nav>
            </aside>
            <main class="contenido-principal">
                <div class="pagina-gestion">
                    <div class="tarjeta-gestion">
                        <div class="header-lista">
                            <h2 style="margin-bottom:0;">Lista de Pacientes</h2>
                            <div class="buscador-id">
                                <asp:TextBox ID="txtBuscarId" runat="server" placeholder="Buscar por ID..." MaxLength="25" />
                                <button type="button" onclick="__doPostBack('btnBuscar','')"><i class="fas fa-search"></i></button>
                            </div>
                        </div>
                        <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje-error" />
                        <div class="paciente-listado">
                            <asp:Repeater ID="rptPacientes" runat="server" OnItemCommand="rptPacientes_ItemCommand">
                                <ItemTemplate>
                                    <div class="card-paciente">
                                        <span class='<%# Convert.ToBoolean(Eval("activo")) ? "badge-activo" : "badge-inactivo" %>'>
                                            <%# Convert.ToBoolean(Eval("activo")) ? "Activo" : "Inactivo" %>
                                        </span>
                                        <h3>
                                            <%# Eval("nombre") %> <%# Eval("primerApellido") %> <%# Eval("segundoApellido") %>
                                        </h3>
                                        <div><i class="fas fa-id-badge"></i> <b>Código:</b> <%# Eval("codigoPaciente") %></div>
                                        <div><i class="fas fa-envelope"></i> <b>Email:</b> <%# Eval("email") %></div>
                                        <div><i class="fas fa-phone"></i> <b>Teléfono:</b> <%# Eval("telefono") %></div>
                                        <div><i class="fas fa-map-marker-alt"></i> <b>Dirección:</b> <%# Eval("direccion") %></div>
                                        <div class="acciones-paciente">
                                            <asp:Button runat="server" CommandName="VerPerfil" CommandArgument='<%# Eval("codigoPaciente") %>' CssClass="btn-accion-principal" Text="Ver Perfil" />
                                            <asp:Button runat="server" CommandName="VerHistorial" CommandArgument='<%# Eval("codigoPaciente") %>' CssClass="btn-accion-secundario" Text="Ver Historial" />
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        <div class="paginacion">
                            <asp:Repeater ID="rptPaginas" runat="server" OnItemCommand="rptPaginas_ItemCommand">
                                <ItemTemplate>
    <%# Convert.ToInt32(Eval("Numero")) == Convert.ToInt32(Eval("Actual"))
        ? $"<span class='activo-pagina'>{Eval("Numero")}</span>"
        : "" %>
    <asp:LinkButton
        runat="server"
        CommandName="Paginar"
        CommandArgument='<%# Eval("Numero") %>'
        CssClass="pagina-btn"
        Visible='<%# Convert.ToInt32(Eval("Numero")) != Convert.ToInt32(Eval("Actual")) %>'>
        <%# Eval("Numero") %>
    </asp:LinkButton>
</ItemTemplate>

                            </asp:Repeater>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </form>
</body>
</html>
