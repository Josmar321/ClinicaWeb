<%@ Page Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="medicos.aspx.cs" Inherits="ClinicaWeb.admin.medicos" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Médicos - NeoSalud
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="pagina-gestion">
        <h1>Gestión de Médicos</h1>

        <!-- Filtros -->
        <div class="d-flex gap-3 mb-3">
            <div class="form-grupo flex-fill">
                <label>Especialidad</label>
                <asp:DropDownList ID="ddlEspecialidad" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlEspecialidad_SelectedIndexChanged" CssClass="form-control" />
            </div>
            <div class="form-grupo flex-fill">
                <label>Estado</label>
                <asp:DropDownList ID="ddlEstado" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlEstado_SelectedIndexChanged" CssClass="form-control">
                    <asp:ListItem Text="Activo" Value="activo" Selected="True" />
                    <asp:ListItem Text="Inactivo" Value="inactivo" />
                </asp:DropDownList>
            </div>
        </div>

        <!-- Buscador -->
        <div class="form-grupo mb-4" style="max-width: 400px;">
            <label for="txtBuscarId">Buscar por Código, Nombre o Especialidad</label>
            <div style="display:flex;gap:0.5rem;">
                <asp:TextBox ID="txtBuscarId" runat="server" CssClass="form-control" placeholder="Buscar" />
                <asp:Button ID="btnBuscarId" runat="server" Text="Buscar" CssClass="btn-accion-principal" OnClick="btnBuscarId_Click" />
                <asp:Button ID="btnLimpiarBusqueda" runat="server" Text="Limpiar" CssClass="btn-accion-secundario" OnClick="btnLimpiarBusqueda_Click" />
            </div>
        </div>

        <!-- Lista de Médicos -->
        <asp:Repeater ID="rptMedicos" runat="server" OnItemCommand="rptMedicos_ItemCommand">
            <HeaderTemplate><div class="grid-gestion"></HeaderTemplate>
                <ItemTemplate>
                  <div class="tarjeta-gestion">
                    <div>
                      <div class="tarjeta-header">
                        <div class="estado <%# ((bool)Eval("activo")) ? "activo" : "inactivo" %>">
                          <%# ((bool)Eval("activo")) ? "Activo" : "Inactivo" %>
                        </div>
                      </div>
                      <div class="tarjeta-contenido">
                        <h3><%# "Dr. " + Eval("nombre") + " " + Eval("primerApellido") + " " + Eval("segundoApellido") %></h3>
                        <div class="detalle-item"><strong>Especialidad:</strong> <%# Eval("especialidad") != null ? Eval("especialidad.nombre") : "-" %></div>
                        <div class="detalle-item"><i class="fas fa-id-card"></i> <strong>Código:</strong> <%# Eval("docIdentidad") %></div>
                        <div class="detalle-item d-flex align-items-start">
                            <i class="fas fa-envelope mt-1 me-1"></i>
                            <div>
                                <strong>Email:</strong><br />
                                <%# Eval("email") %>
                            </div>
                        </div>
                      </div>
                    </div>
                    <div class="d-flex justify-content-center gap-2 mt-3">
                      <asp:Button runat="server" CssClass="btn btn-primary btn-sm px-3 text-white" Text="Ver Historial" CommandName="VerHistorial" CommandArgument='<%# Eval("docIdentidad") %>' />
                      <asp:Button runat="server" CssClass="btn btn-outline-primary" Text="Ver Perfil" CommandName="VerPerfil" CommandArgument='<%# Eval("docIdentidad") %>' />
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
                    <asp:Button runat="server" CssClass='<%# (Convert.ToInt32(Container.DataItem) == (ViewState["CurrentPage"] == null ? 1 : Convert.ToInt32(ViewState["CurrentPage"]))) ? "btn-pagina activo" : "btn-pagina" %>'
                        Text='<%# Container.DataItem.ToString() %>' CommandArgument='<%# Container.DataItem.ToString() %>' OnClick="btnPag_Click" />
                </ItemTemplate>
            </asp:Repeater>
            <asp:Button runat="server" ID="btnPagNext" CssClass="btn-pagina" Text="&#62;" OnClick="btnPagNext_Click" />
        </div>
    </div>
</asp:Content>
