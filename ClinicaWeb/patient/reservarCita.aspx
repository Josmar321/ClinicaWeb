<%@ Page Language="C#" MasterPageFile="~/patient/PacienteMaster.master" AutoEventWireup="true" CodeBehind="reservarCita.aspx.cs" Inherits="ClinicaWeb.patient.reservarCita" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="dashboard-contenido">
        <asp:Button ID="btnCancelar" runat="server" CssClass="btn-cancelar" Text="← Regresar" OnClick="btnCancelar_Click" />

        <div class="encabezado-dashboard">
            <h1>Reservar Cita</h1>
        </div>

        <div class="contenedor-detalle-cita">
            <p><strong>Local:</strong> 
                <asp:Label ID="lblLocal" runat="server" CssClass="info-local" />
            </p>
            <p><strong>Código del médico:</strong> 
                <asp:Label ID="lblCodigoMedico" runat="server" CssClass="info-codigo-medico" />
            </p>

            <p><strong>Nombre del médico:</strong> 
                <asp:Label ID="lblNombreMedico" runat="server" CssClass="info-nombre-medico" />
            </p>

            <p><strong>Especialidad:</strong> 
                <asp:Label ID="lblEspecialidad" runat="server" CssClass="info-especialidad" />
            </p>

            <p><strong>Fecha:</strong> 
                <asp:Label ID="lblFecha" runat="server" CssClass="info-fecha" />
            </p>

            <br />

            <hr style="margin-top: 10px; margin-bottom: 10px;" />


            <p style="margin-top: 10px;"><strong>Horarios disponibles para el día seleccionado:</strong></p>
            <asp:Repeater ID="rptHoras" runat="server">
                <ItemTemplate>
                    <%# "<button type='button' class='btn-hora " + ((bool)Eval("Seleccionado") ? "seleccionado" : "") + "' onclick='seleccionarHora(this)'>" + Eval("Text") + "</button>" %>

                </ItemTemplate>
            </asp:Repeater>

            <!-- CAMPO OCULTO PARA GUARDAR LA HORA SELECCIONADA -->
            <asp:HiddenField ID="hfHoraSeleccionada" runat="server" />

            <asp:Label ID="Label1" runat="server" Text="No hay horarios disponibles para esta fecha." Visible="false" CssClass="mensaje-vacio" />

            <asp:Label ID="lblSinDisponibilidad" runat="server" Text="No hay horarios disponibles para esta fecha." Visible="false" CssClass="mensaje-vacio" />

            <br /><br />
            <!-- Consultorio -->
            <p><strong>Seleccionar Consultorio:</strong></p>
            <asp:DropDownList ID="ddlConsultorio" runat="server" CssClass="dropdown-consultorio" />

            <br /><br />

            <!-- Modalidad -->
            <p><strong>Seleccionar Modalidad:</strong></p>
            <asp:DropDownList ID="ddlModalidad" runat="server" CssClass="dropdown-consultorio" AutoPostBack="true" OnSelectedIndexChanged="ddlModalidad_SelectedIndexChanged">
                <asp:ListItem Text="Presencial" Value="PRESENCIAL" />
                <asp:ListItem Text="Virtual" Value="VIRTUAL" />
            </asp:DropDownList>


            <br /><br />

            <!-- Precio -->
            <p><strong>Precio:</strong> <asp:Label ID="lblPrecio" runat="server" Text="S/. 0.00" /></p>

            <br />

            <!-- Botón Reservar -->
            <asp:Button ID="btnReservar" runat="server" Text="Reservar Cita" CssClass="btn-reservar" OnClick="btnReservar_Click" />

        </div>

    </div>

<style>
    .btn-cancelar {
    background-color: #dc3545;
    color: white;
    border: none;
    padding: 8px 16px;
    font-size: 0.9rem;
    border-radius: 6px;
    cursor: pointer;
    margin-bottom: 20px;
    transition: background-color 0.2s ease;
    }
    .btn-cancelar:hover {
        background-color: #c82333;
    }
    .btn-hora {
        margin: 6px;
        padding: 10px 16px;
        border: 2px solid #007bff;
        background-color: white;
        color: #007bff;
        border-radius: 6px;
        cursor: pointer;
        font-size: 0.95rem;
        transition: all 0.2s ease;
    }

    .btn-hora:hover {
        background-color: #e6f0ff;
    }

    .btn-hora.seleccionado {
        background-color: #007bff;
        color: white;
    }

    .dropdown-consultorio {
        padding: 6px 10px;
        border-radius: 6px;
        font-size: 0.9rem;
        border: 1px solid #ccc;
    }

    .btn-reservar {
        padding: 10px 20px;
        font-size: 1rem;
        background-color: #28a745;
        color: white;
        border: none;
        border-radius: 6px;
        cursor: pointer;
    }

    .btn-reservar:hover {
        background-color: #218838;
    }
</style>

<script>
    function seleccionarHora(btn) {
        // Quitar clase seleccionada de todos los botones
        document.querySelectorAll('.btn-hora').forEach(b => b.classList.remove('seleccionado'));

        // Agregar clase al botón clickeado
        btn.classList.add('seleccionado');

        // Guardar el texto del botón (la hora) en el campo oculto
        document.getElementById('<%= hfHoraSeleccionada.ClientID %>').value = btn.textContent.trim();
    }
</script>

<!-- Modal de confirmación de cita -->
<div class="modal fade" id="modalCitaRegistrada" tabindex="-1" role="dialog" aria-labelledby="modalCitaRegistradaLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalCitaRegistradaLabel">Cita registrada</h5>
      </div>
      <div class="modal-body">
        ¡Cita registrada correctamente!
      </div>
      <div class="modal-footer">
        <a href="citas.aspx" class="btn btn-primary">Aceptar</a>
      </div>
    </div>
  </div>
</div>

</asp:Content>
