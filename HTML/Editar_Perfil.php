<?php
session_start();

$usuario = $_SESSION['usuario'];
?>

<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Gestión de Perfil</title>
  <link rel="stylesheet" href="../CSS/GENERAL/general_styles.css">
  <link rel="stylesheet" href="../CSS/GENERAL/header.css">
  <link rel="stylesheet" href="../CSS/GENERAL/footer.css">
  <link rel="stylesheet" href="../CSS/gestion_admin.css">
</head>

<body>

  <!-- Header -->
  <div id="header-container"></div>


  <section class="seccion-admin">

    <?php include '../.Vista/Editar_usuario.php'; ?>

  </section>

  <!-- Footer -->
  <div id="footer-container"></div>

  <script src="../JS/templates.js"></script>
  <script src="../JS/Gestion_admin.js"></script>
  <script src="../JS/validacion_gestion_Usuarios.js"></script>

</body>

</html>