<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="agregarUsuarioPac.aspx.cs" Inherits="ClinicaWeb.agregarUsuarioPac" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de Usuario - NeoSalud</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <header class="encabezado">
        <div class="logo">
            <i class="fas fa-heartbeat"></i>
            <h1>NeoSalud</h1>
        </div>
    </header>

    <div class="contenedor">
        <div class="contenedor-login">
            <div class="contenedor-imagen">
                <img src="https://img.freepik.com/free-vector/medical-doctor-with-stethoscope-hands-hospital-background_1423-1.jpg" alt="Imagen médica" class="imagen-login">
                <div class="superposicion-imagen">
                    <h2>¡Regístrate en NeoSalud!</h2>
                    <p>Únete a nuestra comunidad de salud</p>
                </div>
            </div>
            <div class="contenedor-formulario">
                <div class="encabezado-formulario">
                    <i class="fas fa-user-plus"></i>
                    <h1>Registro de Usuario</h1>
                </div>
                <form class="formulario-login" runat="server">
                    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                    
                    <div class="grupo-formulario">
                        <label for="txtUsername">
                            <i class="fas fa-user"></i>
                            Usuario
                        </label>
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-input" required="required" placeholder="Ingresa tu usuario"></asp:TextBox>
                    </div>
                    <div class="grupo-formulario">
                        <label for="txtPassword">
                            <i class="fas fa-lock"></i>
                            Contraseña
                        </label>
                        <div class="input-group">
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-input" required="required" placeholder="Ingresa tu contraseña"></asp:TextBox>
                            <button class="btn btn-outline-secondary" type="button" onclick="togglePassword()" tabindex="-1">
                                <i class="fa fa-eye" id="toggleIcon"></i>
                            </button>
                        </div>
                    </div>
                    <div class="grupo-formulario">
                        <label for="txtConfirmPassword">
                            <i class="fas fa-lock"></i>
                            Confirmar Contraseña
                        </label>
                        <div class="input-group">
                            <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-input" required="required" placeholder="Confirma tu contraseña"></asp:TextBox>
                            <button class="btn btn-outline-secondary" type="button" onclick="toggleConfirmPassword()" tabindex="-1">
                                <i class="fa fa-eye" id="toggleConfirmIcon"></i>
                            </button>
                        </div>
                    </div>
                    <asp:Button ID="btnSiguiente" runat="server" Text="Siguiente" CssClass="boton-login" OnClick="btnSiguiente_Click" />
                    <div class="opciones-formulario">
                        <a href="InicioSesion.aspx" class="olvidaste-contraseña">
                            <i class="fas fa-arrow-left"></i> Volver al inicio de sesión
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <footer class="pie-pagina">
        <div class="contenido-pie">
            <div class="seccion-pie">
                <h3>NeoSalud</h3>
                <p>Tu salud es nuestra prioridad</p>
            </div>
            <div class="seccion-pie">
                <h3>Contacto</h3>
                <p><i class="fas fa-phone"></i> (51) 962095409</p>
                <p><i class="fas fa-envelope"></i> info@neosalud.com</p>
            </div>
        </div>
        <div class="pie-inferior">
            <p>&copy; 2025 NeoSalud. Todos los derechos reservados.</p>
        </div>
    </footer>

    <script type="text/javascript">
        function togglePassword() {
            var passwordInput = document.getElementById('<%= txtPassword.ClientID %>');
            var icon = document.getElementById("toggleIcon");
            if (passwordInput.type === "password") {
                passwordInput.type = "text";
                icon.classList.remove("fa-eye");
                icon.classList.add("fa-eye-slash");
            } else {
                passwordInput.type = "password";
                icon.classList.remove("fa-eye-slash");
                icon.classList.add("fa-eye");
            }
        }

        function toggleConfirmPassword() {
            var passwordInput = document.getElementById('<%= txtConfirmPassword.ClientID %>');
            var icon = document.getElementById("toggleConfirmIcon");
            if (passwordInput.type === "password") {
                passwordInput.type = "text";
                icon.classList.remove("fa-eye");
                icon.classList.add("fa-eye-slash");
            } else {
                passwordInput.type = "password";
                icon.classList.remove("fa-eye-slash");
                icon.classList.add("fa-eye");
            }
        }
    </script>
</body>
</html>