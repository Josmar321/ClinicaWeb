<%@ Page Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="configuracion.aspx.cs" Inherits="ClinicaWeb.admin.configuracion" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Configuracion - NeoSalud
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
            <div class="dashboard-contenido">
                <div class="encabezado-seccion">
                    <h1>Configuración del Sistema</h1>
                    <div class="acciones-configuracion">
                        <button class="btn btn-secundario">
                            <i class="fas fa-save"></i> Guardar Cambios
                        </button>
                        <button class="btn btn-principal">
                            <i class="fas fa-sync"></i> Restaurar Valores
                        </button>
                    </div>
                </div>

                <!-- Pestañas de Configuración -->
                <div class="tabs-configuracion">
                    <button class="tab-btn activo" data-tab="general">
                        <i class="fas fa-sliders-h"></i> General
                    </button>
                    <button class="tab-btn" data-tab="notificaciones">
                        <i class="fas fa-bell"></i> Notificaciones
                    </button>
                    <button class="tab-btn" data-tab="seguridad">
                        <i class="fas fa-shield-alt"></i> Seguridad
                    </button>
                    <button class="tab-btn" data-tab="apariencia">
                        <i class="fas fa-paint-brush"></i> Apariencia
                    </button>
                    <button class="tab-btn" data-tab="integracion">
                        <i class="fas fa-plug"></i> Integración
                    </button>
                </div>

                <!-- Contenido de las Pestañas -->
                <div class="contenido-tabs">
                    <!-- Configuración General -->
                    <div class="tab-contenido activo" id="general">
                        <div class="grid-configuracion">
                            <div class="tarjeta-configuracion">
                                <h3>Información de la Clínica</h3>
                                <div class="form-grupo">
                                    <label>Nombre de la Clínica</label>
                                    <input type="text" value="NeoSalud" class="input-config">
                                </div>
                                <div class="form-grupo">
                                    <label>RUC</label>
                                    <input type="text" value="20123456789" class="input-config">
                                </div>
                                <div class="form-grupo">
                                    <label>Dirección Principal</label>
                                    <input type="text" value="Av. Principal 123" class="input-config">
                                </div>
                                <div class="form-grupo">
                                    <label>Teléfono</label>
                                    <input type="tel" value="01-123-4567" class="input-config">
                                </div>
                                <div class="form-grupo">
                                    <label>Correo Electrónico</label>
                                    <input type="email" value="contacto@neosalud.com" class="input-config">
                                </div>
                            </div>

                            <div class="tarjeta-configuracion">
                                <h3>Horario de Atención</h3>
                                <div class="form-grupo">
                                    <label>Horario de Lunes a Viernes</label>
                                    <div class="horario-inputs">
                                        <input type="time" value="08:00" class="input-config">
                                        <span>a</span>
                                        <input type="time" value="20:00" class="input-config">
                                    </div>
                                </div>
                                <div class="form-grupo">
                                    <label>Horario de Sábados</label>
                                    <div class="horario-inputs">
                                        <input type="time" value="09:00" class="input-config">
                                        <span>a</span>
                                        <input type="time" value="14:00" class="input-config">
                                    </div>
                                </div>
                                <div class="form-grupo">
                                    <label>Duración de Citas (minutos)</label>
                                    <select class="input-config">
                                        <option>15</option>
                                        <option selected>30</option>
                                        <option>45</option>
                                        <option>60</option>
                                    </select>
                                </div>
                            </div>

                            <div class="tarjeta-configuracion">
                                <h3>Configuración de Citas</h3>
                                <div class="form-grupo">
                                    <label>Anticipación Mínima (horas)</label>
                                    <input type="number" value="24" class="input-config">
                                </div>
                                <div class="form-grupo">
                                    <label>Anticipación Máxima (días)</label>
                                    <input type="number" value="30" class="input-config">
                                </div>
                                <div class="form-grupo">
                                    <label>Recordatorio de Cita</label>
                                    <select class="input-config">
                                        <option>12 horas antes</option>
                                        <option selected>24 horas antes</option>
                                        <option>48 horas antes</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Configuración de Notificaciones -->
                    <div class="tab-contenido" id="notificaciones">
                        <div class="grid-configuracion">
                            <div class="tarjeta-configuracion">
                                <h3>Notificaciones por Email</h3>
                                <div class="form-grupo">
                                    <label class="switch-label">
                                        <input type="checkbox" checked>
                                        <span class="switch-slider"></span>
                                        Confirmación de Citas
                                    </label>
                                </div>
                                <div class="form-grupo">
                                    <label class="switch-label">
                                        <input type="checkbox" checked>
                                        <span class="switch-slider"></span>
                                        Recordatorios
                                    </label>
                                </div>
                                <div class="form-grupo">
                                    <label class="switch-label">
                                        <input type="checkbox" checked>
                                        <span class="switch-slider"></span>
                                        Cambios de Cita
                                    </label>
                                </div>
                                <div class="form-grupo">
                                    <label class="switch-label">
                                        <input type="checkbox">
                                        <span class="switch-slider"></span>
                                        Boletín Informativo
                                    </label>
                                </div>
                            </div>

                            <div class="tarjeta-configuracion">
                                <h3>Notificaciones Push</h3>
                                <div class="form-grupo">
                                    <label class="switch-label">
                                        <input type="checkbox" checked>
                                        <span class="switch-slider"></span>
                                        Nuevas Citas
                                    </label>
                                </div>
                                <div class="form-grupo">
                                    <label class="switch-label">
                                        <input type="checkbox" checked>
                                        <span class="switch-slider"></span>
                                        Recordatorios
                                    </label>
                                </div>
                                <div class="form-grupo">
                                    <label class="switch-label">
                                        <input type="checkbox">
                                        <span class="switch-slider"></span>
                                        Promociones
                                    </label>
                                </div>
                            </div>

                            <div class="tarjeta-configuracion">
                                <h3>Plantillas de Email</h3>
                                <div class="form-grupo">
                                    <label>Asunto por Defecto</label>
                                    <input type="text" value="NeoSalud - Confirmación de Cita" class="input-config">
                                </div>
                                <div class="form-grupo">
                                    <label>Firma del Email</label>
                                    <textarea class="input-config" rows="4">Saludos cordiales,
