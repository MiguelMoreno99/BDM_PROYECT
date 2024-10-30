<?php
session_start();

// Destruye todas las sesiones
session_unset();
session_destroy();

// Redirige al formulario de inicio de sesión
header("Location: ../HTML/inicio_sesion.html");
exit();
?>

