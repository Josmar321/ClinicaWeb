<%@ Page Language="C#" MasterPageFile="~/patient/PacienteMaster.master" AutoEventWireup="true" CodeBehind="agendarCita.aspx.cs" Inherits="ClinicaWeb.patient.agendarCita" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

            <div class="dashboard-contenido">
                <div class="encabezado-dashboard">
                    <h1>Agendar Cita</h1>
                </div>

                <!-- Formulario para Agendar Cita -->
                <div class="form-agendar-cita">
                    <form class="form-cita">
                        <div class="filtros-horizontal">
                            <div class="campo-form">
                                <label for="local">Local</label>
                                <asp:DropDownList ID="ddlLocal" runat="server"
                                                  CssClass="dropdown-local"
                                                  AutoPostBack="true"
                                                  OnSelectedIndexChanged="ddlLocal_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>

                            <div class="campo-form">
                                <label for="especialidad">Especialidad</label>
                                <asp:DropDownList ID="ddlEspecialidad" runat="server" CssClass="dropdown-especialidad"></asp:DropDownList>
                            </div>

                            <div class="campo-form">
                                <label for="fecha">Fecha</label>
                                <input type="date" id="fecha" name="fecha" required runat="server" />
                            </div>

                            <div class="contenedor-btn-buscar">
                                <label style="visibility: hidden;">Buscar</label>
                                <asp:Button ID="btnBuscar" runat="server" CssClass="btn-buscar" Text="🔍 Buscar" OnClick="btnBuscar_Click" />
                            </div>
                        </div>

                        <!-- Título y grilla de médicos -->
                        <h2 class="titulo-medicos">Médicos</h2>

                        <div class="grid-medicos">
                            <asp:Repeater ID="rptMedicos" runat="server">
                                <ItemTemplate>
                                    <div class="medico-item">
                                        <div class="foto">
                                            <img src='<%# ObtenerSrcFoto(Eval("foto")) %>' alt="Foto Médico" />
                                        </div>
                                        <div class="info">
                                            <h4><%# Eval("nombre") %> <%# Eval("primerApellido") %> <%# Eval("segundoApellido") %></h4>
                                            <p><strong>Especialidad:</strong> <%# Eval("especialidad.nombre") %></p>
                                            <p><strong>CMP:</strong> <%# Eval("numeroColegiatura") %></p>
                                            <asp:LinkButton runat="server" CssClass="btn-agendar-cita" CommandArgument='<%# Eval("codigoMedico") %>' OnCommand="AgendarCita_Command">
                                                Agendar Cita
                                            </asp:LinkButton>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje-vacio" Text="No hay médicos disponibles para la búsqueda." Visible="false"></asp:Label>
                        </div>

                    </form>
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

.filtros-horizontal {
    display: flex;
    flex-wrap: nowrap;
    gap: 20px;
    align-items: flex-end;
    margin-bottom: 32px;
}

.filtros-horizontal .campo-form {
    flex: 1 1 200px;
    min-width: 200px;
}

/* Campo combinado hora + botón */
.campo-hora-buscar {
    display: flex;
    gap: 8px;
    align-items: flex-end;
}

.contenedor-btn-buscar {
    flex: 0 0 auto;
    min-width: auto;
    max-width: fit-content;
}

.btn-buscar {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 8px 16px;
    background-color: #007BFF;
    color: white;
    border: none;
    border-radius: 6px;
    font-size: 0.9rem;
    cursor: pointer;
    transition: background-color 0.2s ease;
    height: 38px;
}
.btn-buscar:hover {
    background-color: #0056b3;
}
.icono-lupa {
    width: 16px;
    height: 16px;
}

/* Título de médicos */
.titulo-medicos {
    margin-top: 40px;
    margin-bottom: 12px;
}

/* Grid fijo de 3 columnas */
.grid-medicos {
    display: grid;
    grid-template-columns: repeat(3, minmax(320px, 1fr));
    gap: 24px;
    margin-top: 10px;
}

/* Tarjeta de médico */
.medico-item {
    display: flex;
    flex-direction: column;
    align-items: center;
    background: #f8f8f8;
    border: 1px solid #ccc;
    border-radius: 12px;
    padding: 20px;
    text-align: center;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}
.medico-item .foto img {
    width: 90px;
    height: 90px;
    border-radius: 50%;
    object-fit: cover;
    margin-bottom: 12px;
}
.medico-item .info h4 {
    margin: 0;
    font-size: 1.2rem;
}
.medico-item .info p {
    margin: 4px 0;
    color: #333;
}
.btn-agendar-cita {
    margin-top: 12px;
    padding: 8px 14px;
    background-color: #28a745;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: background-color 0.2s ease;
}
.btn-agendar-cita:hover {
    background-color: #218838;
}

.grupo-hora-buscar {
    display: flex;
    flex-direction: column;
    min-width: 200px;
}

.contenedor-hora-buscar {
    display: flex;
    align-items: center;
    gap: 10px;
}

.contenedor-hora-buscar input[type="time"] {
    flex: 1;
}

.btn-buscar {
    padding: 6px 12px;
    font-size: 0.9rem;
}

.btn-local {
    padding: 8px 14px;
    background-color: #6c757d;
    color: white;
    border: none;
    border-radius: 6px;
    font-size: 0.9rem;
    cursor: pointer;
    height: 38px;
    transition: background-color 0.2s ease;
}
.btn-local:hover {
    background-color: #5a6268;
}

.contenedor-btn-local {
    display: flex;
    flex-direction: column;
    justify-content: flex-end;
    min-width: 160px;
}

.mensaje-vacio {
    display: block;
    text-align: center;
    margin-top: 30px;
    font-size: 1.1rem;
    color: #888;
}
</style>
<script>
    function toggleDropdownPerfil() {
        const dropdown = document.getElementById('dropdownPerfil');
        const container = dropdown.parentElement;
        container.classList.toggle('active');
    }
    document.addEventListener('click', function (event) {
        const dropdown = document.getElementById('dropdownPerfil');
        if (!dropdown) return;
        const container = dropdown.parentElement;
        if (!container.contains(event.target)) {
            container.classList.remove('active');
        }
    });
</script>

</asp:Content>