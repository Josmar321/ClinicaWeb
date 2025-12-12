<%@ Page Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="reportes.aspx.cs" Inherits="ClinicaWeb.admin.reportes" %>


<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Agregar Usuario - NeoSalud
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

            <div class="dashboard-contenido">
                <div class="encabezado-seccion">
                    <h1>Reportes y Estadísticas</h1>
                    <div class="acciones-reportes">
                        <button class="btn btn-secundario">
                            <i class="fas fa-download"></i> Exportar
                        </button>
                        <button class="btn btn-principal">
                            <i class="fas fa-print"></i> Imprimir
                        </button>
                    </div>
                </div>

                <!-- Filtros de Reportes -->
                <!-- Filtros -->
                <div class="filtros-gestion">
                    <div class="busqueda-avanzada">
                        <div class="grid-filtros">
                            <div class="form-grupo">
                                <label>Período:</label>
                                <select class="filtro-select">
                                    <option value="hoy">Hoy</option>
                                    <option value="semana">Esta Semana</option>
                                    <option value="mes" selected>Este Mes</option>
                                    <option value="trimestre">Último Trimestre</option>
                                    <option value="año">Este Año</option>
                                </select>
                            </div>
                            <div class="form-grupo">
                                <label>Local:</label>
                                <select class="filtro-select">
                                    <option value="todos">Todos los Locales</option>
                                    <option value="central">Local Central</option>
                                    <option value="norte">Local Norte</option>
                                    <option value="sur">Local Sur</option>
                                </select>
                            </div>
                            <div class="form-grupo">
                                <label>Tipo de Reporte:</label>
                                <select class="filtro-select">
                                    <option value="general">General</option>
                                    <option value="citas">Citas</option>
                                    <option value="ingresos">Ingresos</option>
                                    <option value="pacientes">Pacientes</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Resumen de Métricas -->
                <div class="grid-metricas">
                    <div class="tarjeta-metrica">
                        <div class="icono-metrica">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <div class="info-metrica">
                            <h3>Total de Citas</h3>
                            <p class="valor">1,234</p>
                            <p class="tendencia positiva">
                                <i class="fas fa-arrow-up"></i> 12.5%
                            </p>
                        </div>
                    </div>
                    <div class="tarjeta-metrica">
                        <div class="icono-metrica">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="info-metrica">
                            <h3>Pacientes Atendidos</h3>
                            <p class="valor">856</p>
                            <p class="tendencia positiva">
                                <i class="fas fa-arrow-up"></i> 8.3%
                            </p>
                        </div>
                    </div>
                    <div class="tarjeta-metrica">
                        <div class="icono-metrica">
                            <i class="fas fa-dollar-sign"></i>
                        </div>
                        <div class="info-metrica">
                            <h3>Ingresos Totales</h3>
                            <p class="valor">S/. 45,678</p>
                            <p class="tendencia positiva">
                                <i class="fas fa-arrow-up"></i> 15.2%
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Gráficos -->
                <div class="grid-reportes">
                    <!-- Gráfico de Citas -->
                    <div class="tarjeta-reporte">
                        <div class="reporte-header">
                            <h3>Citas por Especialidad</h3>
                            <div class="filtros-reporte">
                                <button class="btn-filtro activo">Diario</button>
                                <button class="btn-filtro">Semanal</button>
                                <button class="btn-filtro">Mensual</button>
                            </div>
                        </div>
                        <div class="grafico-container">
                            <canvas id="graficoCitas"></canvas>
                        </div>
                    </div>

                    <!-- Gráfico de Ingresos -->
                    <div class="tarjeta-reporte">
                        <div class="reporte-header">
                            <h3>Ingresos por Local</h3>
                            <div class="filtros-reporte">
                                <button class="btn-filtro activo">Mensual</button>
                                <button class="btn-filtro">Trimestral</button>
                                <button class="btn-filtro">Anual</button>
                            </div>
                        </div>
                        <div class="grafico-container">
                            <canvas id="graficoIngresos"></canvas>
                        </div>
                    </div>

                    <!-- Gráfico de Pacientes -->
                    <div class="tarjeta-reporte">
                        <div class="reporte-header">
                            <h3>Distribución de Pacientes</h3>
                            <div class="filtros-reporte">
                                <button class="btn-filtro activo">Edad</button>
                                <button class="btn-filtro">Género</button>
                                <button class="btn-filtro">Local</button>
                            </div>
                        </div>
                        <div class="grafico-container">
                            <canvas id="graficoPacientes"></canvas>
                        </div>
                    </div>
                </div>

                <!-- Tabla de Resumen -->
                <div class="tabla-contenedor">
                    <table class="tabla">
                        <thead>
                            <tr>
                                <th>Especialidad</th>
                                <th>Citas Totales</th>
                                <th>Pacientes Únicos</th>
                                <th>Ingresos</th>
                                <th>Tendencia</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Medicina General</td>
                                <td>450</td>
                                <td>380</td>
                                <td>S/. 15,750</td>
                                <td class="tendencia positiva">↑ 8.5%</td>
                            </tr>
                            <tr>
                                <td>Cardiología</td>
                                <td>280</td>
                                <td>210</td>
                                <td>S/. 22,400</td>
                                <td class="tendencia positiva">↑ 12.3%</td>
                            </tr>
                            <tr>
                                <td>Pediatría</td>
                                <td>320</td>
                                <td>290</td>
                                <td>S/. 12,800</td>
                                <td class="tendencia positiva">↑ 5.7%</td>
                            </tr>
                            <tr>
                                <td>Dermatología</td>
                                <td>180</td>
                                <td>150</td>
                                <td>S/. 9,000</td>
                                <td class="tendencia negativa">↓ 2.1%</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
</asp:Content>