Equipo NeoSalud
Av. Principal 123
Tel: 01-123-4567</textarea>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Configuración de Seguridad -->
                    <div class="tab-contenido" id="seguridad">
                        <div class="grid-configuracion">
                            <div class="tarjeta-configuracion">
                                <h3>Políticas de Contraseñas</h3>
                                <div class="form-grupo">
                                    <label>Longitud Mínima</label>
                                    <input type="number" value="8" class="input-config">
                                </div>
                                <div class="form-grupo">
                                    <label class="switch-label">
                                        <input type="checkbox" checked>
                                        <span class="switch-slider"></span>
                                        Requerir Mayúsculas
                                    </label>
                                </div>
                                <div class="form-grupo">
                                    <label class="switch-label">
                                        <input type="checkbox" checked>
                                        <span class="switch-slider"></span>
                                        Requerir Números
                                    </label>
                                </div>
                                <div class="form-grupo">
                                    <label class="switch-label">
                                        <input type="checkbox" checked>
                                        <span class="switch-slider"></span>
                                        Requerir Caracteres Especiales
                                    </label>
                                </div>
                            </div>

                            <div class="tarjeta-configuracion">
                                <h3>Autenticación</h3>
                                <div class="form-grupo">
                                    <label class="switch-label">
                                        <input type="checkbox" checked>
                                        <span class="switch-slider"></span>
                                        Autenticación de Dos Factores
                                    </label>
                                </div>
                                <div class="form-grupo">
                                    <label>Tiempo de Sesión (minutos)</label>
                                    <input type="number" value="30" class="input-config">
                                </div>
                                <div class="form-grupo">
                                    <label>Intentos Máximos de Login</label>
                                    <input type="number" value="3" class="input-config">
                                </div>
                            </div>

                            <div class="tarjeta-configuracion">
                                <h3>Respaldo de Datos</h3>
                                <div class="form-grupo">
                                    <label>Frecuencia de Respaldo</label>
                                    <select class="input-config">
                                        <option>Diario</option>
                                        <option selected>Semanal</option>
                                        <option>Mensual</option>
                                    </select>
                                </div>
                                <div class="form-grupo">
                                    <label>Retención de Respaldos</label>
                                    <select class="input-config">
                                        <option>1 mes</option>
                                        <option selected>3 meses</option>
                                        <option>6 meses</option>
                                        <option>1 año</option>
                                    </select>
                                </div>
                                <button class="btn btn-secundario">
                                    <i class="fas fa-download"></i> Generar Respaldo
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Configuración de Apariencia -->
                    <div class="tab-contenido" id="apariencia">
                        <div class="grid-configuracion">
                            <div class="tarjeta-configuracion">
                                <h3>Tema de la Aplicación</h3>
                                <div class="form-grupo">
                                    <label>Modo de Color</label>
                                    <div class="tema-opciones">
                                        <label class="radio-label">
                                            <input type="radio" name="tema" checked>
                                            <span class="radio-custom"></span>
                                            Claro
                                        </label>
                                        <label class="radio-label">
                                            <input type="radio" name="tema">
                                            <span class="radio-custom"></span>
                                            Oscuro
                                        </label>
                                        <label class="radio-label">
                                            <input type="radio" name="tema">
                                            <span class="radio-custom"></span>
                                            Sistema
                                        </label>
                                    </div>
                                </div>
                                <div class="form-grupo">
                                    <label>Color Principal</label>
                                    <input type="color" value="#3498db" class="input-config">
                                </div>
                                <div class="form-grupo">
                                    <label>Color Secundario</label>
                                    <input type="color" value="#2ecc71" class="input-config">
                                </div>
                            </div>

                            <div class="tarjeta-configuracion">
                                <h3>Personalización de Interfaz</h3>
                                <div class="form-grupo">
                                    <label class="switch-label">
                                        <input type="checkbox" checked>
                                        <span class="switch-slider"></span>
                                        Mostrar Animaciones
                                    </label>
                                </div>
                                <div class="form-grupo">
                                    <label class="switch-label">
                                        <input type="checkbox" checked>
                                        <span class="switch-slider"></span>
                                        Mostrar Tooltips
                                    </label>
                                </div>
                                <div class="form-grupo">
                                    <label>Tamaño de Fuente</label>
                                    <select class="input-config">
                                        <option>Pequeño</option>
                                        <option selected>Mediano</option>
                                        <option>Grande</option>
                                    </select>
                                </div>
                            </div>

                            <div class="tarjeta-configuracion">
                                <h3>Logo y Marca</h3>
                                <div class="form-grupo">
                                    <label>Logo Principal</label>
                                    <div class="upload-logo">
                                        <img src="https://via.placeholder.com/150" alt="Logo">
                                        <button class="btn btn-secundario">
                                            <i class="fas fa-upload"></i> Cambiar Logo
                                        </button>
                                    </div>
                                </div>
                                <div class="form-grupo">
                                    <label>Favicon</label>
                                    <div class="upload-logo">
                                        <img src="https://via.placeholder.com/32" alt="Favicon">
                                        <button class="btn btn-secundario">
                                            <i class="fas fa-upload"></i> Cambiar Favicon
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Configuración de Integración -->
                    <div class="tab-contenido" id="integracion">
                        <div class="grid-configuracion">
                            <div class="tarjeta-configuracion">
                                <h3>API y Webhooks</h3>
                                <div class="form-grupo">
                                    <label>API Key</label>
                                    <div class="api-key">
                                        <input type="text" value="sk_live_123456789" readonly class="input-config">
                                        <button class="btn btn-secundario">
                                            <i class="fas fa-sync"></i> Regenerar
                                        </button>
                                    </div>
                                </div>
                                <div class="form-grupo">
                                    <label>Webhook URL</label>
                                    <input type="url" value="https://api.neosalud.com/webhook" class="input-config">
                                </div>
                                <div class="form-grupo">
                                    <label class="switch-label">
                                        <input type="checkbox" checked>
                                        <span class="switch-slider"></span>
                                        Activar Webhooks
                                    </label>
                                </div>
                            </div>

                            <div class="tarjeta-configuracion">
                                <h3>Integración con Servicios</h3>
                                <div class="form-grupo">
                                    <label class="switch-label">
                                        <input type="checkbox" checked>
                                        <span class="switch-slider"></span>
                                        Google Calendar
                                    </label>
                                </div>
                                <div class="form-grupo">
                                    <label class="switch-label">
                                        <input type="checkbox" checked>
                                        <span class="switch-slider"></span>
                                        WhatsApp Business
                                    </label>
                                </div>
                                <div class="form-grupo">
                                    <label class="switch-label">
                                        <input type="checkbox">
                                        <span class="switch-slider"></span>
                                        SMS Gateway
                                    </label>
                                </div>
                            </div>

                            <div class="tarjeta-configuracion">
                                <h3>Redes Sociales</h3>
                                <div class="form-grupo">
                                    <label>Facebook</label>
                                    <input type="url" value="https://facebook.com/neosalud" class="input-config">
                                </div>
                                <div class="form-grupo">
                                    <label>Instagram</label>
                                    <input type="url" value="https://instagram.com/neosalud" class="input-config">
                                </div>
                                <div class="form-grupo">
                                    <label>Twitter</label>
                                    <input type="url" value="https://twitter.com/neosalud" class="input-config">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </asp:Content>