<%@ Page Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="usuarios.aspx.cs" Inherits="ClinicaWeb.admin.usuarios" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Usuario - NeoSalud
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>


<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    
            <div class="dashboard-contenido">
                <!-- Título -->
                <div class="mb-3">
                    <h1 class="mb-3">Gestión de Usuarios</h1>
                </div>

                <!-- Línea con buscador, filtros y botón -->
                <div class="d-flex justify-content-between align-items-end flex-wrap gap-3 mb-3">

                    <!-- Buscador FUNCIONAL -->
                    <div class="buscador flex-grow-1 me-3">
                        <i class="fas fa-search"></i>
                        <asp:TextBox ID="txtBuscar" runat="server" placeholder="Buscar usuario..." CssClass="input-buscar" AutoPostBack="true" OnTextChanged="txtBuscar_TextChanged" />
                    </div>

                    <!-- Filtros -->
                    <div class="d-flex gap-3">
                        <div>
                            <label class="form-label">Estado</label>
                            <asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-select form-select-sm"
                                AutoPostBack="true" OnSelectedIndexChanged="ddlEstado_SelectedIndexChanged">
                                <asp:ListItem Value="">Selecciona un Estado</asp:ListItem>
                                <asp:ListItem Value="activo">Activo</asp:ListItem>
                                <asp:ListItem Value="inactivo">Inactivo</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div>
                            <label class="form-label">Rol</label>
                            <asp:DropDownList ID="ddlRol" runat="server" CssClass="form-select form-select-sm"
                                AutoPostBack="true" OnSelectedIndexChanged="ddlRol_SelectedIndexChanged">
                                <asp:ListItem Value="">Selecciona un Rol</asp:ListItem>
                                <asp:ListItem Value="ADMINISTRADOR">Administrador</asp:ListItem>
                                <asp:ListItem Value="MEDICO">Médico</asp:ListItem>
                                <asp:ListItem Value="PACIENTE">Paciente</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>

                    <!-- Botón a la derecha -->
                    <div>
                        <asp:Button ID="btnNuevoUsuario" runat="server" Text="Nuevo Usuario" CssClass="btn btn-primary btn-sm" OnClick="IrNuevoUsuario" />
                    </div>

                </div>
                <!-- Tabla -->
                <div class="container px-0">
                    <asp:GridView ID="gvUsuarios" runat="server" CssClass="table table-hover table-striped"
                        PagerStyle-CssClass="pagination-container" PagerSettings-Mode="Numeric"
                        AutoGenerateColumns="false" AllowPaging="true" PageSize="4"
                        OnPageIndexChanging="gvUsuarios_PageIndexChanging" EnableViewState="true"
                        OnRowDataBound="gvUsuarios_RowDataBound">
                        <Columns>
                            <asp:BoundField HeaderText="IdUsuario" DataField="IdUsuario" />
                            <asp:BoundField HeaderText="Nombre del Usuario" DataField="Username" />
                            <asp:BoundField HeaderText="Rol" DataField="Rol" />
                            <asp:BoundField HeaderText="Estado" DataField="Activo" />
                            <asp:TemplateField HeaderText="Acciones">
                                <ItemTemplate>
                                    <asp:LinkButton runat="server" OnClick="btnModificar_Click" CommandArgument='<%# Eval("idUsuario") %>' CssClass="btn btn-sm btn-warning">
                                        <i class="fa-solid fa-pen"></i>
                                    </asp:LinkButton>
                                    <asp:LinkButton runat="server" ID="btnEliminar" OnClick="btnEliminar_Click"
                                        CommandArgument='<%# Eval("idUsuario") %>'
                                        OnClientClick='<%# "return confirm(\"¿Estás seguro que deseas eliminar al usuario " + Eval("username") + "?\");" %>'
                                        CausesValidation="false" UseSubmitBehavior="false" CssClass="btn btn-sm btn-danger">
                                        <i class="fa-solid fa-trash"></i>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
    </asp:Content>