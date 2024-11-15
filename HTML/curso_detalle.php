<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Curso de Programación en Python</title>
  <link rel="stylesheet" href="../CSS/GENERAL/general_styles.css">
  <link rel="stylesheet" href="../CSS/GENERAL/header.css">
  <link rel="stylesheet" href="../CSS/GENERAL/footer.css">
  <link rel="stylesheet" href="../CSS/curso_detalle.css">


</head>

<body>

  <!-- Modal para Confirmación de Borrado -->
  <div id="modal-borrar" class="modal">
    <div class="modal-contenido">
      <h3>¿Por qué quieres borrar este comentario?</h3>
      <textarea id="razon-borrar" placeholder="Escribe la razón aquí..."></textarea>
      <div class="modal-buttons">
        <button id="confirmar-borrar" class="btn-borrar" onclick="confirmarEliminar(this)">Borrar</button>
        <button id="cancelar-borrar" class="btn-cancelar">Cancelar</button>
      </div>
    </div>
  </div>

  <!-- Header -->
  <div id="header-container"></div>

  <!-- Contenido del Curso -->
  <main class="curso-detalle">
    <div class="curso-detalle-contenido">
      <?php
      require_once '../.Controlador/Curso.php';
      $controller->showCourse();
      ?>
    </div>

    <!-- Sección de Calificaciones y Comentarios -->
    <section class="comentarios">
      <h3>Reseñas y Calificaciones</h3>
      <div class="calificacion-general">
        <p><strong>Calificación promedio:</strong> 4.5/5 ⭐</p>
      </div>

      <div class="comentario-item">
        <p><strong>Juan Pérez:</strong></p>
        <p>"Excelente curso, aprendí mucho sobre Python. Los ejemplos fueron claros y útiles."</p>
        <p>Calificación: 5/5 ⭐</p>
        <button class="btn-borrar">Borrar</button>
      </div>

      <div class="comentario-item">
        <p><strong>María García:</strong></p>
        <p>"Muy bueno, aunque me gustaría más ejercicios prácticos."</p>
        <p>Calificación: 4/5 ⭐</p>
        <button class="btn-borrar">Borrar</button>
      </div>

      <div class="comentario-item">
        <p><strong>Carlos Sánchez:</strong></p>
        <p>"Gran curso, pero el ritmo era un poco lento para mí."</p>
        <p>Calificación: 4/5 ⭐</p>
        <button class="btn-borrar">Borrar</button>
      </div>
    </section>
  </main>

  <!-- Footer -->
  <div id="footer-container"></div>

  <script src="../JS/templates.js"></script>
  <script src="../JS/curso_detalle.js"></script>
</body>

</html>