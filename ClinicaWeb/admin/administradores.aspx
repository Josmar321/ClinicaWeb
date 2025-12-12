<%@ Page Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="administradores.aspx.cs" Inherits="ClinicaWeb.admin.administradores" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Administradores - NeoSalud
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="pagina-gestion">
        <h1>Gestión de Administradores</h1>

        <!-- Filtros -->
        <div class="grid-filtros">
            <div class="form-grupo">
                <label>Estado</label>
                <asp:DropDownList ID="ddlEstado" runat="server" AutoPostBack="true"
                    OnSelectedIndexChanged="ddlEstado_SelectedIndexChanged" CssClass="form-control">
                    <asp:ListItem Text="Activo" Value="activo" Selected="True" />
                    <asp:ListItem Text="Inactivo" Value="inactivo" />
                </asp:DropDownList>
            </div>
        </div>

        <!-- Buscador -->
        <div class="form-grupo" style="margin-top:1rem; max-width: 400px;">
            <label for="txtBuscarId">Buscar por código o nombre</label>
            <div style="display:flex;gap:0.5rem;">
                <asp:TextBox ID="txtBuscarId" runat="server" CssClass="form-control" placeholder="Buscar" />
                <asp:Button ID="btnBuscarId" runat="server" Text="Buscar" CssClass="btn-accion-principal" OnClick="btnBuscarId_Click" />
                <asp:Button ID="btnLimpiarBusqueda" runat="server" Text="Limpiar" CssClass="btn-accion-secundario" OnClick="btnLimpiarBusqueda_Click" />
            </div>
        </div>

        <!-- Lista -->
        <asp:Repeater ID="rptAdmins" runat="server" OnItemCommand="rptAdmins_ItemCommand">
            <HeaderTemplate><div class="grid-gestion"></HeaderTemplate>
            <ItemTemplate>
                <div class="tarjeta-gestion h-100 d-flex flex-column justify-content-between pb-3">
                    <div class="tarjeta-header">
                        <div class="estado <%# ((bool)Eval("activo")) ? "activo" : "inactivo" %>">
                            <%# ((bool)Eval("activo")) ? "Activo" : "Inactivo" %>
                        </div>
                    </div>
                    <div class="tarjeta-contenido">
                        <h3><%# Eval("nombre") %> <%# Eval("primerApellido") %> <%# Eval("segundoApellido") %></h3>
                        <div class="detalle-item"><i class="fas fa-id-card"></i> <strong>Código:</strong> <%# Eval("docIdentidad") %></div>
                        <div class="detalle-item d-flex align-items-start">
                            <i class="fas fa-envelope mt-1 me-1"></i>
                            <div>
                                <strong>Email:</strong><br />
                                <%# Eval("email") %>
                            </div>
                        </div>
                        <div class="d-flex justify-content-center gap-2 mt-3">
                            <asp:Button runat="server" CssClass="btn btn-outline-primary" Text="Ver Perfil"
                                CommandName="VerPerfil" CommandArgument='<%# Eval("docIdentidad") %>' />
                        </div>
                    </div>
                </div>
            </ItemTemplate>
            <FooterTemplate></div></FooterTemplate>
        </asp:Repeater>

        <!-- Paginación -->
        <div class="paginacion" style="display: flex; justify-content: center; align-items: center; margin: 2rem 0;">
            <asp:Button runat="server" ID="btnPagPrev" CssClass="btn-pagina" Text="&#60;" OnClick="btnPagPrev_Click" />
            <asp:Repeater runat="server" ID="rptPaginas">
                <ItemTemplate>
                    <asp:Button runat="server"
                        CssClass='<%# (Convert.ToInt32(Container.DataItem) == (ViewState["CurrentPage"] == null ? 1 : Convert.ToInt32(ViewState["CurrentPage"]))) ? "btn-pagina activo" : "btn-pagina" %>'
                        Text='<%# Container.DataItem.ToString() %>'
                        CommandArgument='<%# Container.DataItem.ToString() %>'
                        OnClick="btnPag_Click" />
                </ItemTemplate>
            </asp:Repeater>
            <asp:Button runat="server" ID="btnPagNext" CssClass="btn-pagina" Text="&#62;" OnClick="btnPagNext_Click" />
        </div>
    </div>
</asp:Content>
