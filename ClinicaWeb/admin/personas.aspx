<%@ Page Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="personas.aspx.cs" Inherits="ClinicaWeb.admin.personas" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Persona - NeoSalud
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>


<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    
            <div class="dashboard-contenido">
                <!-- Título -->
                <div class="mb-3">
                    <h1 class="mb-3">Gestión de Personas</h1>
                </div>

                <!-- Línea con buscador, filtros y botón -->
                <div class="d-flex justify-content-between align-items-end flex-wrap gap-3 mb-3">

                    <!-- Buscador FUNCIONAL -->
                    <div class="buscador flex-grow-1 me-3">
                        <i class="fas fa-search"></i>
                        <asp:TextBox ID="txtBuscar" runat="server" placeholder="Buscar persona..." CssClass="input-buscar" AutoPostBack="true" OnTextChanged="txtBuscar_TextChanged" />
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
                        <asp:Button ID="btnNuevaPersona" runat="server" Text="Nueva Persona" CssClass="btn btn-primary btn-sm" OnClick="IrNuevaPersona" />
                    </div>
                </div>
                <!-- Tabla -->
                <div class="container px-0">
                    <asp:GridView ID="gvPersonas" runat="server" CssClass="table table-hover table-striped"
                        PagerStyle-CssClass="pagination-container" PagerSettings-Mode="Numeric"
                        AutoGenerateColumns="false" AllowPaging="true" PageSize="4"
                        OnPageIndexChanging="gvPersonas_PageIndexChanging" EnableViewState="true"
                        OnRowDataBound="gvPersonas_RowDataBound">
                        <Columns>
                            <asp:BoundField HeaderText="Doc. Identidad" DataField="DocIdentidad" />
                            <asp:BoundField HeaderText="Nombre Completo" DataField="NombreCompleto" />
                            <asp:BoundField HeaderText="Rol" DataField="Rol" />
                            <asp:BoundField HeaderText="Estado" DataField="Activo" />
                            <asp:TemplateField HeaderText="Acciones">
                                <ItemTemplate>
                                    <asp:LinkButton runat="server" OnClick="btnModificar_Click" CommandArgument='<%# Eval("DocIdentidad") %>' CssClass="btn btn-sm btn-warning">
                                        <i class="fa-solid fa-pen"></i>
                                    </asp:LinkButton>
                                    <asp:LinkButton runat="server" ID="btnEliminar" OnClick="btnEliminar_Click"
                                        CommandArgument='<%# Eval("DocIdentidad") + "|" + Eval("Rol") %>'
                                        OnClientClick='<%# "return confirm(\"¿Estás seguro que deseas eliminar a esta persona?\");" %>'
                                        CssClass="btn btn-sm btn-danger">
                                        <i class="fa-solid fa-trash"></i>
                                    </asp:LinkButton>
                                    <asp:LinkButton runat="server" ID="btnVisualizar" OnClick="btnVisualizar_Click"
                                        CommandArgument='<%# Eval("DocIdentidad") + "|" + Eval("Rol") %>'
                                        CssClass="btn btn-sm btn-info">
                                        <i class="fa-solid fa-eye"></i>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
    </asp:Content>