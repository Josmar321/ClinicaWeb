<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InsertarCitaMedica.aspx.cs" Inherits="ClinicaWeb.admin.InsertarCitaMedica" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registrar Cita Médica - NeoSalud</title>
    <link rel="stylesheet" href="../../styles.css" />
    <link rel="stylesheet" href="../../styles/admin.css" />
    <link rel="stylesheet" href="../../styles/medicos.css" />
    <link rel="stylesheet" href="../../styles/historial.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <style>
        .form-cita { background: #fff; max-width: 520px; margin: 2em auto; padding: 2em 2.2em; border-radius: 13px; box-shadow: 0 2px 10px 0 rgba(31, 35, 41, 0.08);}
        .form-cita h2 { margin-bottom: 1.3em; }
        .form-cita label { font-weight: 600; margin-top: 7px; display:block;}
        .form-cita input, .form-cita select { width: 100%; margin: 0.4em 0 1.2em 0; padding: 0.5em 0.6em; border: 1px solid #d0d7de; border-radius: 6px;}
        .btn-form { background: #2563eb; color: #fff; padding: 0.7em 2.2em; border: none; border-radius: 7px; font-size: 1em; font-weight: 600; cursor: pointer;}
        .btn-form:hover { background: #173ea6; }
        .mensaje-error { color: #e11d48; margin-bottom: 8px;}
        .btn-volver { background: #eee; color: #1a237e; border-radius: 7px; padding: 0.5em 2em; border: none; font-weight: bold; margin-left: 1em; }
        .btn-volver:hover { background: #d5e2ff; color: #0046ac; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-cita">
            <h2>Registrar Cita Médica</h2>
            <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje-error" />
            <label>Fecha:</label>
            <asp:TextBox ID="txtFecha" runat="server" TextMode="Date" required="true"/>
            <label>Hora:</label>
            <asp:TextBox ID="txtHora" runat="server" TextMode="Time" required="true"/>
            <label>Precio:</label>
            <asp:TextBox ID="txtPrecio" runat="server" TextMode="Number" required="true"/>
            <label>Estado:</label>
            <asp:DropDownList ID="ddlEstado" runat="server">
                <asp:ListItem Text="PROGRAMADA" Value="PROGRAMADA" />
                <asp:ListItem Text="CANCELADA" Value="CANCELADA" />
                <asp:ListItem Text="REALIZADA" Value="REALIZADA" />
            </asp:DropDownList>
            <label>Modalidad:</label>
            <asp:DropDownList ID="ddlModalidad" runat="server">
                <asp:ListItem Text="PRESENCIAL" Value="PRESENCIAL" />
                <asp:ListItem Text="VIRTUAL" Value="VIRTUAL" />
            </asp:DropDownList>
            <label>Médico:</label>
            <asp:DropDownList ID="ddlMedico" runat="server" required="true"></asp:DropDownList>
            <label>ID Consultorio:</label>
            <asp:TextBox ID="txtIdConsultorio" runat="server" required="true"/>
            <label>ID Historial:</label>
            <asp:TextBox ID="txtIdHistorial" runat="server" /> 
            <div style="margin-top:1.5em;">
                <asp:Button ID="btnRegistrar" runat="server" Text="Registrar" CssClass="btn-form" OnClick="btnRegistrar_Click"/>
                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn-volver" OnClick="btnCancelar_Click" />
            </div>
        </div>
    </form>
</body>
</html>
