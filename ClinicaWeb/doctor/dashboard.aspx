<%@ Page Language="C#" MasterPageFile="~/doctor/DoctorMaster.master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="ClinicaWeb.doctor.dashboard" %>




<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="dashboard-contenido">
        <div class="encabezado-dashboard">
            <h1>Bienvenido, Dr. <%: Session["NombreDoctor"] ?? "Doctor" %></h1>
            <div class="acciones-pacientes">                        <a href="ReporteAtencionXMedicos.aspx" target="_blank" class="btn-exportar">                            <i class="fas fa-download"></i> Descargar Historial                        </a>            </div>
        </div>

        <!-- Resumen del Día -->
        <div class="grid-metricas">
            <div class="tarjeta-metrica">
                <div class="icono-metrica">
                    <i class="fas fa-calendar-check"></i>
                </div>
                <div class="info-metrica">
                    <h3>Citas Hoy</h3>
                    <div class="valor"><asp:Label ID="lblCitasHoy" runat="server" Text="0"></asp:Label></div>
                </div>
            </div>
            <div class="tarjeta-metrica">
                <div class="icono-metrica">
                    <i class="fas fa-user-clock"></i>
                </div>
                <div class="info-metrica">
                    <h3>En Espera</h3>
                    <div class="valor"><asp:Label ID="lblEnEspera" runat="server" Text="0"></asp:Label></div>
                </div>
            </div>
            <div class="tarjeta-metrica">
                <div class="icono-metrica">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="info-metrica">
                    <h3>Atendidos</h3>
                    <div class="valor"><asp:Label ID="lblAtendidos" runat="server" Text="0"></asp:Label></div>
                </div>
            </div>
            <div class="tarjeta-metrica">
                <div class="icono-metrica">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="info-metrica">
                    <h3>Próxima Cita</h3>
                    <div class="valor"><asp:Label ID="lblUltimaCita" runat="server" Text="0"></asp:Label></div>
                </div>
            </div>
        </div>

        <!-- Agenda y Pacientes -->
        <div class="secciones-gestion">
            <!-- Agenda del Día -->
            <div >
                <div class="seccion-header">
                    <h2>Últimas Citas</h2>
                </div>
                <div class="seccion-contenido">
                    <asp:Repeater ID="rptUltimasCitas" runat="server">
                        <ItemTemplate>
                            <div class="cita-item">
                                <div class="fecha-cita">
                                    <span class="dia"><%# Eval("fecha", "{0:dd}") %></span>
                                    <span class="mes"><%# Eval("fecha", "{0:MMM}") %></span>
                                    <span class="hora"><%# Eval("hora", "{0:HH:mm}") %></span>
                                </div>
                                <div class="info-cita">
                                    <div class="paciente-info">
                                        <h4>Paciente: <%# Eval("paciente") %></h4>
                                    </div>
                                    <div class="estado-cita">
                                        <span ><%# Eval("estadoTexto") %></span>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </div>

    <style>
    .dashboard-contenido {
        padding: 2rem;
    }
    .encabezado-dashboard {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 2rem;
    }
    .barra-busqueda {
        margin-bottom: 2rem;
    }
    .buscador {
        position: relative;
        max-width: 400px;
    }
    .buscador i {
        position: absolute;
        left: 12px;
        top: 50%;
        transform: translateY(-50%);
        color: #666;
    }
    .btn-buscar {
        position: absolute;
        right: 8px;
        top: 50%;
        transform: translateY(-50%);
        background: #4a90e2;
        color: white;
        border: none;
        padding: 8px 16px;
        border-radius: 4px;
        cursor: pointer;
        font-size: 0.9rem;
        transition: background-color 0.3s;
    }
    .btn-buscar:hover {
        background: #357abd;
    }
    .input-buscar {
        width: 100%;
        padding: 12px 100px 12px 40px;
        border: 1px solid #ddd;
        border-radius: 8px;
        font-size: 1rem;
        transition: border-color 0.3s;
    }
    .input-buscar:focus {
        outline: none;
        border-color: #4a90e2;
    }
    .grid-metricas {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
        gap: 1.5rem;
        margin-bottom: 2rem;
    }
    .secciones-gestion {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 2rem;
    }
    @media (max-width: 1024px) {
        .secciones-gestion {
            grid-template-columns: 1fr;
        }
    }
    </style>
    <script>
    function toggleDropdownPerfilDoctor(btn) {
        const container = btn.parentElement;
        container.classList.toggle('active');
    }
    document.addEventListener('click', function(event) {
        document.querySelectorAll('.dropdown-perfil-doctor.active').forEach(function(container) {
            if (!container.contains(event.target)) {
                container.classList.remove('active');
            }
        });
    });
    </script>
</asp:Content>