<%@ Page Language="C#" MasterPageFile="~/doctor/DoctorMaster.master" AutoEventWireup="true" CodeBehind="agenda.aspx.cs" Inherits="ClinicaWeb.doctor.agenda" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="dashboard-contenido">
        <div class="encabezado-dashboard">
            <h1>Mi Agenda</h1>
            <div class="acciones-agenda">
                <button class="btn-exportar">
                    <i class="fas fa-download"></i>
                    Exportar Agenda
                </button>
            </div>
        </div>

        <!-- Filtros -->
        <div class="filtros-agenda">
            <div class="busqueda-agenda">
                <i class="fas fa-search"></i>
                <input type="text" id="txtBuscarPaciente" placeholder="Buscar por paciente...">
            </div>
            <div class="filtros-estado">
                <label for="ddlEstadoFiltro">Estado:</label>
                <select id="ddlEstadoFiltro" class="dropdown-filtro">
                    <option value="TODAS">Todas</option>
                    <option value="PROGRAMADA">PROGRAMADA</option>
                    <option value="REALIZADA">REALIZADA</option>
                </select>
            </div>

        </div>

        <!-- Vista de Agenda -->
        <div class="vista-agenda">
            <!-- Selector de Mes -->
            <div class="mes-selector" style="text-align:center;">
                <h2 style="margin: 0;">Filtrar por fecha</h2>
            </div>
            <!-- Mostrar título de fecha seleccionada -->
            <h3 runat="server" id="lblFechaTitulo" style="margin: 10px 0;"></h3>

            <!-- Calendario y Lista de Citas -->
            <div class="grid-agenda">
                <!-- Calendario -->
                <div class="calendario">
                    <asp:Calendar ID="Calendar1" runat="server" CssClass="mi-calendario"
                        OnSelectionChanged="Calendar1_SelectionChanged"
                        DayHeaderStyle-BackColor="#CCE5FF"
                        TitleStyle-BackColor="#CCE5FF"
                        TitleStyle-ForeColor="Black"
                        TitleStyle-Font-Bold="true"
                        SelectedDayStyle-BackColor="#0099FF"
                        SelectedDayStyle-ForeColor="White" />
                </div>


                <!-- Lista de Citas -->
                <div class="contenedor-citas">
                    <asp:Repeater ID="rptCitas" runat="server">
                        <ItemTemplate>
                            <div class="cita-item" data-estado='<%# Eval("estado") %>' data-paciente='<%# Eval("paciente") %>' style="display: flex; justify-content: space-between; align-items: center;">
                                <!-- Hora a la izquierda -->
                                <div class="hora-cita"><%# Eval("hora") %></div>

                                <!-- Info de la cita -->
                                <div class="info-cita" style="flex-grow: 1; margin-left: 15px;">
                                    <div class="paciente-cita" style="display: flex; align-items: center;">
                                        <img src="https://via.placeholder.com/40" alt="Paciente" style="margin-right: 10px;" />
                                        <div>
                                            <h4><%# Eval("paciente") %></h4>
                                            <p>Modalidad: <%# Eval("modalidad") %></p>
                                            <p>Dirección: <%# Eval("direccionLocal") %></p>
                                            <p>Consultorio N° <%# Eval("numConsultorio") %> - Piso <%# Eval("pisoConsultorio") %></p>
                                        </div>
                                    </div>
                                </div>

                                <!-- Estado a la derecha -->
                                <div class="estado-cita" style="margin-left: 15px; white-space: nowrap;">
                                    <%# Eval("estado") %>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                </div>
            </div>
        </div>

        <style>
            .dropdown-filtro {
                padding: 5px 10px;
                font-size: 1rem;
                border-radius: 6px;
                border: 1px solid #ccc;
                background-color: #fff;
                margin-left: 10px;
            }

        </style>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const ddlEstado = document.getElementById("ddlEstadoFiltro");
                const citas = document.querySelectorAll(".cita-item");

                ddlEstado.addEventListener("change", function () {
                    const estadoSeleccionado = this.value;

                    citas.forEach(cita => {
                        const estadoCita = cita.getAttribute("data-estado");
                        if (estadoSeleccionado === "TODAS" || estadoCita === estadoSeleccionado) {
                            cita.style.display = "flex";
                        } else {
                            cita.style.display = "none";
                        }
                    });
                });
            });
        </script>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const inputBuscar = document.getElementById("txtBuscarPaciente");
                const citas = document.querySelectorAll(".cita-item");

                inputBuscar.addEventListener("input", function () {
                    const texto = this.value.toLowerCase();

                    citas.forEach(cita => {
                        const nombrePaciente = cita.getAttribute("data-paciente").toLowerCase();

                        if (nombrePaciente.includes(texto)) {
                            cita.style.display = "flex";
                        } else {
                            cita.style.display = "none";
                        }
                    });
                });
            });
        </script>

</asp:Content>