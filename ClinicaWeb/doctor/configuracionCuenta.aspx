<%@ Page Language="C#" MasterPageFile="~/doctor/DoctorMaster.master" AutoEventWireup="true" CodeBehind="configuracionCuenta.aspx.cs" Inherits="ClinicaWeb.doctor.configuracionCuenta" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="contenedor-configuracion">
        <div class="perfil-doctor">
            <div class="perfil-header">
                <div class="info-perfil">
                    <h2>Configuración de Cuenta</h2>
                </div>
            </div>
            <div class="formulario-configuracion">
                <!-- Campos comunes de Persona -->
                <div class="seccion-formulario">
                    <h3>Datos Personales</h3>
                    <div class="form-grupo">
                        <label for="txtDocIdentidad">Documento de Identidad</label>
                        <asp:TextBox ID="txtDocIdentidad" runat="server" CssClass="input-form" required="required" placeholder="Ingrese documento de identidad" />
                    </div>
                    <div class="form-grupo">
                        <label for="txtNombre">Nombre</label>
                        <asp:TextBox ID="txtNombre" runat="server" CssClass="input-form" required="required" placeholder="Ingrese nombre" />
                    </div>
                    <div class="form-grupo">
                        <label for="txtPrimerApellido">Primer Apellido</label>
                        <asp:TextBox ID="txtPrimerApellido" runat="server" CssClass="input-form" required="required" placeholder="Ingrese primer apellido" />
                    </div>
                    <div class="form-grupo">
                        <label for="txtSegundoApellido">Segundo Apellido</label>
                        <asp:TextBox ID="txtSegundoApellido" runat="server" CssClass="input-form" placeholder="Ingrese segundo apellido" />
                    </div>
                    <div class="form-grupo">
                        <label for="txtTelefono">Teléfono</label>
                        <asp:TextBox ID="txtTelefono" runat="server" CssClass="input-form" required="required" placeholder="Ingrese teléfono" />
                    </div>
                    <div class="form-grupo">
                        <label for="txtDireccion">Dirección</label>
                        <asp:TextBox ID="txtDireccion" runat="server" CssClass="input-form" required="required" placeholder="Ingrese dirección" />
                    </div>
                    <div class="form-grupo">
                        <label for="txtEmail">Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="input-form" type="email" required="required" placeholder="Ingrese email" />
                    </div>
                    <div class="form-grupo">
                        <label for="txtFechaNacimiento">Fecha de Nacimiento</label>
                        <asp:TextBox ID="txtFechaNacimiento" runat="server" CssClass="input-form" type="date" required="required" />
                    </div>
                    <div class="form-grupo">
                        <label for="ddlSexo">Sexo</label>
                        <asp:DropDownList ID="ddlSexo" runat="server" CssClass="input-form" required="required">
                            <asp:ListItem Value="">Seleccione sexo</asp:ListItem>
                            <asp:ListItem Value="M">Masculino</asp:ListItem>
                            <asp:ListItem Value="F">Femenino</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-grupo">
                        <label for="ddlDepartamento">Departamento</label>
                        <asp:DropDownList ID="ddlDepartamento" runat="server" CssClass="input-form" AutoPostBack="true" OnSelectedIndexChanged="ddlDepartamento_SelectedIndexChanged" required="required">
                            <asp:ListItem Value="">Seleccione departamento</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-grupo">
                        <label for="ddlCiudad">Ciudad</label>
                        <asp:DropDownList ID="ddlCiudad" runat="server" CssClass="input-form" required="required">
                            <asp:ListItem Value="">Seleccione ciudad</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-grupo">
                        <label for="fileFoto">Foto</label>
                        <asp:FileUpload ID="fileFoto" runat="server" CssClass="input-form" accept="image/*" />
                    </div>
                </div>

                <!-- Campos específicos según rol -->
                <asp:Panel ID="pnlPaciente" runat="server" CssClass="seccion-formulario" Visible="false">
                    <h3>Datos de Paciente</h3>
                    <div class="form-grupo">
                        <label for="ddlTipoSangre">Tipo de Sangre</label>
                        <asp:DropDownList ID="ddlTipoSangre" runat="server" CssClass="input-form" required="required">
                            <asp:ListItem Value="">Seleccione tipo de sangre</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-grupo">
                        <label for="txtPeso">Peso (kg)</label>
                        <asp:TextBox ID="txtPeso" runat="server" CssClass="input-form" type="number" step="0.01" required="required" placeholder="Ingrese peso" />
                    </div>
                    <div class="form-grupo">
                        <label for="txtAltura">Altura (m)</label>
                        <asp:TextBox ID="txtAltura" runat="server" CssClass="input-form" type="number" step="0.01" required="required" placeholder="Ingrese altura" />
                    </div>
                </asp:Panel>

                <asp:Panel ID="pnlMedico" runat="server" CssClass="seccion-formulario" Visible="false">
                    <h3>Datos de Médico</h3>
                    <div class="form-grupo">
                        <label for="txtNumeroColegiatura">Número de Colegiatura</label>
                        <asp:TextBox ID="txtNumeroColegiatura" runat="server" CssClass="input-form" required="required" placeholder="Ingrese número de colegiatura" />
                    </div>
                </asp:Panel>

                <asp:Panel ID="pnlAdministrador" runat="server" CssClass="seccion-formulario" Visible="false">
                    <h3>Datos de Administrador</h3>
                    <!-- No hay campos adicionales para administrador -->
                </asp:Panel>

                <asp:Button ID="btnGuardar" runat="server" CssClass="btn-guardar" Text="Registrar Persona" OnClick="btnGuardar_Click" />
                <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje-resultado" />
            </div>
        </div>
    </div>

    <style>
    .contenedor-configuracion {
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: calc(100vh - 100px);
        padding: 2rem;
        background-color: #f8f9fa;
    }

    .perfil-doctor {
        width: 100%;
        max-width: 800px;
        background: #fff;
        border-radius: 15px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        overflow: hidden;
    }

    .perfil-header {
        background: var(--color-principal);
        padding: 2rem;
        color: white;
        text-align: center;
    }

    .perfil-header h2 {
        margin: 0;
        font-size: 1.8rem;
        font-weight: 600;
    }

    .perfil-header p {
        margin: 0.5rem 0 0;
        opacity: 0.9;
    }

    .formulario-configuracion {
        padding: 2rem;
    }

    .seccion-formulario {
        margin-bottom: 2rem;
        padding-bottom: 2rem;
        border-bottom: 1px solid #eee;
    }

    .seccion-formulario:last-child {
        border-bottom: none;
    }

    .seccion-formulario h3 {
        color: var(--color-principal);
        margin-bottom: 1.5rem;
        font-size: 1.4rem;
    }

    .form-grupo {
        margin-bottom: 1.5rem;
    }

    .form-grupo label {
        display: block;
        margin-bottom: 0.5rem;
        font-weight: 500;
        color: #333;
    }

    .input-form {
        width: 100%;
        padding: 0.75rem 1rem;
        border: 1px solid #ddd;
        border-radius: 8px;
        font-size: 1rem;
        transition: border-color 0.3s, box-shadow 0.3s;
    }

    .input-form:focus {
        border-color: var(--color-principal);
        box-shadow: 0 0 0 3px rgba(var(--color-principal-rgb), 0.1);
        outline: none;
    }

    .btn-guardar {
        width: 100%;
        padding: 0.75rem;
        background: var(--color-principal);
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 1rem;
        font-weight: 500;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .btn-guardar:hover {
        background: var(--color-principal-hover);
    }

    .mensaje-resultado {
        display: block;
        margin-top: 1rem;
        padding: 0.75rem;
        border-radius: 8px;
        text-align: center;
        font-weight: 500;
    }

    .mensaje-resultado.success {
        background-color: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
    }

    .mensaje-resultado.error {
        background-color: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
    }
    </style>
</asp:Content>