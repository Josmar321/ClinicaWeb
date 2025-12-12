<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InicioSesion.aspx.cs" Inherits="ClinicaWeb.InicioSesion" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio de Sesión - NeoSalud</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
                    <h2>¡Bienvenido a NeoSalud!</h2>
                    <p>Gestiona tus citas de manera rápida y segura</p>
                </div>
            </div>
            <div class="contenedor-formulario">
                <div class="encabezado-formulario">
                    <i class="fas fa-user-circle"></i>
                    <h1>Iniciar Sesión</h1>
                </div>
                <form class="formulario-login" runat="server">
                    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                    
                    <div class="grupo-formulario">
                        <label for="usuario">
                            <i class="fas fa-user"></i>
                            Usuario
                        </label>
                        <input type="text" id="usuario" name="usuario" runat="server" required placeholder="Ingresa tu usuario">
                    </div>
                    <div class="grupo-formulario">
                        <label for="contraseña">
                            <i class="fas fa-lock"></i>
                            Contraseña
                        </label>
                        <input type="password" id="contraseña" name="contraseña" runat="server" required placeholder="Ingresa tu contraseña">
                    </div>
                    <div class="opciones-formulario">
                        <label class="recordarme">
                            <input type="checkbox" name="recordarme" runat="server">
                            Recordarme
                        </label>
                        <a href="agregarUsuarioPac.aspx" class="olvidaste-contraseña">Registrese</a>
                    </div>
                    <asp:Button ID="btnLogin" runat="server" Text="Ingresar" CssClass="boton-login" OnClick="btnLogin_Click" />
                    
                    <!-- Mensaje de registro exitoso -->
                    <div id="mensajeRegistroExitoso" class="mensaje-exitoso" style="display: none;">
                        <i class="fas fa-check-circle"></i>
                        <span>¡Registro completado exitosamente! Ya puede iniciar sesión con sus credenciales.</span>
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
        // Mostrar mensaje de registro exitoso si viene de registro
        window.onload = function() {
            var urlParams = new URLSearchParams(window.location.search);
            if (urlParams.get('registro') === 'exitoso') {
                var mensaje = document.getElementById('mensajeRegistroExitoso');
                if (mensaje) {
                    mensaje.style.display = 'block';
                    setTimeout(function() {
                        mensaje.style.display = 'none';
                    }, 5000);
                }
            }
        };
    </script>
</body>
</html>