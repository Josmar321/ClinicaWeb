<%@ Page Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="nueva-especialidad.aspx.cs" Inherits="ClinicaWeb.admin.nueva_especialidad" %>


<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
   Nueva Especialidad - NeoSalud
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

            <div class="pagina-gestion">
                <!-- Encabezado de la página -->
                <div class="encabezado-gestion">
                    <h1>Nueva Especialidad</h1>
                    <div class="acciones-gestion">
                        <asp:LinkButton ID="btnGuardar" runat="server" CssClass="btn btn-principal" OnClick="btnGuardar_Click">
                            <i class="fas fa-save"></i> Guardar
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnCancelar" runat="server" CssClass="btn btn-secundario" OnClick="btnCancelar_Click">
                            <i class="fas fa-times"></i> Cancelar
                        </asp:LinkButton>
                    </div>
                </div>

                <!-- Formulario -->
                <div class="formulario-gestion">
                    <div class="grid-formulario">
                        <div class="form-grupo">
                            <label for="txtIdEspecialidad">ID de la Especialidad</label>
                            <asp:TextBox ID="txtIdEspecialidad" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class="form-grupo">
                            <label for="txtNombre">Nombre de la Especialidad</label>
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" required></asp:TextBox>
                        </div>
                        <div class="form-grupo">
                            <label for="ddlEstado">Estado</label>
                            <asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Activo" Value="1"></asp:ListItem>
                                <asp:ListItem Text="No Activo" Value="0"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
            </div>
</asp:Content>