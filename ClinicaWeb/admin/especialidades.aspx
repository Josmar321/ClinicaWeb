<%@ Page Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="especialidades.aspx.cs" Inherits="ClinicaWeb.admin.especialidades" %>


<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Especialidades - NeoSalud
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <main class="contenido-principal d-flex justify-content-center">
        <div class="w-100" style="max-width: 1000px;">
            <div class="pagina-gestion">
                <!-- Encabezado de la página -->
                <div class="encabezado-gestion">
                    <h1>Gestión de Especialidades</h1>
                    <div class="acciones-gestion">
                        <asp:LinkButton runat="server" CssClass="btn btn-principal" OnClick="IrNuevaEspecialidad">
                            <i class="fas fa-plus"></i> Nueva Especialidad
                        </asp:LinkButton>
                        <asp:LinkButton runat="server" CssClass="btn btn-secundario" PostBackUrl="~/admin/RepDiagnosticos.aspx">
                            <i class="fas fa-file-medical-alt"></i> Reporte de Diagnósticos
                        </asp:LinkButton>
                    </div>
                </div>

                <!-- Barra de búsqueda -->
                <div class="barra-busqueda">
                    <div class="buscador">
                        <i class="fas fa-search"></i>
                        <asp:TextBox ID="txtBuscar" runat="server" placeholder="Buscar especialidad..." CssClass="input-buscar" AutoPostBack="true" OnTextChanged="txtBuscar_TextChanged" />
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

                <!-- Lista de Especialidades -->
                <div class="grid-gestion">
                    <asp:Repeater ID="rptEspecialidades" runat="server" OnItemCommand="rptEspecialidades_ItemCommand">
                        <ItemTemplate>
                            <div class="tarjeta-gestion">
                                <div class="tarjeta-header">
                                    <div class='<%# (Convert.ToBoolean(Eval("activo")) ? "estado activo" : "estado inactivo") %>'>
                                        <%# (Convert.ToBoolean(Eval("activo")) ? "Activo" : "No Activo") %>
                                    </div>
                                    <div class="acciones-rapidas">
                                        <asp:LinkButton runat="server" 
                                            CssClass="btn-accion" 
                                            CommandName="Editar" 
                                            CommandArgument='<%# Eval("idEspecialidad") %>' 
                                            ToolTip="Editar">
                                            <i class="fas fa-edit"></i>
                                        </asp:LinkButton>
                                    </div>
                                </div>
                                <div class="tarjeta-contenido">
                                    <div class="especialidad-info-principal">
                                        <div class="icono-especialidad">
                                            <i class="fas fa-heartbeat"></i>
                                        </div>
                                        <div class="info-basica">
                                            <h3><%# Eval("nombre") %></h3>
                                        </div>
                                    </div>
                                    <div class="especialidad-acciones">
                                        <asp:HiddenField ID="hiddenEspecialidadNombre" runat="server" />
                                        <asp:LinkButton runat="server"
                                            CssClass="btn-accion-principal"
                                            CommandName="VerMedicos"
                                            CommandArgument='<%# Eval("idEspecialidad") %>'>
                                            <i class="fas fa-user-md"></i> Ver Médicos
                                        </asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </main>

<!-- Modal Médicos -->
<div class="modal fade" id="modalMedicos" tabindex="-1" aria-labelledby="modalMedicosLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalMedicosLabel">Médicos de la Especialidad</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
      </div>
      <div class="modal-body">
        <asp:Repeater ID="rptMedicos" runat="server">
            <HeaderTemplate>
                <table class="table">
                <thead>
                    <tr>
                    <th>Nombre completo</th>
                    <th>Email</th>
                    <th>Telefono</th>
                    <th>Estado</th>
                    </tr>
                </thead>
                <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td><%# Eval("nombre") %> <%# Eval("primerApellido") %> <%# Eval("segundoApellido") %></td>
                    <td><%# Eval("email") %></td>
                    <td><%# Eval("telefono") %></td>
                <td>
                    <%# (bool)Eval("activo") ? "Activo" : "Inactivo" %>
                </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </tbody>
                </table>
            </FooterTemplate>
        </asp:Repeater>
      </div>
    </div>
  </div>
</div>

</asp:Content>
