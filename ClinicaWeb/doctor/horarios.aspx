<%@ Page Language="C#" MasterPageFile="~/doctor/DoctorMaster.master" AutoEventWireup="true" CodeBehind="horarios.aspx.cs" Inherits="ClinicaWeb.doctor.horarios" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="dashboard-contenido">
        <div class="encabezado-dashboard">
            <h1>Mi Horario</h1>
            <div class="acciones-horarios">
                <asp:Button ID="btnPublicar" runat="server" CssClass="btn-publicar" Text="Publicar Disponibilidad" OnClick="btnPublicar_Click" />
            </div>
        </div>
        <!-- Configuración de Horarios -->
        <div class="configuracion-horarios">
            <!-- Horario Regular -->
            <section class="seccion-horario">
                <div class="grid-horario">
                    <!-- Lunes -->
                    <div class="dia-horario" id="cardLunes" runat="server">
                        <h3>Lunes</h3>
                        <div class="horario-dia">
                            <div class="turno">
                                <div class="turno-header">
                                    <asp:Label ID="lblEstadoLunes" runat="server" CssClass="estado-turno activo" Text="Activo"></asp:Label>
                                    <asp:LinkButton ID="btnToggleLunes" runat="server" CssClass="btn-toggle" OnClick="btnToggleLunes_Click">
                                        <i class="fas fa-toggle-on"></i>
                                    </asp:LinkButton>
                                </div>
                                <div class="horas-turno" id="horasTurnoLunes" runat="server">
                                    <div class="hora-item">
                                        <label>Inicio</label>
                                        <asp:TextBox ID="txtInicioLunes" runat="server" TextMode="Time" CssClass="input-hora" Text="09:00" />
                                    </div>
                                    <div class="hora-item">
                                        <label>Fin</label>
                                        <asp:TextBox ID="txtFinLunes" runat="server" TextMode="Time" CssClass="input-hora" Text="17:00" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Martes -->
                    <div class="dia-horario" id="cardMartes" runat="server">
                        <h3>Martes</h3>
                        <div class="horario-dia">
                            <div class="turno">
                                <div class="turno-header">
                                    <asp:Label ID="lblEstadoMartes" runat="server" CssClass="estado-turno activo" Text="Activo"></asp:Label>
                                    <asp:LinkButton ID="btnToggleMartes" runat="server" CssClass="btn-toggle" OnClick="btnToggleMartes_Click">
                                        <i class="fas fa-toggle-on"></i>
                                    </asp:LinkButton>
                                </div>
                                <div class="horas-turno" id="horasTurnoMartes" runat="server">
                                    <div class="hora-item">
                                        <label>Inicio</label>
                                        <asp:TextBox ID="txtInicioMartes" runat="server" TextMode="Time" CssClass="input-hora" Text="09:00" />
                                    </div>
                                    <div class="hora-item">
                                        <label>Fin</label>
                                        <asp:TextBox ID="txtFinMartes" runat="server" TextMode="Time" CssClass="input-hora" Text="17:00" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Miércoles -->
                    <div class="dia-horario" id="cardMiercoles" runat="server">
                        <h3>Miércoles</h3>
                        <div class="horario-dia">
                            <div class="turno">
                                <div class="turno-header">
                                    <asp:Label ID="lblEstadoMiercoles" runat="server" CssClass="estado-turno activo" Text="Activo"></asp:Label>
                                    <asp:LinkButton ID="btnToggleMiercoles" runat="server" CssClass="btn-toggle" OnClick="btnToggleMiercoles_Click">
                                        <i class="fas fa-toggle-on"></i>
                                    </asp:LinkButton>
                                </div>
                                <div class="horas-turno" id="horasTurnoMiercoles" runat="server">
                                    <div class="hora-item">
                                        <label>Inicio</label>
                                        <asp:TextBox ID="txtInicioMiercoles" runat="server" TextMode="Time" CssClass="input-hora" Text="09:00" />
                                    </div>
                                    <div class="hora-item">
                                        <label>Fin</label>
                                        <asp:TextBox ID="txtFinMiercoles" runat="server" TextMode="Time" CssClass="input-hora" Text="17:00" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Jueves -->
                    <div class="dia-horario" id="cardJueves" runat="server">
                        <h3>Jueves</h3>
                        <div class="horario-dia">
                            <div class="turno">
                                <div class="turno-header">
                                    <asp:Label ID="lblEstadoJueves" runat="server" CssClass="estado-turno activo" Text="Activo"></asp:Label>
                                    <asp:LinkButton ID="btnToggleJueves" runat="server" CssClass="btn-toggle" OnClick="btnToggleJueves_Click">
                                        <i class="fas fa-toggle-on"></i>
                                    </asp:LinkButton>
                                </div>
                                <div class="horas-turno" id="horasTurnoJueves" runat="server">
                                    <div class="hora-item">
                                        <label>Inicio</label>
                                        <asp:TextBox ID="txtInicioJueves" runat="server" TextMode="Time" CssClass="input-hora" Text="09:00" />
                                    </div>
                                    <div class="hora-item">
                                        <label>Fin</label>
                                        <asp:TextBox ID="txtFinJueves" runat="server" TextMode="Time" CssClass="input-hora" Text="17:00" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Viernes -->
                    <div class="dia-horario" id="cardViernes" runat="server">
                        <h3>Viernes</h3>
                        <div class="horario-dia">
                            <div class="turno">
                                <div class="turno-header">
                                    <asp:Label ID="lblEstadoViernes" runat="server" CssClass="estado-turno activo" Text="Activo"></asp:Label>
                                    <asp:LinkButton ID="btnToggleViernes" runat="server" CssClass="btn-toggle" OnClick="btnToggleViernes_Click">
                                        <i class="fas fa-toggle-on"></i>
                                    </asp:LinkButton>
                                </div>
                                <div class="horas-turno" id="horasTurnoViernes" runat="server">
                                    <div class="hora-item">
                                        <label>Inicio</label>
                                        <asp:TextBox ID="txtInicioViernes" runat="server" TextMode="Time" CssClass="input-hora" Text="09:00" />
                                    </div>
                                    <div class="hora-item">
                                        <label>Fin</label>
                                        <asp:TextBox ID="txtFinViernes" runat="server" TextMode="Time" CssClass="input-hora" Text="17:00" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>
</asp:Content>