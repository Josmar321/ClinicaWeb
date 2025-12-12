<%@ Page Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="PerfilMedico.aspx.cs" Inherits="ClinicaWeb.admin.PerfilMedico" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Perfil del Médico - NeoSalud
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="d-flex justify-content-center mt-4">
        <div class="card shadow p-4" style="max-width: 600px; width: 100%;">
            <h3 class="mb-4 text-center">Perfil del Médico</h3>
            <h5 class="text-primary mb-4 text-center">
                <asp:Label ID="lblNombreCompleto" runat="server" Text=""></asp:Label>
            </h5>
            <div class="mb-2"><i class="fas fa-id-card"></i> <strong>Código:</strong> <asp:Label ID="lblCodigo" runat="server" /></div>
            <div class="mb-2"><i class="fas fa-envelope"></i> <strong>Email:</strong> <asp:Label ID="lblEmail" runat="server" /></div>
            <div class="mb-2"><i class="fas fa-certificate"></i> <strong>N° Colegiatura:</strong> <asp:Label ID="lblColegiatura" runat="server" /></div>
            <div class="mb-2"><i class="fas fa-phone"></i> <strong>Teléfono:</strong> <asp:Label ID="lblTelefono" runat="server" /></div>
            <div class="mb-2"><i class="fas fa-map-marker-alt"></i> <strong>Dirección:</strong> <asp:Label ID="lblDireccion" runat="server" /></div>
            <div class="mb-2"><i class="fas fa-venus-mars"></i> <strong>Género:</strong> <asp:Label ID="lblGenero" runat="server" /></div>
            <div class="mb-2"><i class="fas fa-calendar-alt"></i> <strong>Fecha de Nacimiento:</strong> <asp:Label ID="lblFechaNacimiento" runat="server" /></div>
            <div class="mb-2"><i class="fas fa-check-circle"></i> <strong>Estado:</strong> <asp:Label ID="lblEstado" runat="server" /></div>
            <div class="mb-4"><i class="fas fa-stethoscope"></i> <strong>Especialidad:</strong> <asp:Label ID="lblEspecialidad" runat="server" /></div>
            <div class="d-flex gap-2 justify-content-center">
                <asp:Button runat="server" ID="btnRegresar" CssClass="btn btn-secondary" Text="Regresar" OnClick="btnRegresar_Click" />
                <asp:Button runat="server" ID="btnEditar" CssClass="btn btn-primary" Text="Editar" OnClick="btnEditar_Click" />
                <asp:Button runat="server" ID="btnEliminar" CssClass="btn btn-danger" Text="Eliminar" OnClientClick="return confirmarEliminacion();" OnClick="btnEliminar_Click" />
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script type="text/javascript">
        function confirmarEliminacion() {
            return confirm("¿Estás seguro de que deseas eliminar este médico?");
        }
    </script>
</asp:Content>
