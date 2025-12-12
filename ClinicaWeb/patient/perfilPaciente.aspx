<%@ Page Language="C#" MasterPageFile="~/patient/PacienteMaster.master" AutoEventWireup="true" CodeBehind="perfilPaciente.aspx.cs" Inherits="ClinicaWeb.patient.perfilPaciente" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
            <div class="dashboard-contenido">
                <div class="encabezado-dashboard">
                    <h1>Perfil del Paciente</h1>
                </div>

                <div class="contenido-perfil">
                    <div class="perfil-grid">
                        <!-- Sección de Foto de Perfil -->
                        <div class="foto-perfil-container">
                            <div class="foto-perfil">
                                <img src="/img/R.jpeg" alt="Foto de Perfil" id="foto-perfil-preview">
                                <div class="overlay-foto">
                                    <label for="cambiar-foto" class="btn-cambiar-foto">
                                        <i class="fas fa-camera"></i>
                                        Cambiar Foto
                                    </label>
                                    <input type="file" id="cambiar-foto" accept="image/*" style="display: none;" onchange="previewImage(this)">
                                </div>
                            </div>
                        </div>

                        <!-- Formulario para editar perfil -->
                        <form class="form-perfil">
                            <div class="campo-form">
                                <label for="nombre">Nombre Completo</label>
                                <input type="text" id="nombre" name="nombre" value="Juan Pérez" required>
                            </div>

                            <div class="campo-form">
                                <label for="email">Correo Electrónico</label>
                                <input type="email" id="email" name="email" value="juanperez@email.com" required>
                            </div>

                            <div class="campo-form">
                                <label for="telefono">Teléfono</label>
                                <input type="tel" id="telefono" name="telefono" value="+34 123 456 789" required>
                            </div>

                            <div class="campo-form">
                                <label for="direccion">Dirección</label>
                                <input type="text" id="direccion" name="direccion" value="Calle Falsa 123, Ciudad, País" required>
                            </div>

                            <div class="campo-form">
                                <label for="fecha-nacimiento">Fecha de Nacimiento</label>
                                <input type="date" id="fecha-nacimiento" name="fecha-nacimiento" value="1990-05-01" required>
                            </div>

                            <button type="submit" class="btn-guardar">Guardar Cambios</button>
                        </form>
                    </div>
                </div>
            </div>

    <script>
        function previewImage(input) {
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    document.getElementById('foto-perfil-preview').src = e.target.result;
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
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
</asp:Content>