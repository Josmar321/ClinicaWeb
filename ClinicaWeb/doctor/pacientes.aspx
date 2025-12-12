<%@ Page Language="C#" MasterPageFile="~/doctor/DoctorMaster.master" AutoEventWireup="true" CodeBehind="pacientes.aspx.cs" Inherits="ClinicaWeb.doctor.pacientes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <!-- Contenido Principal -->
        <main class="contenido-principal">
            <div class="dashboard-contenido">
                <div class="encabezado-dashboard">
                    <h1>Mis Pacientes</h1>
                    <div class="acciones-pacientes">
                        <button class="btn-exportar">
                    <a href="ReporteAtencionXMedicos.aspx" target="_blank" class="btn-exportar">                            <i class="fas fa-download"></i> Descargar Historial                        </a>
                        </button>
                    </div>
                </div>

                <!-- Filtros -->
                <div class="filtros-pacientes">
                    <div class="busqueda-pacientes">
                        <i class="fas fa-search"></i>
                        <input type="text" placeholder="Buscar por nombre, DNI o diagnóstico...">
                    </div>
                    <div class="filtros-categoria">
                        <button class="btn-filtro activo">Todos</button>
                        <button class="btn-filtro">Recientes</button>
                        <button class="btn-filtro">Frecuentes</button>
                        <button class="btn-filtro">Con Cita Pendiente</button>
                    </div>
                </div>

                <!-- Lista de Pacientes -->
                <div class="grid-pacientes">
                    <!-- Paciente 1 -->
                    <div class="tarjeta-paciente">
                        <div class="paciente-header">
                            <img src="https://via.placeholder.com/80" alt="Paciente">
                            <div class="info-paciente-principal">
                                <h3>Juan Pérez</h3>
                                <p class="edad">35 años</p>
                                <p class="ultima-visita">Última visita: 15/03/2024</p>
                            </div>
                        </div>
                        <div class="paciente-info-detallada">
                            <div class="info-item">
                                <i class="fas fa-id-card"></i>
                                <span>DNI: 12345678</span>
                            </div>
                            <div class="info-item">
                                <i class="fas fa-phone"></i>
                                <span>+51 999 888 777</span>
                            </div>
                            <div class="info-item">
                                <i class="fas fa-envelope"></i>
                                <span>juan.perez@email.com</span>
                            </div>
                            <div class="diagnosticos">
                                <h4>Diagnósticos Recientes</h4>
                                <ul>
                                    <li>Hipertensión Arterial</li>
                                    <li>Diabetes Tipo 2</li>
                                </ul>
                            </div>
                        </div>
                        <div class="paciente-acciones">
                            <button class="btn-ver-historial">Ver Historial</button>
                            <button class="btn-agendar">Agendar Cita</button>
                            <button class="btn-contactar">Contactar</button>
                        </div>
                    </div>

                    <!-- Paciente 2 -->
                    <div class="tarjeta-paciente">
                        <div class="paciente-header">
                            <img src="https://via.placeholder.com/80" alt="Paciente">
                            <div class="info-paciente-principal">
                                <h3>María López</h3>
                                <p class="edad">28 años</p>
                                <p class="ultima-visita">Última visita: 18/03/2024</p>
                            </div>
                        </div>
                        <div class="paciente-info-detallada">
                            <div class="info-item">
                                <i class="fas fa-id-card"></i>
                                <span>DNI: 87654321</span>
                            </div>
                            <div class="info-item">
                                <i class="fas fa-phone"></i>
                                <span>+51 999 777 666</span>
                            </div>
                            <div class="info-item">
                                <i class="fas fa-envelope"></i>
                                <span>maria.lopez@email.com</span>
                            </div>
                            <div class="diagnosticos">
                                <h4>Diagnósticos Recientes</h4>
                                <ul>
                                    <li>Control Post-operatorio</li>
                                    <li>Recuperación Cirugía</li>
                                </ul>
                            </div>
                        </div>
                        <div class="paciente-acciones">
                            <button class="btn-ver-historial">Ver Historial</button>
                            <button class="btn-agendar">Agendar Cita</button>
                            <button class="btn-contactar">Contactar</button>
                        </div>
                    </div>

                    <!-- Paciente 3 -->
                    <div class="tarjeta-paciente">
                        <div class="paciente-header">
                            <img src="https://via.placeholder.com/80" alt="Paciente">
                            <div class="info-paciente-principal">
                                <h3>Carlos Ruiz</h3>
                                <p class="edad">45 años</p>
                                <p class="ultima-visita">Próxima cita: 20/03/2024</p>
                            </div>
                        </div>
                        <div class="paciente-info-detallada">
                            <div class="info-item">
                                <i class="fas fa-id-card"></i>
                                <span>DNI: 45678912</span>
                            </div>
                            <div class="info-item">
                                <i class="fas fa-phone"></i>
                                <span>+51 999 555 444</span>
                            </div>
                            <div class="info-item">
                                <i class="fas fa-envelope"></i>
                                <span>carlos.ruiz@email.com</span>
                            </div>
                            <div class="diagnosticos">
                                <h4>Diagnósticos Recientes</h4>
                                <ul>
                                    <li>Revisión de Resultados</li>
                                    <li>Control Anual</li>
                                </ul>
                            </div>
                        </div>
                        <div class="paciente-acciones">
                            <button class="btn-ver-historial">Ver Historial</button>
                            <button class="btn-agendar">Agendar Cita</button>
                            <button class="btn-contactar">Contactar</button>
                        </div>
                    </div>
                </div>
            </div>
        </main>

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