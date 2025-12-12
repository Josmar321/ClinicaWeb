<%@ Page Language="C#" MasterPageFile="~/doctor/DoctorMaster.master" AutoEventWireup="true" CodeBehind="notificaciones.aspx.cs" Inherits="ClinicaWeb.doctor.notificaciones" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
            <div class="dashboard-contenido">
                <div class="encabezado-dashboard">
                    <h1>Notificaciones</h1>
                    <div class="acciones-notificaciones">
                        <button class="btn-marcar-todas">
                            <i class="fas fa-check-double"></i>
                            Marcar Todas como Leídas
                        </button>
                        <button class="btn-limpiar">
                            <i class="fas fa-trash"></i>
                            Limpiar Notificaciones
                        </button>
                    </div>
                </div>

                <!-- Filtros de Notificaciones -->
                <div class="filtros-notificaciones">
                    <div class="buscador-notificaciones">
                        <input type="text" placeholder="Buscar en notificaciones...">
                        <i class="fas fa-search"></i>
                    </div>
                    <div class="categorias-notificaciones">
                        <button class="btn-categoria activo">Todas</button>
                        <button class="btn-categoria">Citas</button>
                        <button class="btn-categoria">Pacientes</button>
                        <button class="btn-categoria">Sistema</button>
                    </div>
                </div>

                <!-- Lista de Notificaciones -->
                <div class="lista-notificaciones">
                    <!-- Notificaciones No Leídas -->
                    <div class="notificacion no-leida">
                        <div class="icono-notificacion">
                            <i class="fas fa-calendar-plus"></i>
                        </div>
                        <div class="contenido-notificacion">
                            <div class="encabezado-notificacion">
                                <h3>Nueva Cita Programada</h3>
                                <span class="tiempo">Hace 5 minutos</span>
                            </div>
                            <p>María Rodríguez ha programado una cita para mañana a las 10:00 AM</p>
                            <div class="acciones-notificacion">
                                <button class="btn-accion">
                                    <i class="fas fa-eye"></i>
                                    Ver Detalles
                                </button>
                                <button class="btn-accion">
                                    <i class="fas fa-check"></i>
                                    Marcar como Leída
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="notificacion no-leida">
                        <div class="icono-notificacion">
                            <i class="fas fa-exclamation-circle"></i>
                        </div>
                        <div class="contenido-notificacion">
                            <div class="encabezado-notificacion">
                                <h3>Recordatorio de Cita</h3>
                                <span class="tiempo">Hace 15 minutos</span>
                            </div>
                            <p>Tienes una cita con Juan Pérez en 30 minutos</p>
                            <div class="acciones-notificacion">
                                <button class="btn-accion">
                                    <i class="fas fa-eye"></i>
                                    Ver Detalles
                                </button>
                                <button class="btn-accion">
                                    <i class="fas fa-check"></i>
                                    Marcar como Leída
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="notificacion leida">
                        <div class="icono-notificacion">
                            <i class="fas fa-calendar-times"></i>
                        </div>
                        <div class="contenido-notificacion">
                            <div class="encabezado-notificacion">
                                <h3>Cita Cancelada</h3>
                                <span class="tiempo">Hace 3 horas</span>
                            </div>
                            <p>Laura Sánchez ha cancelado su cita programada para mañana</p>
                            <div class="acciones-notificacion">
                                <button class="btn-accion">
                                    <i class="fas fa-eye"></i>
                                    Ver Detalles
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="notificacion leida">
                        <div class="icono-notificacion">
                            <i class="fas fa-cog"></i>
                        </div>
                        <div class="contenido-notificacion">
                            <div class="encabezado-notificacion">
                                <h3>Actualización del Sistema</h3>
                                <span class="tiempo">Hace 1 día</span>
                            </div>
                            <p>Se han implementado nuevas funcionalidades en el sistema</p>
                            <div class="acciones-notificacion">
                                <button class="btn-accion">
                                    <i class="fas fa-eye"></i>
                                    Ver Cambios
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Paginación -->
                <div class="paginacion">
                    <button class="btn-pagina">
                        <i class="fas fa-chevron-left"></i>
                    </button>
                    <button class="btn-pagina activo">1</button>
                    <button class="btn-pagina">2</button>
                    <button class="btn-pagina">3</button>
                    <button class="btn-pagina">
                        <i class="fas fa-chevron-right"></i>
                    </button>
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