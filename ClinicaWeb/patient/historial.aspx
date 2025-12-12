<%@ Page Language="C#" MasterPageFile="~/patient/PacienteMaster.master" AutoEventWireup="true" CodeBehind="historial.aspx.cs" Inherits="ClinicaWeb.patient.historial" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
            <div class="dashboard-contenido">
                <div class="encabezado-dashboard">
                    <h1>Historial Médico</h1>
                    <a href="VerReportePaciente.aspx" target="_blank" class="btn btn-primary d-inline-flex align-items-center">
                        <i class="fas fa-download me-2"></i> Descargar Historial
                    </a>
                </div>

                <!-- Información General -->
                <section class="seccion info-general">
                    <h2>Información General</h2>
                    <div class="grid-info">
                        <div class="info-item">
                            <h3>Datos Personales</h3>
                            <ul>
                                <li><strong>Nombre:</strong> Juan Pérez</li>
                                <li><strong>Edad:</strong> 35 años</li>
                                <li><strong>Grupo Sanguíneo:</strong> O+</li>
                                <li><strong>Alergias:</strong> Penicilina</li>
                            </ul>
                        </div>
                        <div class="info-item">
                            <h3>Condiciones Crónicas</h3>
                            <ul>
                                <li>Hipertensión Arterial</li>
                                <li>Diabetes Tipo 2</li>
                            </ul>
                        </div>
                        <div class="info-item">
                            <h3>Medicamentos Actuales</h3>
                            <ul>
                                <li>Metformina 500mg</li>
                                <li>Losartán 50mg</li>
                            </ul>
                        </div>
                    </div>
                </section>

                <!-- Historial de Consultas -->
                <section class="seccion historial-consultas">
                    <h2>Historial de Consultas</h2>
                    <div class="filtros-historial">
                        <div class="busqueda-historial">
                            <i class="fas fa-search"></i>
                            <input type="text" placeholder="Buscar por médico o especialidad...">
                        </div>
                        <div class="filtros-fecha">
                            <button class="btn-filtro activo">Todo</button>
                            <button class="btn-filtro">Último Mes</button>
                            <button class="btn-filtro">Último Año</button>
                        </div>
                    </div>

                    <div class="lista-consultas">
                        <!-- Consulta Reciente -->
                        <div class="consulta-item">
                            <div class="fecha-consulta">
                                <span class="fecha">15 de Marzo, 2024</span>
                                <span class="hora">09:00 AM</span>
                            </div>
                            <div class="info-consulta">
                                <div class="medico-consulta">
                                    <img src="https://via.placeholder.com/50" alt="Médico">
                                    <div>
                                        <h4>Dr. Carlos Ruiz</h4>
                                        <p>Traumatología</p>
                                    </div>
                                </div>
                                <div class="detalles-consulta">
                                    <h5>Diagnóstico</h5>
                                    <p>Esguince grado II en tobillo derecho</p>
                                    <h5>Tratamiento</h5>
                                    <ul>
                                        <li>Reposo relativo</li>
                                        <li>Inmovilización con tobillera</li>
                                        <li>Ibuprofeno 400mg cada 8 horas</li>
                                    </ul>
                                    <h5>Observaciones</h5>
                                    <p>Paciente refiere mejoría en la movilidad. Se recomienda continuar con ejercicios de rehabilitación.</p>
                                </div>
                            </div>
                        </div>

                        <!-- Consulta Anterior -->
                        <div class="consulta-item">
                            <div class="fecha-consulta">
                                <span class="fecha">10 de Marzo, 2024</span>
                                <span class="hora">11:30 AM</span>
                            </div>
                            <div class="info-consulta">
                                <div class="medico-consulta">
                                    <img src="https://via.placeholder.com/50" alt="Médico">
                                    <div>
                                        <h4>Dra. María López</h4>
                                        <p>Dermatología</p>
                                    </div>
                                </div>
                                <div class="detalles-consulta">
                                    <h5>Diagnóstico</h5>
                                    <p>Dermatitis atópica</p>
                                    <h5>Tratamiento</h5>
                                    <ul>
                                        <li>Crema hidratante 2 veces al día</li>
                                        <li>Corticosteroide tópico</li>
                                    </ul>
                                    <h5>Observaciones</h5>
                                    <p>Se recomienda evitar contacto con alérgenos y mantener la piel hidratada.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
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