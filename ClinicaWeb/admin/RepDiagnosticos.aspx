<%@ Page Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="RepDiagnosticos.aspx.cs" Inherits="ClinicaWeb.admin.RepDiagnosticos" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Reporte de Diagnósticos
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5" style="max-width: 700px;">
        <div class="card shadow-sm border-0">
            <div class="card-body">
                <h3 class="mb-4 text-center text-primary fw-semibold">
                    <i class="fas fa-file-medical-alt me-2"></i>Generar Reporte de Diagnósticos por Especialidad
                </h3>

                <!-- Dropdown de especialidad -->
                <div class="mb-3">
                    <label for="ddlEspecialidades" class="form-label">Seleccione Especialidad</label>
                    <asp:DropDownList ID="ddlEspecialidades" runat="server" CssClass="form-select">
                        <asp:ListItem Text="-- Seleccionar --" Value="" />
                    </asp:DropDownList>
                </div>

                <!-- Fechas -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <label class="form-label">Fecha de inicio</label>
                        <asp:TextBox ID="txtFechaInicio" runat="server" CssClass="form-control" TextMode="Date" />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Fecha de fin</label>
                        <asp:TextBox ID="txtFechaFin" runat="server" CssClass="form-control" TextMode="Date" />
                    </div>
                </div>

                <!-- Botón de generar -->
                <asp:Button ID="btnGenerarReporte" runat="server" CssClass="btn btn-generar w-100" Text="Generar Reporte" OnClientClick="return abrirReporte();" UseSubmitBehavior="false" />
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function abrirReporte() {
            const esp = document.getElementById('<%= ddlEspecialidades.ClientID %>').value;
            const ini = document.getElementById('<%= txtFechaInicio.ClientID %>').value;
            const fin = document.getElementById('<%= txtFechaFin.ClientID %>').value;

            if (!esp || !ini || !fin) {
                alert("Complete todos los campos.");
                return false;
            }

            const url = `RepDiagnosticos.aspx?especialidad=${encodeURIComponent(esp)}&inicio=${ini}&fin=${fin}`;
            window.open(url, '_blank');
            return false;
        }
    </script>

    <style>
        .btn-generar {
            background-color: #0066cc; /* Azul tipo logo */
            color: white;
        }

        .btn-generar:hover {
            background-color: #004f99;
            color: white;
        }
    </style>
</asp:Content>
