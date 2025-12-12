<%@ Page Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="agregar-usuario.aspx.cs" Inherits="ClinicaWeb.admin.agregar_usuario" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Agregar Usuario - NeoSalud
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- TODO: Pega aquí el contenido específico de la página, por ejemplo el formulario de usuario -->
 <!--  ------------------------------------------------------------------------------------------------------------------- -->        
        <div class="container mt-4">
                    <div class="card shadow">
                        <div class="card-header text-white" style="background-color: #2c3e50;">
                            <h4><asp:Label ID="lblTitulo" runat="server" Text="Label"></asp:Label></h4>
                        </div>
                        <div class="card-body">
                            <div class="mb-3 row">
                                <label for="txtIDUsuario" class="col-sm-2 col-form-label">Id Usuario:</label>
                                <div class="col-sm-4">
                                    <asp:TextBox ID="txtIDUsuario" CssClass="form-control" runat="server" Enabled="false"></asp:TextBox>
                                </div>
                            </div>
                            <div class="mb-3 row">
                                <label for="txtUsername" class="col-sm-2 col-form-label">Username:</label>
                                <div class="col-sm-6">
                                    <asp:TextBox ID="txtUsername" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="mb-3 row">
                                <label for="txtPassword" class="col-sm-2 col-form-label">Contraseña:</label>
                                <div class="col-sm-6">
                                    <div class="input-group">
                                        <asp:TextBox ID="txtPassword" CssClass="form-control" TextMode="Password" runat="server"></asp:TextBox>
                                        <button class="btn btn-outline-secondary" type="button" onclick="togglePassword()" tabindex="-1">
                                            <i class="fa fa-eye" id="toggleIcon"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="mb-3 row">
                                <label for="ddlRol" class="col-sm-2 col-form-label">Rol:</label>
                                <div class="col-sm-6">
                                    <asp:DropDownList ID="ddlRol" CssClass="form-select" runat="server">
                                        <asp:ListItem Text="Seleccione un rol" Value="" />
                                        <asp:ListItem Text="Medico" Value="MEDICO" />
                                        <asp:ListItem Text="Administrador" Value="ADMINISTRADOR" />
                                        <asp:ListItem Text="Paciente" Value="PACIENTE" />
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <asp:Panel ID="panelEstado" runat="server" Visible="false">
                                <div class="mb-3 row">
                                    <label for="ddlEstado" class="col-sm-2 col-form-label">Estado:</label>
                                    <div class="col-sm-6">
                                        <asp:DropDownList ID="ddlEstado" CssClass="form-select" runat="server">
                                            <asp:ListItem Text="Activo" Value="Activo" />
                                            <asp:ListItem Text="Inactivo" Value="Inactivo" />
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </asp:Panel>
                        </div>
                        <div class="card-footer text-end">
                            <asp:LinkButton ID="btnGuardar" CssClass="btn btn-success" runat="server" OnClick="btnGuardar_Click"></asp:LinkButton>
                            <asp:LinkButton ID="btnRegresar" CssClass="btn btn-secondary ms-2" runat="server" OnClick="btnRegresar_Click">
                                <i class="fa-solid fa-arrow-left me-1"></i> Regresar
                            </asp:LinkButton>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="errorModal" tabindex="-1" aria-labelledby="errorModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header bg-danger text-white">
                                <h5 class="modal-title" id="errorModalLabel">
                                    <i class="fa-solid fa-triangle-exclamation me-2"></i>Mensaje de Error
                                </h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <asp:Label ID="lblMensajeError" runat="server" Text="Label" CssClass="form-text text-danger"></asp:Label>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>
    <script type="text/javascript">
    function togglePassword() {
        var passwordInput = document.getElementById('<%= txtPassword.ClientID %>');
        var icon = document.getElementById("toggleIcon");
        if (passwordInput.type === "password") {
            passwordInput.type = "text";
            icon.classList.remove("fa-eye");
            icon.classList.add("fa-eye-slash");
        } else {
            passwordInput.type = "password";
            icon.classList.remove("fa-eye-slash");
            icon.classList.add("fa-eye");
        }
    }
    </script>

</asp:Content>