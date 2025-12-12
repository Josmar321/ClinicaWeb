<%@ Page Language="C#" MasterPageFile="~/doctor/DoctorMaster.master" AutoEventWireup="true" CodeBehind="reportes.aspx.cs" Inherits="ClinicaWeb.doctor.reportes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
            <div class="dashboard-contenido">
                <div class="encabezado-dashboard">
                    <h1>Reportes y Estadísticas</h1>
                    <div class="acciones-reportes">
                        <div class="filtro-periodo">
                            <select>
                                <option>Última Semana</option>
                                <option selected>Último Mes</option>
                                <option>Último Trimestre</option>
                                <option>Último Año</option>
                                <option>Personalizado</option>
                            </select>
                        </div>
                        <button class="btn-exportar">
                            <i class="fas fa-download"></i>
                            Exportar Reporte
                        </button>
                    </div>
                </div>

                <!-- Resumen de Métricas -->
                <div class="grid-metricas">
                    <div class="tarjeta-metrica">
                        <div class="icono-metrica">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <div class="info-metrica">
                            <h3>Total Citas</h3>
                            <p class="valor">156</p>
                            <p class="tendencia positiva">
                                <i class="fas fa-arrow-up"></i>
                                12% vs mes anterior
                            </p>
                        </div>
                    </div>

                    <div class="tarjeta-metrica">
                        <div class="icono-metrica">
                            <i class="fas fa-user-check"></i>
                        </div>
                        <div class="info-metrica">
                            <h3>Pacientes Atendidos</h3>
                            <p class="valor">142</p>
                            <p class="tendencia positiva">
                                <i class="fas fa-arrow-up"></i>
                                8% vs mes anterior
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Gráficos y Análisis -->
                <div class="grid-reportes">
                    <!-- Gráfico de Citas -->
                    <div class="tarjeta-reporte">
                        <div class="reporte-header">
                            <h3>Citas por Día</h3>
                            <div class="filtros-reporte">
                                <button class="btn-filtro activo">Diario</button>
                                <button class="btn-filtro">Semanal</button>
                                <button class="btn-filtro">Mensual</button>
                            </div>
                        </div>
                        <div class="grafico-container">
                            <!-- Aquí iría el gráfico -->
                            <div class="placeholder-grafico">
                                <i class="fas fa-chart-line"></i>
                                <p>Gráfico de Citas</p>
                            </div>
                        </div>
                    </div>

                    <!-- Gráfico de Pacientes -->
                    <div class="tarjeta-reporte">
                        <div class="reporte-header">
                            <h3>Distribución de Pacientes</h3>
                            <div class="filtros-reporte">
                                <button class="btn-filtro activo">Por Edad</button>
                                <button class="btn-filtro">Por Género</button>
                                <button class="btn-filtro">Por Diagnóstico</button>
                            </div>
                        </div>
                        <div class="grafico-container">
                            <!-- Aquí iría el gráfico -->
                            <div class="placeholder-grafico">
                                <i class="fas fa-chart-pie"></i>
                                <p>Gráfico de Distribución</p>
                            </div>
                        </div>
                    </div>

                    <!-- Tabla de Diagnósticos -->
                    <div class="tarjeta-reporte">
                        <div class="reporte-header">
                            <h3>Diagnósticos Frecuentes</h3>
                            <button class="btn-ver-todos">Ver Todos</button>
                        </div>
                        <div class="tabla-diagnosticos">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Diagnóstico</th>
                                        <th>Pacientes</th>
                                        <th>% del Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Hipertensión Arterial</td>
                                        <td>45</td>
                                        <td>32%</td>
                                    </tr>
                                    <tr>
                                        <td>Diabetes Tipo 2</td>
                                        <td>28</td>
                                        <td>20%</td>
                                    </tr>
                                    <tr>
                                        <td>Artritis</td>
                                        <td>22</td>
                                        <td>15%</td>
                                    </tr>
                                    <tr>
                                        <td>Asma</td>
                                        <td>18</td>
                                        <td>13%</td>
                                    </tr>
                                    <tr>
                                        <td>Otros</td>
                                        <td>29</td>
                                        <td>20%</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

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