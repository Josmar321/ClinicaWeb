<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HistorialClinicoPaciente.aspx.cs" Inherits="ClinicaWeb.admin.HistorialClinicoPaciente" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Historial Clínico del Paciente - NeoSalud</title>
    <link rel="stylesheet" href="../../styles.css" />
    <link rel="stylesheet" href="../../styles/admin.css" />
    <link rel="stylesheet" href="../../styles/medicos.css" />
    <link rel="stylesheet" href="../../styles/historial.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="contenedor-admin">
            <main class="contenido-principal">
                <div class="pagina-gestion">
                    <div class="tarjeta-historial">
                        <h2 class="titulo-historial">Historial Clínico del Paciente</h2>
                        <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje-error" />
                        <div id="divInfoPaciente" runat="server" class="info-paciente" visible="false">
                            <div><strong>Nombre:</strong> <asp:Label ID="lblNombrePaciente" runat="server" /></div>
                            <div><strong>Código:</strong> <asp:Label ID="lblCodigoPaciente" runat="server" /></div>
                            <div><strong>Email:</strong> <asp:Label ID="lblEmailPaciente" runat="server" /></div>
                        </div>
                        <div id="divObs" runat="server" class="obs-generales" visible="false">
                            <i class="fas fa-notes-medical"></i>
                            <strong>Observaciones Generales:</strong> <asp:Label ID="lblObsGenerales" runat="server" />
                        </div>
                        <h3 class="titulo-citas">Citas Médicas</h3>
                        <div class="busqueda-citas" style="margin-bottom: 1rem; display: flex; gap: 1.5em; align-items: flex-end;">
                            <div>
                                <label for="txtFechaInicio">Fecha Inicio:</label>
                                <asp:TextBox ID="txtFechaInicio" runat="server" TextMode="Date" CssClass="input-admin" />
                            </div>
                            <div>
                                <label for="txtFechaFin">Fecha Fin:</label>
                                <asp:TextBox ID="txtFechaFin" runat="server" TextMode="Date" CssClass="input-admin" />
                                <asp:Button ID="btnBuscarPorFecha" runat="server" Text="Filtrar" CssClass="btn-accion-principal" OnClick="btnBuscarPorFecha_Click" />
                            </div>
                            <div>
                                <asp:Button ID="btnAgregarCita" runat="server" Text="Agregar Cita Médica" CssClass="btn-accion-principal" OnClick="btnAgregarCita_Click" />
                            </div>
                        </div>
                        <asp:Label ID="lblMensajeCitas" runat="server" CssClass="mensaje-error" />
                        <asp:Repeater ID="rptCitas" runat="server" OnItemCommand="rptCitas_ItemCommand">
                            <ItemTemplate>
                                <div class="cita-card">
                                    <div class="fecha-cita">
                                        <%# ((DateTime)Eval("fecha")).ToString("yyyy-MM-dd") %>
                                        <i class="fas fa-clock"></i>
                                      <%# ((DateTime)Eval("hora")).ToString("HH:mm:ss") %>

                                        <span class="estado"><%# Eval("estado") %></span>
                                    </div>
                                    <div>
                                        <i class="fas fa-user-md"></i> <b>Código Médico:</b> <%# Eval("medico") != null ? Eval("medico.codigoMedico") : "" %>
                                        <b>Modalidad:</b> <%# Eval("modalidad") %>
                                        <b>Precio:</b> S/ <%# Eval("precio") %>
                                    </div>
                                    <div style="margin-top: 10px; display: flex; gap: 14px;">
                                        <asp:LinkButton runat="server" CommandName="Editar" CommandArgument='<%# Eval("idCita") %>' CssClass="btn-link-editar" ToolTip="Editar">
                                            <i class="fas fa-pen"></i> Editar
                                        </asp:LinkButton>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                        <asp:Button runat="server" ID="btnVolver" Text="Volver" CssClass="btn-volver" OnClick="btnVolver_Click" />
                    </div>
                </div>
            </main>
        </div>
    </form>
</body>
</html>
