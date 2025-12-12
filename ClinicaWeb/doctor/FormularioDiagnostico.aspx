<%@ Page Title="Registro de Diagnóstico" Language="C#" MasterPageFile="~/doctor/DoctorMaster.Master" AutoEventWireup="true" CodeBehind="FormularioDiagnostico.aspx.cs" Inherits="ClinicaWeb.doctor.FormularioDiagnostico" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Diagnóstico y Tratamiento - NeoSalud
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .contexto-cita {
            background-color: #e9ecef;
            border: 1px solid #dee2e6;
            padding: 1rem;
            border-radius: .25rem;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid mt-4">
        <asp:Panel ID="pnlError" runat="server" Visible="false">
            <div class="alert alert-danger">
                <asp:Label ID="lblMensajeError" runat="server"></asp:Label>
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlContenido" runat="server">
            <div class="card shadow-sm">
                <div class="card-header">
                    <h4 class="mb-0">Registro de Diagnóstico y Tratamiento</h4>
                </div>
                <div class="card-body">

                    <div class="contexto-cita mb-4">
    <h5>Información del Paciente y Cita</h5>
    <p class="mb-1"><strong>Paciente:</strong> <asp:Label ID="lblNombrePaciente" runat="server"></asp:Label></p>
    <p class="mb-1"><strong>DNI:</strong> <asp:Label ID="lblDniPaciente" runat="server"></asp:Label></p>
    <p class="mb-0"><strong>Fecha de la Cita:</strong> <asp:Label ID="lblFechaCita" runat="server"></asp:Label></p>
</div>

                    <asp:HiddenField ID="hdnDiagnosticoId" runat="server" Value="0" />
                    <asp:HiddenField ID="hdnTratamientoId" runat="server" Value="0" />

                    <div class="mb-3">
                        <label for="txtDiagnostico" class="form-label"><strong>Diagnóstico del Médico:</strong></label>
                        <asp:TextBox ID="txtDiagnostico" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" placeholder="Describa el diagnóstico..."></asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <label for="txtTratamiento" class="form-label"><strong>Tratamiento a Seguir:</strong></label>
                        <asp:TextBox ID="txtTratamiento" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" placeholder="Describa el tratamiento y las indicaciones..."></asp:TextBox>
                    </div>
                     <asp:Label ID="lblMensajeExito" runat="server" CssClass="text-success" Visible="false" />
                </div>
                <div class="card-footer bg-light text-end">
                    <asp:Button ID="btnVolver" runat="server" Text="Volver" CssClass="btn btn-secondary me-2" OnClick="btnVolver_Click" />
                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar Cambios" CssClass="btn btn-success" OnClick="btnGuardar_Click" />
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>