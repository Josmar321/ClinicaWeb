<%@ Page Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="RegistroPersona.aspx.cs" Inherits="ClinicaWeb.admin.RegistroPersona" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Registro de Persona - NeoSalud
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="registro-persona-container">
        <div class="registro-persona-card">
            <div class="registro-persona-header">
                <div class="header-content">
                    <div class="admin-info-header">
                        <div class="admin-avatar-header">
                            <asp:Image ID="imgAdminFoto" runat="server" CssClass="admin-foto" />
                            <div class="admin-avatar-placeholder" id="adminAvatarPlaceholder">
                                <i class="fas fa-user-shield"></i>
                            </div>
                        </div>
                        <div class="admin-details-header">
                            <h3 id="adminName">Administrador</h3>
                            <span id="adminRole">Sistema NeoSalud</span>
                        </div>
                    </div>
                    <div class="registro-persona-icon">
                        <i class="fas fa-user-plus"></i>
                    </div>
                </div>
                <div class="registro-persona-title">
                    <h2>Registro de Persona</h2>
                    <p>Complete los datos de la persona según su rol</p>
                </div>
            </div>
            
            <div class="registro-persona-content">
                <!-- Campos comunes de Persona -->
                <div class="form-section">
                    <div class="section-header">
                        <i class="fas fa-user"></i>
                        <h3>Datos Personales</h3>
                    </div>
                    
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="txtDocIdentidad">
                                <i class="fas fa-id-card"></i>
                                Documento de Identidad
                            </label>
                            <asp:TextBox ID="txtDocIdentidad" runat="server" CssClass="form-input" required="required" placeholder="Ingrese documento de identidad" />
                        </div>
                        
                        <div class="form-group">
                            <label for="txtNombre">
                                <i class="fas fa-user"></i>
                                Nombre
                            </label>
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-input" required="required" placeholder="Ingrese nombre" />
                        </div>
                        
                        <div class="form-group">
                            <label for="txtPrimerApellido">
                                <i class="fas fa-user"></i>
                                Primer Apellido
                            </label>
                            <asp:TextBox ID="txtPrimerApellido" runat="server" CssClass="form-input" required="required" placeholder="Ingrese primer apellido" />
                        </div>
                        
                        <div class="form-group">
                            <label for="txtSegundoApellido">
                                <i class="fas fa-user"></i>
                                Segundo Apellido
                            </label>
                            <asp:TextBox ID="txtSegundoApellido" runat="server" CssClass="form-input" placeholder="Ingrese segundo apellido" />
                        </div>
                        
                        <div class="form-group">
                            <label for="txtTelefono">
                                <i class="fas fa-phone"></i>
                                Teléfono
                            </label>
                            <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-input" required="required" placeholder="Ingrese teléfono" />
                        </div>
                        
                        <div class="form-group">
                            <label for="txtDireccion">
                                <i class="fas fa-map-marker-alt"></i>
                                Dirección
                            </label>
                            <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-input" required="required" placeholder="Ingrese dirección" />
                        </div>
                        
                        <div class="form-group">
                            <label for="txtEmail">
                                <i class="fas fa-envelope"></i>
                                Email
                            </label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input" type="email" required="required" placeholder="Ingrese email" />
                        </div>
                        
                        <div class="form-group">
                            <label for="txtFechaNacimiento">
                                <i class="fas fa-calendar"></i>
                                Fecha de Nacimiento
                            </label>
                            <asp:TextBox ID="txtFechaNacimiento" runat="server" CssClass="form-input" type="date" required="required" />
                        </div>
                        
                        <div class="form-group">
                            <label for="ddlSexo">
                                <i class="fas fa-venus-mars"></i>
                                Sexo
                            </label>
                            <asp:DropDownList ID="ddlSexo" runat="server" CssClass="form-select" required="required">
                                <asp:ListItem Value="">Seleccione sexo</asp:ListItem>
                                <asp:ListItem Value="M">Masculino</asp:ListItem>
                                <asp:ListItem Value="F">Femenino</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        
                        <div class="form-group">
                            <label for="ddlDepartamento">
                                <i class="fas fa-map"></i>
                                Departamento
                            </label>
                            <asp:DropDownList ID="ddlDepartamento" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlDepartamento_SelectedIndexChanged" required="required">
                                <asp:ListItem Value="">Seleccione departamento</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        
                        <div class="form-group">
                            <label for="ddlCiudad">
                                <i class="fas fa-city"></i>
                                Ciudad
                            </label>
                            <asp:DropDownList ID="ddlCiudad" runat="server" CssClass="form-select" required="required">
                                <asp:ListItem Value="">Seleccione ciudad</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        
                        <div class="form-group full-width">
                            <label for="fileFoto">
                                <i class="fas fa-camera"></i>
                                Foto (Opcional)
                            </label>
                            <div class="file-upload-container">
                                <asp:FileUpload ID="fileFoto" runat="server" CssClass="file-upload" accept="image/*" onchange="validarArchivo(this)" />
                                <div class="file-upload-info">
                                    <i class="fas fa-cloud-upload-alt"></i>
                                    <span>Haga clic para seleccionar una imagen (JPG, PNG, GIF, BMP - Máximo 5MB)</span>
                                </div>
                                <div id="fileInfo" class="file-info" style="display: none;">
                                    <i class="fas fa-check-circle"></i>
                                    <span id="fileName"></span>
                                    <span id="fileSize"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Campos específicos según rol -->
                <asp:Panel ID="pnlPaciente" runat="server" CssClass="form-section" Visible="false">
                    <div class="section-header">
                        <i class="fas fa-heartbeat"></i>
                        <h3>Datos de Paciente</h3>
                    </div>
                    
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="ddlTipoSangre">
                                <i class="fas fa-tint"></i>
                                Tipo de Sangre
                            </label>
                            <asp:DropDownList ID="ddlTipoSangre" runat="server" CssClass="form-select" required="required">
                                <asp:ListItem Value="">Seleccione tipo de sangre</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        
                        <div class="form-group">
                            <label for="txtPeso">
                                <i class="fas fa-weight"></i>
                                Peso (kg)
                            </label>
                            <asp:TextBox ID="txtPeso" runat="server" CssClass="form-input" type="number" step="0.01" required="required" placeholder="Ingrese peso" />
                        </div>
                        
                        <div class="form-group">
                            <label for="txtAltura">
                                <i class="fas fa-ruler-vertical"></i>
                                Altura (m)
                            </label>
                            <asp:TextBox ID="txtAltura" runat="server" CssClass="form-input" type="number" step="0.01" required="required" placeholder="Ingrese altura" />
                        </div>
                    </div>
                </asp:Panel>

                <asp:Panel ID="pnlMedico" runat="server" CssClass="form-section" Visible="false">
                    <div class="section-header">
                        <i class="fas fa-user-md"></i>
                        <h3>Datos de Médico</h3>
                    </div>
                    
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="txtNumeroColegiatura">
                                <i class="fas fa-certificate"></i>
                                Número de Colegiatura
                            </label>
                            <asp:TextBox ID="txtNumeroColegiatura" runat="server" CssClass="form-input" required="required" placeholder="Ingrese número de colegiatura" />
                        </div>
                        
                        <div class="form-group">
                            <label for="ddlEspecialidad">
                                <i class="fas fa-stethoscope"></i>
                                Especialidad
                            </label>
                            <asp:DropDownList ID="ddlEspecialidad" runat="server" CssClass="form-select" required="required">
                                <asp:ListItem Value="">Seleccione especialidad</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                </asp:Panel>

                <asp:Panel ID="pnlAdministrador" runat="server" CssClass="form-section" Visible="false">
                    <div class="section-header">
                        <i class="fas fa-user-shield"></i>
                        <h3>Datos de Administrador</h3>
                    </div>
                    <div class="admin-info">
                        <i class="fas fa-info-circle"></i>
                        <p>No se requieren campos adicionales para el administrador</p>
                    </div>
                </asp:Panel>

                <div class="form-actions">
                    <asp:Button ID="btnCancelar" runat="server" CssClass="btn-cancel" Text="Cancelar" OnClick="btnCancelar_Click" />
                    <asp:Button ID="btnGuardar" runat="server" CssClass="btn-save" Text="Registrar Persona" OnClick="btnGuardar_Click" />
                </div>
                
                <asp:Label ID="lblMensaje" runat="server" CssClass="message-result" />
            </div>
        </div>
    </div>

    <style>
    .registro-persona-container {
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: calc(100vh - 100px);
        padding: 2rem;
        background-color: #f8f9fa;
    }

    .registro-persona-card {
        width: 100%;
        max-width: 800px;
        background: #fff;
        border-radius: 15px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        overflow: hidden;
    }

    .registro-persona-header {
        background: var(--color-principal);
        padding: 2rem;
        color: white;
        text-align: center;
    }

    .registro-persona-header h2 {
        margin: 0;
        font-size: 1.8rem;
        font-weight: 600;
    }

    .registro-persona-header p {
        margin: 0.5rem 0 0;
        opacity: 0.9;
    }

    .registro-persona-content {
        padding: 2rem;
    }

    .form-section {
        margin-bottom: 2rem;
        padding-bottom: 2rem;
        border-bottom: 1px solid #eee;
    }

    .form-section:last-child {
        border-bottom: none;
    }

    .section-header {
        color: var(--color-principal);
        margin-bottom: 1.5rem;
        font-size: 1.4rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .form-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 1.5rem;
    }

    .form-group {
        margin-bottom: 1.5rem;
    }

    .form-group label {
        display: block;
        margin-bottom: 0.5rem;
        font-weight: 500;
        color: #333;
    }

    .form-input {
        width: 100%;
        padding: 0.75rem 1rem;
        border: 1px solid #ddd;
        border-radius: 8px;
        font-size: 1rem;
        transition: border-color 0.3s, box-shadow 0.3s;
    }

    .form-input:focus {
        border-color: var(--color-principal);
        box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        outline: none;
    }

    .form-select {
        width: 100%;
        padding: 0.75rem 1rem;
        border: 1px solid #ddd;
        border-radius: 8px;
        font-size: 1rem;
        transition: border-color 0.3s, box-shadow 0.3s;
    }

    .form-select:focus {
        border-color: var(--color-principal);
        box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        outline: none;
    }

    .file-upload-container {
        border: 2px dashed #ddd;
        border-radius: 8px;
        padding: 1.5rem;
        text-align: center;
        transition: border-color 0.3s, background-color 0.3s;
        cursor: pointer;
    }

    .file-upload-container:hover {
        border-color: var(--color-principal);
        background-color: rgba(52, 152, 219, 0.05);
    }

    .file-upload {
        display: none;
    }

    .file-upload-info {
        color: #666;
        font-size: 0.9rem;
    }

    .file-upload-info i {
        font-size: 2rem;
        color: var(--color-principal);
        margin-bottom: 0.5rem;
        display: block;
    }

    .file-info {
        margin-top: 1rem;
        padding: 0.75rem;
        background-color: #d4edda;
        border: 1px solid #c3e6cb;
        border-radius: 6px;
        color: #155724;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .file-info.error {
        background-color: #f8d7da;
        border-color: #f5c6cb;
        color: #721c24;
    }

    .file-info i {
        color: #28a745;
    }

    .file-info.error i {
        color: #dc3545;
    }

    .form-actions {
        display: flex;
        gap: 1rem;
        margin-top: 2rem;
    }

    .btn-cancel, .btn-save {
        flex: 1;
        padding: 0.75rem;
        border: none;
        border-radius: 8px;
        font-size: 1rem;
        font-weight: 500;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .btn-save {
        background-color: #1a73e8;
        color: white;
        border: none;
        border-radius: 8px;
        transition: background-color 0.3s ease, transform 0.2s ease;
    }

    .btn-save:hover {
        background-color: #1558b0;
        transform: scale(1.02);
    }

    .btn-cancel {
        background: #dc3545;
        color: white;
        border: none;
        border-radius: 8px;
        transition: background-color 0.3s ease, transform 0.2s ease;
    }

    .btn-cancel:hover {
        background: #c82333;
        transform: scale(1.02);
    }

    .message-result {
        display: block;
        margin-top: 1rem;
        padding: 0.75rem;
        border-radius: 8px;
        text-align: center;
        font-weight: 500;
    }

    .message-result.success {
        background-color: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
    }

    .message-result.error {
        background-color: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
    }

    .admin-info {
        background-color: #e3f2fd;
        border: 1px solid #bbdefb;
        border-radius: 8px;
        padding: 1rem;
        display: flex;
        align-items: center;
        gap: 0.75rem;
        color: #1976d2;
    }

    .admin-info i {
        font-size: 1.25rem;
    }

    .admin-info p {
        margin: 0;
        font-style: italic;
    }
    </style>

    <script>
        function validarArchivo(input) {
            const file = input.files[0];
            const fileInfo = document.getElementById('fileInfo');
            const fileName = document.getElementById('fileName');
            const fileSize = document.getElementById('fileSize');
            
            if (file) {
                // Validar tipo de archivo
                const extensionesPermitidas = ['.jpg', '.jpeg', '.png', '.gif', '.bmp'];
                const extension = '.' + file.name.split('.').pop().toLowerCase();
                
                if (!extensionesPermitidas.includes(extension)) {
                    fileInfo.className = 'file-info error';
                    fileInfo.innerHTML = '<i class="fas fa-times-circle"></i><span>Error: Solo se permiten archivos de imagen (JPG, PNG, GIF, BMP)</span>';
                    fileInfo.style.display = 'flex';
                    input.value = '';
                    return;
                }
                
                // Validar tamaño (5MB)
                const maxSize = 5 * 1024 * 1024; // 5MB en bytes
                if (file.size > maxSize) {
                    fileInfo.className = 'file-info error';
                    fileInfo.innerHTML = '<i class="fas fa-times-circle"></i><span>Error: El archivo es demasiado grande. Máximo 5MB permitido.</span>';
                    fileInfo.style.display = 'flex';
                    input.value = '';
                    return;
                }
                
                // Mostrar información del archivo
                fileInfo.className = 'file-info';
                fileName.textContent = file.name;
                fileSize.textContent = '(' + (file.size / 1024 / 1024).toFixed(2) + ' MB)';
                fileInfo.style.display = 'flex';
            } else {
                fileInfo.style.display = 'none';
            }
        }

        // Hacer que el contenedor sea clickeable
        document.addEventListener('DOMContentLoaded', function() {
            const container = document.querySelector('.file-upload-container');
            const fileInput = document.getElementById('<%= fileFoto.ClientID %>');
            
            if (container && fileInput) {
                container.addEventListener('click', function() {
                    fileInput.click();
                });
            }
        });
    </script>
</asp:Content>