<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ModificarCitaMedica.aspx.cs" Inherits="ClinicaWeb.admin.ModificarCitaMedica" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Modificar Cita Médica - NeoSalud</title>
    <link rel="stylesheet" href="../../styles.css" />
    <link rel="stylesheet" href="../../styles/admin.css" />
    <link rel="stylesheet" href="../../styles/historial.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <style>
        .form-group { margin-bottom: 1.1em; }
        .input-admin { width: 100%; padding: 0.4em 0.6em; border-radius: 6px; border: 1px solid #d0d7de;}
        .btn-accion-principal { background: #2563eb; color: #fff; border-radius: 7px; padding: 0.6em 1.5em; font-weight: 600; border:none;}
        .btn-volver { background: #eee; color: #1a237e; border-radius: 7px; padding: 0.6em 1.5em; border:none; font-weight: 600;}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="tarjeta-historial" style="max-width:600px;margin:2em auto;">
            <h2>Modificar Cita Médica</h2>
            <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje-error" />

            <asp:Panel runat="server" ID="pnlFormulario">
                <div class="form-group">
                    <label>Fecha:</label>
                    <asp:TextBox ID="txtFecha" runat="server" TextMode="Date" CssClass="input-admin" />
                </div>
                <div class="form-group">
                    <label>Hora:</label>
                    <asp:TextBox ID="txtHora" runat="server" TextMode="Time" CssClass="input-admin" />
                </div>
                <div class="form-group">
                    <label>Precio:</label>
                    <asp:TextBox ID="txtPrecio" runat="server" CssClass="input-admin" />
                </div>
                <div class="form-group">
                    <label>Estado:</label>
                    <asp:DropDownList ID="ddlEstado" runat="server" CssClass="input-admin" />
                </div>
                <div class="form-group">
                    <label>Modalidad:</label>
                    <asp:DropDownList ID="ddlModalidad" runat="server" CssClass="input-admin" />
                </div>
                <div class="form-group">
                    <label>Código Paciente:</label>
                    <asp:TextBox ID="txtCodigoPaciente" runat="server" CssClass="input-admin" ReadOnly="true" />
                </div>
                <div class="form-group">
                    <label>Médico:</label>
                    <asp:DropDownList ID="ddlMedico" runat="server" CssClass="input-admin" />
                </div>
                <div class="form-group">
                    <label>ID Consultorio:</label>
                    <asp:TextBox ID="txtIdConsultorio" runat="server" CssClass="input-admin" />
                </div>
                <div class="form-group">
                    <label>ID Historial:</label>
                    <asp:TextBox ID="txtIdHistorial" runat="server" CssClass="input-admin" />
                </div>
                <div class="form-group">
                    <label>Activo:</label>
                    <asp:CheckBox ID="chkActivo" runat="server" />
                </div>
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar Cambios" CssClass="btn-accion-principal" OnClick="btnGuardar_Click" />
                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn-volver" OnClick="btnCancelar_Click" CausesValidation="false" />
            </asp:Panel>
        </div>
    </form>
</body>
</html>
