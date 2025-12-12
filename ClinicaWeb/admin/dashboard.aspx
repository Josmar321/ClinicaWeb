<%@ Page Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="ClinicaWeb.admin.dashboard" %>


<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Dashboard - NeoSalud
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
            <div class="dashboard-contenido">
                <!-- Métricas Principales -->
                <div class="grid-metricas">
                    <div class="tarjeta-metrica">
                        <div class="icono-metrica">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <div class="info-metrica">
                            <h3>Citas Hoy</h3>
                            <div class="valor"><asp:Label ID="lblCitasHoy" runat="server" Text="0"></asp:Label></div>
                            <div id="divTendencia" runat="server" class='<%# litClaseTendencia.Text %>'>
                                <i class="fas" runat="server" id="iconTendencia"></i> 
                                <asp:Label ID="lblPorcentaje" runat="server" Text=""></asp:Label>
                            </div>

                            <asp:Literal ID="litClaseTendencia" runat="server" Visible="false" />
                            <asp:Literal ID="litIconoTendencia" runat="server" Visible="false" />
                        </div>
                    </div>
                    <div class="tarjeta-metrica">
                        <div class="icono-metrica">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="info-metrica">
                            <h3>En Espera</h3>
                            <div class="valor"><asp:Label ID="lblEnEspera" runat="server" Text="0"></asp:Label></div>
                        </div>
                    </div>
                    <div class="tarjeta-metrica">
                        <div class="icono-metrica">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <div class="info-metrica">
                            <h3>Atendidos</h3>
                            <div class="valor"><asp:Label ID="lblAtendidos" runat="server" Text="0"></asp:Label></div>
                            <div id="divTendenciaAtendidos" runat="server" class='<%# litClaseTendenciaAtendidos.Text %>'>
                                <i class="fas" runat="server" id="iconTendenciaAtendidos"></i> 
                                <asp:Label ID="lblPorcentajeAtendidos" runat="server" Text=""></asp:Label>
                            </div>

                            <asp:Literal ID="litClaseTendenciaAtendidos" runat="server" Visible="false" />
                            <asp:Literal ID="litIconoTendenciaAtendidos" runat="server" Visible="false" />
                        </div>
                    </div>
                    <div class="tarjeta-metrica">
                        <div class="icono-metrica">
                            <i class="fa-solid fa-ban"></i>
                        </div>
                        <div class="info-metrica">
                            <h3>Canceladas</h3>
                            <div class="valor"><asp:Label ID="lblCanceladas" runat="server" Text="0"></asp:Label></div>
                            <div id="divTendenciaCanceladas" runat="server" class='<%# litClaseTendenciaCanceladas.Text %>'>
                                <i class="fas" runat="server" id="iconTendenciaCanceladas"></i> 
                                <asp:Label ID="lblPorcentajeCanceladas" runat="server" Text=""></asp:Label>
                            </div>

                            <asp:Literal ID="litClaseTendenciaCanceladas" runat="server" Visible="false" />
                            <asp:Literal ID="litIconoTendenciaCanceladas" runat="server" Visible="false" />
                        </div>
                    </div>
                </div>

                <!-- Secciones de Gestión -->
                <div class="secciones-gestion">
                    <!-- Últimas Citas -->
                    <div class="seccion">
                        <div class="seccion-header">
                            <h2>Últimas Citas</h2>
                        </div>
                        <div class="seccion-contenido">
                            <asp:Repeater ID="rptUltimasCitas" runat="server">
                                <ItemTemplate>
                                    <div class="cita-item">
                                        <div class="fecha-cita">
                                            <span class="dia"><%# Eval("fecha", "{0:dd}") %></span>
                                            <span class="mes"><%# Eval("fecha", "{0:MMM}") %></span>
                                            <span class="hora"><%# Eval("hora", "{0:HH:mm}") %></span>
                                        </div>
                                        <div class="info-cita">
                                            <div class="paciente-info">
                                                <h4><%# Eval("paciente") %></h4>
                                                <p><%# Eval("motivo") %></p>
                                                <div class="medico-info">
                                                    <i class="fas fa-user-md"></i>
                                                    <span><%# Eval("medico") %></span>
                                                </div>
                                            </div>
                                            <div class="estado-cita">
                                                <span class="estado <%# Eval("estadoCss") %>"><%# Eval("estadoTexto") %></span>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>

                    <!-- Horarios Pendientes -->
                    <div class="seccion">
                        <div class="seccion-header">
                            <h2>Horarios Pendientes</h2>
                        </div>
                        <div class="seccion-contenido">
                            <div class="lista-horarios">
                                <asp:Repeater ID="rptHorarios" runat="server">
                                    <ItemTemplate>
                                        <div class="horario-item">
                                            <div class="info-horario">
                                                <h4><%# Eval("Nombre") %></h4>
                                                <p><%# Eval("Especialidad") %></p>
                                                <span class="estado pendiente"><%# Eval("Pendientes") %> horarios por revisar</span>
                                            </div>
                                            <asp:Button runat="server" CssClass="btn-accion3"
                                                CommandName="VerDisponibilidades"
                                                CommandArgument='<%# Eval("CodigoMedico") + "|" + Eval("Nombre") %>'
                                                Text='Gestionar Horarios' />
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

<!-- Modal de Disponibilidades -->
<div class="modal fade" id="modalDisponibilidades" tabindex="-1" aria-labelledby="modalDisponibilidadesLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalDisponibilidadesLabel">Disponibilidades de <span id="nombreMedicoModal"></span></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
      </div>
      <div class="modal-body">
        <asp:Repeater ID="rptDisponibilidades" runat="server">
          <HeaderTemplate>
            <table class="table">
              <thead>
                <tr>
                  <th>Día</th>
                  <th>Hora Inicio</th>
                  <th>Hora Fin</th>
                  <th>Estado</th>
                  <th>Acción</th>
                </tr>
              </thead>
              <tbody>
          </HeaderTemplate>
          <ItemTemplate>
            <tr>
                <td><%# Eval("dia")%></td>
                <td><%# ((DateTime)Eval("horaInicio")).ToString("HH:mm") %></td>
                <td><%# ((DateTime)Eval("horaFin")).ToString("HH:mm") %></td>
              <td>
                <%# (bool)Eval("activo") ? "Activo" : "Inactivo" %>
              </td>
              <td>
                <asp:Button runat="server" ID="btnCambiarEstado"
                    CssClass="btn btn-sm"
                    Text='<%# (bool)Eval("activo") ? "Inactivar" : "Activar" %>'
                    CommandName="CambiarEstado"
                    CommandArgument='<%# Eval("idDisponibilidad") %>'/>
              </td>
            </tr>
          </ItemTemplate>
          <FooterTemplate>
              </tbody>
            </table>
          </FooterTemplate>
        </asp:Repeater>
      </div>
    </div>
  </div>
</div>
</asp:Content>

