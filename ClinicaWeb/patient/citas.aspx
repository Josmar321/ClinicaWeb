<%@ Page Language="C#" MasterPageFile="~/patient/PacienteMaster.master" AutoEventWireup="true" CodeBehind="citas.aspx.cs" Inherits="ClinicaWeb.patient.citas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
            <div class="dashboard-contenido">
                <div class="encabezado-dashboard">
                    <h1>Mis Citas</h1>
                    <a class="btn-nueva-cita" href="agendarCita.aspx">
                        <i class="fas fa-plus"></i>
                        Nueva Cita
                    </a>
                </div>

                <!-- Filtros -->
                <div class="filtro-estado-wrapper">
                    <label for="ddlFiltroEstado" class="filtro-label">Filtrar por:</label>
                    <asp:DropDownList ID="ddlFiltroEstado" runat="server"
                                      AutoPostBack="true"
                                      OnSelectedIndexChanged="ddlFiltroEstado_SelectedIndexChanged"
                                      CssClass="filtro-select">
                        <asp:ListItem Text="Todas" Value="TODAS" />
                        <asp:ListItem Text="Programadas" Value="PROGRAMADA" />
                        <asp:ListItem Text="Realizadas" Value="REALIZADA" />
                        <asp:ListItem Text="Canceladas" Value="CANCELADA" />
                    </asp:DropDownList>
                </div>
                    
                    <!-- Lista de Citas -->
                <div class="contenedor-citas">
                    <asp:Repeater ID="rptCitas" runat="server" OnItemCommand="rptCitas_ItemCommand">
                        <ItemTemplate>
                            <div class='cita-detallada <%# Eval("estado").ToString().ToLower() %>'>
                                <!-- Fecha a la izquierda -->
                                <div class='fecha-cita-grande'>
                                    <span class='dia'><%# Eval("fecha", "{0:dd}") %></span>
                                    <span class='mes'><%# Eval("fecha", "{0:MMM}") %></span>
                                    <span class='hora'><%# Eval("hora", "{0:hh\\:mm}") %></span>
                                </div>

                                <!-- Info y acciones -->
                                <div class='info-cita-contenido'>
                                    <!-- Info del doctor -->
                                    <div class='info-cita-detallada'>
                                        <h3>Dr. <%# Eval("medico.nombre") %> <%# Eval("medico.primerApellido") %> <%# Eval("medico.segundoApellido") %></h3>
                                        <p class='especialidad'><%# Eval("medico.especialidad.nombre") %></p>
                                        <p class='modalidad'><%# Eval("modalidad") %></p>
                                        <p class='local' style="margin-top: 5px;">
                                            <i class='fas fa-hospital'></i>
                                            <%# "Consultorio " + Eval("consultorio.numConsultorio") + ", Piso " + Eval("consultorio.piso") + ". " + Eval("consultorio.local.direccion") %>
                                        </p>
                                    </div>

                                    <!-- Estado y botones -->
                                    <div class='estado-cita alineado-derecha'>
                                        <span class='estado <%# Eval("estado").ToString().ToLower() %>'><%# Eval("estado") %></span>

                                        <asp:Button runat="server"
                                            CssClass="btn-cancelar"
                                            Text="Cancelar Cita"
                                            OnClientClick='<%# "abrirModalConfirmarCancelacion(" + Eval("idCita") + "); return false;" %>'
                                            Visible='<%# Eval("estado").ToString() == "PROGRAMADA" %>' />


                                        <asp:Button runat="server"
                                            CssClass="btn-modificar"
                                            Text="Modificar Cita"
                                            CommandName="Modificar"
                                            CommandArgument='<%# Eval("idCita") %>' 
                                            OnCommand="btnModificar_Command"
                                            Visible='<%# Eval("estado").ToString() == "PROGRAMADA" %>' />
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>

                    </asp:Repeater>
                </div>
                    <!-- Modal para modificar cita -->
<!-- Modal Bootstrap para modificar cita -->
<div class="modal fade" id="modalModificar" tabindex="-1" role="dialog" aria-labelledby="modalModificarLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalModificarLabel">Modificar Cita</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <asp:HiddenField ID="hfIdCitaModificar" runat="server" />
        <label for="ddlModalidad">Modalidad:</label>
        <asp:DropDownList ID="ddlModalidad" runat="server" CssClass="input-modalidad">
          <asp:ListItem Text="PRESENCIAL" Value="PRESENCIAL" />
          <asp:ListItem Text="VIRTUAL" Value="VIRTUAL" />
        </asp:DropDownList>
        <label for="ddlHoraNueva">Hora:</label>
        <asp:DropDownList ID="ddlHoraNueva" runat="server" CssClass="input-hora"></asp:DropDownList>
      </div>
      <div class="modal-footer">
        <asp:Button ID="btnGuardarCambios" runat="server" Text="Guardar Cambios" CssClass="btn btn-primary" OnClick="btnGuardarCambios_Click" />
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
      </div>
    </div>
  </div>
