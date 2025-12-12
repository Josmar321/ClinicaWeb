<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PerfilPaciente.aspx.cs" Inherits="ClinicaWeb.admin.PerfilPaciente" MasterPageFile="~/admin/AdminMaster.master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Perfil del Paciente - NeoSalud
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
        <div class="card shadow rounded-4 mx-auto" style="max-width: 700px;">
            <div class="card-body p-4">
                <h3 class="card-title text-center mb-4">Perfil del Paciente</h3>

                <h5 class="text-center text-primary mb-4">
                    <asp:Label ID="lblNombreCompleto" runat="server" />
                </h5>

                <div class="mb-2"><i class="fas fa-id-card"></i> <strong>Código:</strong> <asp:Label ID="lblCodigo" runat="server" /></div>
                <div class="mb-2"><i class="fas fa-envelope"></i> <strong>Email:</strong> <asp:Label ID="lblEmail" runat="server" /></div>
                <div class="mb-2"><i class="fas fa-phone"></i> <strong>Teléfono:</strong> <asp:Label ID="lblTelefono" runat="server" /></div>
                <div class="mb-2"><i class="fas fa-map-marker-alt"></i> <strong>Dirección:</strong> <asp:Label ID="lblDireccion" runat="server" /></div>
                <div class="mb-2"><i class="fas fa-venus-mars"></i> <strong>Género:</strong> <asp:Label ID="lblGenero" runat="server" /></div>
                <div class="mb-2"><i class="fas fa-calendar"></i> <strong>Fecha de Nacimiento:</strong> <asp:Label ID="lblFechaNacimiento" runat="server" /></div>
                <div class="mb-2"><i class="fas fa-city"></i> <strong>Ciudad:</strong> <asp:Label ID="lblCiudad" runat="server" /></div>
                <div class="mb-2"><i class="fas fa-globe"></i> <strong>Departamento:</strong> <asp:Label ID="lblDepartamento" runat="server" /></div>
                <div class="mb-2"><i class="fas fa-tint"></i> <strong>Tipo de Sangre:</strong> <asp:Label ID="lblTipoSangre" runat="server" /></div>
                <div class="mb-2"><i class="fas fa-weight"></i> <strong>Peso:</strong> <asp:Label ID="lblPeso" runat="server" /></div>
                <div class="mb-2"><i class="fas fa-ruler-vertical"></i> <strong>Altura:</strong> <asp:Label ID="lblAltura" runat="server" /></div>
                <div class="mb-2"><i class="fas fa-check-circle"></i> <strong>Estado:</strong> <asp:Label ID="lblEstado" runat="server" /></div>

                <div class="text-center mt-4">
                    <asp:Button ID="btnRegresar" runat="server" Text="Regresar" CssClass="btn btn-secondary" OnClick="btnRegresar_Click" />
                    <asp:Button ID="btnEditar" runat="server" Text="Editar" CssClass="btn btn-primary" OnClick="btnEditar_Click" />
                    <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn btn-danger" OnClick="btnEliminar_Click" />
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script type="text/javascript">
        function confirmarEliminacion() {
            return confirm("¿Estás seguro de que deseas eliminar este paciente?");
        }
    </script>
</asp:Content>
