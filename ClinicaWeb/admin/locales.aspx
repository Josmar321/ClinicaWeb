<%@ Page Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="locales.aspx.cs" Inherits="ClinicaWeb.admin.locales" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Locales - NeoSalud
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <main class="contenido-principal">
        <div class="pagina-gestion">
            <!-- Encabezado de la página -->
            <div class="encabezado-gestion">
                <h1>Gestión de Locales</h1>
                <div class="acciones-gestion">
                    <asp:LinkButton ID="btnNuevoLocal" runat="server" CssClass="btn btn-principal" OnClick="IrNuevoLocal">
                        <i class="fas fa-plus"></i> Nuevo Local
                    </asp:LinkButton>
                </div>
            </div>

            <!-- Barra de búsqueda -->
            <div class="barra-busqueda">
                <div class="buscador">
                    <i class="fas fa-search"></i>
                    <asp:TextBox ID="txtBuscar" runat="server" placeholder="Buscar local..." CssClass="input-buscar" AutoPostBack="true" OnTextChanged="txtBuscar_TextChanged" />
                </div>
            </div>

            <!-- Filtros -->
            <div class="filtros-gestion">
                <div class="busqueda-avanzada">
                    <div class="grid-filtros">
                        <div class="form-grupo">
                            <label>Estado</label>
                            <asp:DropDownList ID="ddlEstado" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlEstado_SelectedIndexChanged">
                                <asp:ListItem Value="">Todos los estados</asp:ListItem>
                                    <asp:ListItem Value="activo">Activo</asp:ListItem>
                                    <asp:ListItem Value="inactivo">Inactivo</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Lista de Locales -->
            <div class="grid-gestion">
                <asp:Repeater ID="rptLocales" runat="server">
                    <ItemTemplate>
                        <div class="tarjeta-gestion">
                            <div class="tarjeta-header">
                                <div class='<%# (Convert.ToBoolean(Eval("activo")) ? "estado activo" : "estado inactivo") %>'>
                                    <%# (Convert.ToBoolean(Eval("activo")) ? "Activo" : "Inactivo") %>
                                </div>
                                <div class="acciones-rapidas">
                                    <a class="btn-accion" title="Editar" href='<%# "modificar-local.aspx?id=" + Eval("idLocal") %>'>
                                        <i class="fas fa-edit"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="tarjeta-contenido">
                                <div class="local-info-principal">
                                    <div class="info-basica">
                                        <p class="direccion">
                                            <i class="fas fa-map-marker-alt"></i>
                                            <%# Eval("direccion") %>
                                        </p>
                                        <p class="direccion">
                                            <i class="fas fa-map"></i>
                                            <%# Eval("ubigeo") %>
                                        </p>
                                    </div>
                                </div>
                                <div class="local-acciones">
                                    <button class="btn-accion-principal">
                                        <i class="fas fa-calendar-alt"></i>
                                        Ver Agenda
                                    </button>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </main>
</asp:Content>