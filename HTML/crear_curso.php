<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Crear Curso</title>
  <link rel="stylesheet" href="../CSS/GENERAL/general_styles.css">
  <link rel="stylesheet" href="../CSS/GENERAL/header.css">
  <link rel="stylesheet" href="../CSS/GENERAL/footer.css">
  <link rel="stylesheet" href="../CSS/crear_curso.css">
</head>

<body>
  <!-- Header -->
  <div id="header-container"></div>

  <!-- Contenido de Gestion Admin -->
  <section class="seccion-curso">
    <br>
    <br>

    <h1>Sección de Creación de Curso</h1>

    <br>
    <br>

    <form id="crear-curso-form" class="crear-curso-form">
      <!-- Nombre del curso -->
      <div class="form-group">
        <label for="titulo-curso">Nombre del curso:</label>
        <input type="text" id="titulo-curso" name="titulo-curso" placeholder="Escribe el nombre del curso">
      </div>

      <!-- Descripción del curso -->
      <div class="form-group">
        <label for="descripcion-curso">Descripción del curso:</label>
        <textarea id="descripcion-curso" name="descripcion-curso" placeholder="Escribe una descripción general del curso" rows="4"></textarea>
      </div>

      <!-- Imagen del curso -->
      <div class="form-group">
        <label for="imagen-curso">Imagen del curso:</label>
        <img class="CoursePreview" id="CoursePreview" src="../assets/images/lupa.webp" alt="Foto de Curso">
        <input type="file" id="Foto" name="imagen_curso" accept="image/*" onchange="loadFile(event)">
      </div>

      <div class="form-group">
        <label for="Categoria">Categoria</label>
        <select id='Categoria' name='Categoria'>
          <?php
          require_once '../.Controlador/Categoria.php';
          $controller->showInSelectCategorys();
          ?>
        </select>
      </div>

      <!-- Tipo de precio del curso (Select con opciones) -->
      <div class="form-group">
        <label for="tipo-precio">¿Cómo se manejará el costo del curso?</label>
        <select id="tipo-precio" name="tipo-precio">
          <option value=0>Curso completo gratis</option>
          <option value=1>Precio por curso completo</option>
          <option value=2>Precio por cada nivel</option>
        </select>
      </div>

      <!-- Costo del curso completo o por nivel (se mostrarán dinámicamente según la opción seleccionada) -->
      <div class="form-group" id="precio-completo-group" style="display: none;">
        <label for="costo-curso">Costo del curso completo ($):</label>
        <input type="number" id="costo-curso" name="costo-curso" placeholder="Costo total del curso">
      </div>

      <div class="form-group" id="precio-nivel-group" style="display: none;">
        <label for="niveles-curso">Cantidad de niveles:</label>
        <input type="number" id="niveles-curso" name="niveles-curso" placeholder="Número de niveles">
      </div>

      <div class="form-group" id="costo-nivel-group" style="display: none;">
        <label for="costo-nivel">Costo por nivel ($):</label>
        <input type="number" id="costo-nivel" name="costo-nivel" placeholder="Costo por cada nivel">
      </div>

      <!-- Aquí se insertarán dinámicamente los niveles -->
      <div id="contenedor-niveles"></div>

      <div class="acciones">
        <button type="button" class="btn-agregar-seccion" onclick="agregarNivel()">Agregar nivel</button>
      </div>

      <br>
      <br>
      <br>
      <br>

      <!-- Botón de envío -->
      <div class="form-group">
        <button type="submit" class="btn-crear-curso">Crear Curso</button>
      </div>
    </form>
  </section>

  <!-- Footer -->
  <div id="footer-container"></div>

  <script>
    function loadFile(event) {
      var output = document.getElementById('CoursePreview');
      output.src = URL.createObjectURL(event.target.files[0]);
      output.onload = function() {
        URL.revokeObjectURL(output.src); // Libera el objeto URL
      };
    }
  </script>

  <script src="../JS/templates.js"></script>
  <script src="../JS/Crear_curso_validacion.js"></script>
  <script src="../JS/Crear_curso.js"></script>

</body>

</html>