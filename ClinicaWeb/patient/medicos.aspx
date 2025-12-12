<%@ Page Language="C#" MasterPageFile="~/patient/PacienteMaster.master" AutoEventWireup="true" CodeBehind="medicos.aspx.cs" Inherits="ClinicaWeb.patient.medicos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

            <div class="dashboard-contenido">
                <div class="encabezado-dashboard">
                    <h1>Mis Médicos</h1>
                    <div class="acciones-medicos">
                        <button class="btn-buscar-medico">
                            <i class="fas fa-search"></i>
                            Buscar Médico
                        </button>
                        <button class="btn-nueva-cita" onclick="window.location.href='agendarCita.html'">
                            <i class="fas fa-plus"></i>
                            Nueva Cita
                        </button>
                    </div>
                </div>

                <!-- Filtros -->
                <div class="filtros-medicos">
                    <div class="busqueda-medicos">
                        <i class="fas fa-search"></i>
                        <input type="text" placeholder="Buscar por nombre o especialidad...">
                    </div>
                    <div class="filtros-especialidad">
                        <button class="btn-filtro activo">Todas</button>
                        <button class="btn-filtro">Cardiología</button>
                        <button class="btn-filtro">Traumatología</button>
                        <button class="btn-filtro">Dermatología</button>
                    </div>
                </div>

                <!-- Lista de Médicos -->
                <div class="grid-medicos">
                    <!-- Médico 1 -->
                    <div class="tarjeta-medico">
                        <div class="medico-header">
                            <img src="https://via.placeholder.com/100" alt="Médico">
                            <div class="info-medico-principal">
                                <h3>Dra. Ana García</h3>
                                <p class="especialidad">Cardiología</p>
                            </div>
                        </div>
                        <div class="medico-info-detallada">
                            <div class="info-item">
                                <i class="fas fa-hospital"></i>
                                <span>Clínica Central - Consultorio 302</span>
                            </div>
                            <div class="info-item">
                                <i class="fas fa-clock"></i>
                                <span>Lunes a Viernes: 9:00 AM - 5:00 PM</span>
                            </div>
                            <div class="info-item">
                                <i class="fas fa-phone"></i>
                                <span>+51 999 888 777</span>
                            </div>
                        </div>
                    </div>

                    <!-- Médico 2 -->
                    <div class="tarjeta-medico">
                        <div class="medico-header">
                            <img src="https://via.placeholder.com/100" alt="Médico">
                            <div class="info-medico-principal">
                                <h3>Dr. Carlos Ruiz</h3>
                                <p class="especialidad">Traumatología</p>
                            </div>
                        </div>
                        <div class="medico-info-detallada">
                            <div class="info-item">
                                <i class="fas fa-hospital"></i>
                                <span>Clínica Norte - Consultorio 105</span>
                            </div>
                            <div class="info-item">
                                <i class="fas fa-clock"></i>
                                <span>Lunes a Jueves: 8:00 AM - 4:00 PM</span>
                            </div>
                            <div class="info-item">
                                <i class="fas fa-phone"></i>
                                <span>+51 999 777 666</span>
                            </div>
                        </div>

                    </div>

                    <!-- Médico 3 -->
                    <div class="tarjeta-medico">
                        <div class="medico-header">
                            <img src="https://via.placeholder.com/100" alt="Médico">
                            <div class="info-medico-principal">
                                <h3>Dra. María López</h3>
                                <p class="especialidad">Dermatología</p>
                            </div>
                        </div>
                        <div class="medico-info-detallada">
                            <div class="info-item">
                                <i class="fas fa-hospital"></i>
                                <span>Clínica Sur - Consultorio 208</span>
                            </div>
                            <div class="info-item">
                                <i class="fas fa-clock"></i>
                                <span>Martes a Sábado: 10:00 AM - 6:00 PM</span>
                            </div>
                            <div class="info-item">
                                <i class="fas fa-phone"></i>
                                <span>+51 999 555 444</span>
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