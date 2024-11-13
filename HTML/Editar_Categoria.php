<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Crear Nivel</title>
  <link rel="stylesheet" href="../CSS/GENERAL/general_styles.css">
  <link rel="stylesheet" href="../CSS/GENERAL/header.css">
  <link rel="stylesheet" href="../CSS/GENERAL/footer.css">
  <link rel="stylesheet" href="../CSS/crear_nivel.css">
</head>

<body>
  <!-- Header -->
  <div id="header-container"></div>

  <!-- Contenido de Gestion Admin -->
  <section class="seccion-curso">

    <?php
    require_once '../.Controlador/Categoria.php';
    $categoria = $controller->getCategoryInfo();
    include '../.Vista/Editar_categoria.php';
    ?>

  </section>

  <!-- Footer -->
  <div id="footer-container"></div>

  <script>
    function loadFile(event) {
      var output = document.getElementById('CategoryPreview');
      output.src = URL.createObjectURL(event.target.files[0]);
      output.onload = function() {
        URL.revokeObjectURL(output.src); // Libera el objeto URL
      };
    }
  </script>

  <script src="../JS/editar_categoria.js"></script>
  <script src="../JS/templates.js"></script>

</body>

</html>