</div>

<!-- Modal Bootstrap para confirmar cancelación -->
<div class="modal fade" id="modalConfirmarCancelacion" tabindex="-1" role="dialog" aria-labelledby="modalCancelarLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Cancelar Cita</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <asp:HiddenField ID="hfIdCitaCancelar" runat="server" />
        ¿Estás seguro que deseas cancelar esta cita?
      </div>
      <div class="modal-footer">
        <asp:Button ID="btnConfirmarCancelacion" runat="server" Text="Sí, Cancelar" CssClass="btn btn-danger" OnClick="btnConfirmarCancelacion_Click" />
        <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
      </div>
    </div>
  </div>
</div>

                </div>

            <style>
            .contenedor-citas {
                display: flex;
                flex-direction: column;
                gap: 20px;
            }

            /* Cada cita en un contenedor horizontal */
            .cita-detallada {
                display: flex;
                flex-direction: row;
                align-items: flex-start;
                justify-content: flex-start;
                background-color: #f9f9fb;
                border: 1px solid #e0e0e0;
                border-radius: 8px;
                padding: 20px;
                box-sizing: border-box;
                width: 100%;
                gap: 20px;
            }

            /* Fecha a la izquierda */
            .fecha-cita-grande {
                width: 80px;
                text-align: center;
                font-weight: bold;
                font-size: 1rem;
                color: #2c3e50;
                flex-shrink: 0;
            }

            .fecha-cita-grande .dia {
                font-size: 2rem;
            }

            .fecha-cita-grande .mes {
                font-size: 0.9rem;
                color: #666;
            }

            .fecha-cita-grande .hora {
                display: block;
                font-size: 0.85rem;
                margin-top: 5px;
                color: #007bff;
            }

            /* Contenedor de la info del médico y botones */
            .info-cita-contenido {
                display: flex;
                justify-content: space-between;
                flex: 1;
                gap: 20px;
                flex-wrap: wrap;
            }

            /* Parte izquierda del contenido */
            .info-cita-detallada {
                flex: 1;
            }

            /* Estado y botones a la derecha */
            .estado-cita.alineado-derecha {
                display: flex;
                flex-direction: column;
                align-items: flex-end;
                min-width: 150px;
                gap: 10px;
            }

            /* Etiqueta de estado */
            .estado {
                font-weight: bold;
                color: #2c3e50;
                padding: 5px 10px;
                background-color: #ecf0f1;
                border-radius: 4px;
            }

            .estado.programada {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }

            .estado.realizada {
                background-color: #dee2e6;
                color: #343a40;
                border: 1px solid #ced4da;
            }

            .estado.cancelada {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }

            .especialidad {
                font-size: 0.95rem;
                color: #555;
                margin: 3px 0;
            }

            /* Botones */
            .btn-cancelar,
            .btn-modificar {
                padding: 6px 12px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 0.9rem;
                width: fit-content;
            }

            .btn-cancelar {
                background-color: #e74c3c;
                color: white;
            }

            .btn-cancelar:hover {
                background-color: #c0392b;
            }

            .btn-modificar {
                background-color: #f1c40f;
                color: white;
            }

            .btn-modificar:hover {
                background-color: #d4ac0d;
            }

            .filtro-estado-wrapper {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 25px;
                padding: 10px 15px;
                background-color: #ffffff;
                border-radius: 8px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.05);
                max-width: 350px;
            }

            .filtro-label {
                font-size: 15px;
                color: #34495e;
                font-weight: 500;
            }

            .filtro-select {
                padding: 8px 12px;
                font-size: 15px;
                border: 1px solid #ccc;
                border-radius: 6px;
                background-color: #f8f9fa;
                transition: border-color 0.2s;
            }

            .filtro-select:focus {
                border-color: #3498db;
                outline: none;
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
            function abrirModalConfirmarCancelacion(idCita) {
                document.getElementById('<%= hfIdCitaCancelar.ClientID %>').value = idCita;
                    $('#modalConfirmarCancelacion').modal('show');
                }
            </script>
</asp:Content> 