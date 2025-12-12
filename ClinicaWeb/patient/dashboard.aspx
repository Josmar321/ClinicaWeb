<%@ Page Language="C#" MasterPageFile="~/patient/PacienteMaster.master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="ClinicaWeb.patient.dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

            <div class="dashboard-contenido">
                <div class="encabezado-dashboard">
                    <h1>Bienvenido, <%: Session["NombrePaciente"] ?? "Paciente" %></h1>
                    <a class="btn-nueva-cita" href="agendarCita.aspx">
                        <i class="fas fa-plus"></i>
                        Nueva Cita
                    </a>
                </div>

                <!-- Próxima Cita -->
                <section class="seccion proxima-cita">
                    <h2>Tu Próxima Cita</h2>
                    <asp:Panel ID="pnlProximaCita" runat="server" Visible="false">
                        <div class="cita-detalle">
                            <div class="info-cita-principal">
                                <div class="fecha-hora">
                                    <i class="fas fa-calendar"></i>
                                    <asp:Label ID="lblFechaCita" runat="server" />
                                    <i class="fas fa-clock"></i>
                                    <asp:Label ID="lblHoraCita" runat="server" />
                                </div>
                                <h3><asp:Label ID="lblDoctorCita" runat="server" /></h3>
                                <p class="especialidad"><asp:Label ID="lblEspecialidadCita" runat="server" /></p>
                                <p class="local"><i class="fas fa-hospital"></i> <asp:Label ID="lblDireccionCita" runat="server" /></p>
                            </div>

                        </div>
                    </asp:Panel>
                    <asp:Label ID="lblSinCitas" runat="server" Text="No tienes citas programadas próximamente." Visible="false" Style="margin-left: 3em;" CssClass="mensaje-vacio" />
                </section>


                <!-- Secciones de Gestión -->
                <div class="secciones-gestion">
                    <!-- Historial de Citas -->
                        <section class="seccion historial-citas">
                            <h2>Historial de Citas</h2>
                            <div class="cita-detalle">
                                <asp:Repeater ID="rptHistorialCitas" runat="server">
                                    <ItemTemplate>
                                        <div class="cita-item">
                                            <div class="fecha-cita">
                                                <span class="dia"><%# Eval("fecha", "{0:dd}") %></span>
                                                <span class="mes"><%# Eval("fecha", "{0:MMM}") %></span>
                                            </div>
                                            <div class="info-cita">
                                                <h4><%# "Dr(a). " + Eval("medico.nombre") + " " + Eval("medico.primerApellido") %></h4>
                                                <p><%# Eval("medico.especialidad.nombre") %></p>
                                                <span class="estado completada">REALIZADA</span>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <asp:Label ID="lblSinHistorial" runat="server" Text="No hay citas realizadas aún." CssClass="mensaje-sin-citas" Style="margin-left: 3em;" Visible="false" />
                            </div>
                        </section>


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
        .dropdown-content-perfil a:hover {
            background: #f1f1f1;
        }
        .dropdown-link {
            color: #333;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            transition: background 0.2s;
            cursor: pointer;
        }
        .dropdown-link:hover {
            background: #f1f1f1;
        }
        .dropdown-perfil.active .dropdown-content-perfil {
            display: block;
        }

        .secciones-gestion {
            width: 100%;
        }

        .secciones-gestion .seccion {
            width: 100%;
        }
        .cita-detalle {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 4px rgba(0,0,0,0.05);
            margin-top: 10px;
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