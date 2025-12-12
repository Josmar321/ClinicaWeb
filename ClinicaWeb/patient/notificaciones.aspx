<%@ Page Language="C#" MasterPageFile="~/patient/PacienteMaster.master" AutoEventWireup="true" CodeBehind="notificaciones.aspx.cs" Inherits="ClinicaWeb.patient.notificaciones" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
            <div class="dashboard-contenido">
                <div class="encabezado-dashboard">
                    <h1>Notificaciones</h1>
                    <div class="acciones-notificaciones">
                        <button class="btn-marcar-todas">
                            <i class="fas fa-check-double"></i>
                            Marcar todas como leídas
                        </button>
                        <button class="btn-limpiar">
                            <i class="fas fa-trash"></i>
                            Limpiar notificaciones
                        </button>
                    </div>
                </div>

                <!-- Lista de Notificaciones -->
                <div class="lista-notificaciones">
                    <!-- Notificación No Leída -->
                    <div class="notificacion-item no-leida">
                        <div class="icono-notificacion">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <div class="contenido-notificacion">
                            <div class="encabezado-notificacion">
                                <h3>Cita Confirmada</h3>
                                <span class="tiempo">Hace 2 horas</span>
                            </div>
                            <p>Tu cita con la Dra. Ana García ha sido confirmada para el 20 de Marzo a las 10:30 AM.</p>
                            <div class="acciones-notificacion">
                                <button class="btn-ver-detalle">Ver Detalles</button>
                                <button class="btn-marcar-leida">Marcar como leída</button>
                            </div>
                        </div>
                    </div>

                    <!-- Notificación No Leída -->
                    <div class="notificacion-item no-leida">
                        <div class="icono-notificacion">
                            <i class="fas fa-bell"></i>
                        </div>
                        <div class="contenido-notificacion">
                            <div class="encabezado-notificacion">
                                <h3>Recordatorio de Cita</h3>
                                <span class="tiempo">Hace 5 horas</span>
                            </div>
                            <p>No olvides tu cita mañana con el Dr. Carlos Ruiz a las 9:00 AM.</p>
                            <div class="acciones-notificacion">
                                <button class="btn-ver-detalle">Ver Detalles</button>
                                <button class="btn-marcar-leida">Marcar como leída</button>
                            </div>
                        </div>
                    </div>

                    <!-- Notificación Leída -->
                    <div class="notificacion-item">
                        <div class="icono-notificacion">
                            <i class="fas fa-file-medical"></i>
                        </div>
                        <div class="contenido-notificacion">
                            <div class="encabezado-notificacion">
                                <h3>Nuevo Resultado Disponible</h3>
                                <span class="tiempo">Ayer</span>
                            </div>
                            <p>Los resultados de tus análisis de laboratorio ya están disponibles.</p>
                            <div class="acciones-notificacion">
                                <button class="btn-ver-detalle">Ver Resultados</button>
                            </div>
                        </div>
                    </div>

                    <!-- Notificación Leída -->
                    <div class="notificacion-item">
                        <div class="icono-notificacion">
                            <i class="fas fa-user-md"></i>
                        </div>
                        <div class="contenido-notificacion">
                            <div class="encabezado-notificacion">
                                <h3>Médico Actualizado</h3>
                                <span class="tiempo">Hace 2 días</span>
                            </div>
                            <p>La Dra. María López ha actualizado su horario de atención.</p>
                            <div class="acciones-notificacion">
                                <button class="btn-ver-detalle">Ver Horarios</button>
                            </div>
                        </div>
                    </div>

                    <!-- Notificación Leída -->
                    <div class="notificacion-item">
                        <div class="icono-notificacion">
                            <i class="fas fa-info-circle"></i>
                        </div>
                        <div class="contenido-notificacion">
                            <div class="encabezado-notificacion">
                                <h3>Actualización del Sistema</h3>
                                <span class="tiempo">Hace 1 semana</span>
                            </div>
                            <p>Hemos actualizado nuestro sistema para mejorar tu experiencia. Descubre las nuevas funciones.</p>
                            <div class="acciones-notificacion">
                                <button class="btn-ver-detalle">Ver Cambios</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

<style>
.dropdown-perfil {
    position: relative;
    display: flex;
    align-items: center;
}
.btn-nombre-paciente {
    background: none;
    border: none;
    color: #333;
    font-size: 1rem;
    cursor: pointer;
    margin-left: 8px;
    display: flex;
    align-items: center;
}
.dropdown-content-perfil {
    display: none;
    position: absolute;
    top: 100%;
    right: 0;
    background: #fff;
    min-width: 160px;
    box-shadow: 0 8px 16px rgba(0,0,0,0.2);
    z-index: 1000;
    border-radius: 6px;
    overflow: hidden;
}
.dropdown-content-perfil a {
    color: #333;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
    transition: background 0.2s;
}
.dropdown-content-perfil a:hover {
    background: #f1f1f1;
}
.dropdown-perfil.active .dropdown-content-perfil {
    display: block;
}
</style>
<script>
function toggleDropdownPerfil() {
    const dropdown = document.getElementById('dropdownPerfil');
    const container = dropdown.parentElement;
    container.classList.toggle('active');
}
document.addEventListener('click', function(event) {
    const dropdown = document.getElementById('dropdownPerfil');
    if (!dropdown) return;
    const container = dropdown.parentElement;
    if (!container.contains(event.target)) {
        container.classList.remove('active');
    }
});
</script>
    </asp:Content>