<%@ Page Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="admin-perfil.aspx.cs" Inherits="ClinicaWeb.admin.admin_perfil" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Perfil del Administrador - NeoSalud
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="d-flex justify-content-center align-items-center mt-5">
        <div class="card shadow-lg" style="width: 40rem;">
            <div class="card-body">
                <h4 class="card-title mb-3 text-center">Perfil del Administrador</h4>
                <h5 class="card-subtitle mb-4 text-primary text-center"><asp:Label ID="lblNombreCompleto" runat="server" /></h5>

                <p><i class="fas fa-id-card me-2"></i><b>Código:</b> <asp:Label ID="lblCodigo" runat="server" /></p>
                <p><i class="fas fa-envelope me-2"></i><b>Email:</b> <asp:Label ID="lblEmail" runat="server" /></p>
                <p><i class="fas fa-phone me-2"></i><b>Teléfono:</b> <asp:Label ID="lblTelefono" runat="server" /></p>
                <p><i class="fas fa-map-marker-alt me-2"></i><b>Dirección:</b> <asp:Label ID="lblDireccion" runat="server" /></p>
                <p><i class="fas fa-venus-mars me-2"></i><b>Género:</b> <asp:Label ID="lblGenero" runat="server" /></p>
                <p><i class="fas fa-birthday-cake me-2"></i><b>Fecha de Nacimiento:</b> <asp:Label ID="lblFechaNacimiento" runat="server" /></p>
                <p><i class="fas fa-check-circle me-2"></i><b>Estado:</b> <asp:Label ID="lblEstado" runat="server" /></p>

                <div class="mt-4 d-flex justify-content-between">
                    <asp:Button ID="btnRegresar" runat="server" Text="Regresar" CssClass="btn btn-secondary" OnClick="btnRegresar_Click" />
                    <asp:Button ID="btnEditar" runat="server" Text="Editar" CssClass="btn btn-primary" OnClick="btnEditar_Click" />
                    <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn btn-danger" OnClientClick="return confirmarEliminar();" OnClick="btnEliminar_Click" />
                </div>
            </div>
        </div>
    </div>

    <script>
        function confirmarEliminar() {
            return confirm("¿Estás seguro que deseas eliminar este administrador?");
        }
    </script>
</asp:Content>
