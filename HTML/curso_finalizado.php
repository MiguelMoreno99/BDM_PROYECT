<?php
require_once '../.Controlador/Curso.php';

$controller = new CourseController($config);

$curso_finalizado = $controller->Cursofinalizado();
$curso_instructor = $controller->Cursoinstructor();
?>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Finalizaste el curso</title>
    <link rel="stylesheet" href="../CSS/GENERAL/general_styles.css">
    <link rel="stylesheet" href="../CSS/curso_finalizado.css">
    <link rel="stylesheet" href="../CSS/GENERAL/header.css">
    <link rel="stylesheet" href="../CSS/GENERAL/footer.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
</head>

<body>

    <div id="header-container"></div>
    <div class="main-div">
        <div class="mensaje">
            <br>
            <h1>¡FELICIDADES!, HAS FINALIZADO EL CURSO</h1>
        </div>
        <br>
        <div class="contenido-curso">
           <?php if (isset($curso_finalizado['error'])): ?>
                <p class="error"><?= htmlspecialchars($curso_finalizado['error']) ?></p>
           <?php else: ?>
              <img src="<?= htmlspecialchars($curso_finalizado['imagen_curso']) ?>" alt="Imagen del curso">
              <h1><?= htmlspecialchars($curso_finalizado['titulo_curso']) ?></h1>
            <?php endif; ?>
        </div>
        <br>
        <br>
        <br>
        <div class="diploma-div">
        <form action="../.Controlador/Curso.php" method="POST">
        <input type="hidden" name="accion" value="Insertar_diploma">
              <h1>Diploma</h1>
              <input type="hidden" name="id_instructor" id="id_instructor" value="<?= htmlspecialchars($curso_instructor['id_usuario']) ?>">
              <input type="hidden" name="id_estudiante" id="id_estudiante" value="<?= htmlspecialchars($_SESSION['usuario']['id_usuario'] ?? 'Usuario') ?>">
              <input type="hidden" name="id_curso" id="id_curso" value="<?= htmlspecialchars($curso_finalizado['id_curso']) ?>">
              <input type="hidden" name="titulo" value="<?= htmlspecialchars($curso_finalizado['titulo_curso'] ?? '') ?>">
              <br>
              <!-- El canvas se usa para dibujar la imagen del diploma y agregar texto -->
              <canvas id="diplomaCanvas" width="800" height="600" style="display: none;"></canvas>
              <img src="../assets/images/Diploma.png" id="diplomaImg" alt="Diploma">
              <br><br>
              <button type="submit" id="descargarDiploma" class="button">Descargar</button>
            </form>
        </div>
        <br>
        <br>
        <div class="Calificacion-div">
            <h2>Califica el Curso</h2>

            <form id="profileForm" method="POST" action="../.Controlador/Curso.php">
            <input type="hidden" name="accion" value="Insertar_comentario">
            <input type="hidden" name="titulo" value="<?= htmlspecialchars($curso_finalizado['titulo_curso'] ?? '') ?>">
    
           <div class="form-group">
              <div class="stars">
                  <input type="radio" name="star" id="star1" value="5"><label for="star1">★</label>
                  <input type="radio" name="star" id="star2" value="4"><label for="star2">★</label>
                  <input type="radio" name="star" id="star3" value="3"><label for="star3">★</label>
                  <input type="radio" name="star" id="star4" value="2"><label for="star4">★</label>
                  <input type="radio" name="star" id="star5" value="1"><label for="star5">★</label>
                </div>
            </div>
            <div class="form-group">
               <label for="comment">Comentario:</label>
                 <textarea id="comment" name="Comentario" rows="4" required></textarea>
            </div>
            <button type="submit" class="button">Enviar</button>
            <a href="index.php" class="button">Regresar</a>
            </form>
            
        </div>
    </div>
    <div id="footer-container"></div>
<script>
    document.getElementById('descargarDiploma').addEventListener('click', function () {
        const canvas = document.getElementById('diplomaCanvas');
        const ctx = canvas.getContext('2d');
        const img = document.getElementById('diplomaImg');

        // Datos dinámicos (pueden venir de PHP)
        const nombreUsuario = "<?= htmlspecialchars($_SESSION['usuario']['nombre_usuario'] ?? 'Usuario') ?>";
        const curso = "<?= htmlspecialchars($curso_finalizado['titulo_curso'] ?? 'Curso') ?>";
        const instructor = "<?= htmlspecialchars($curso_instructor['nombre_usuario']) ?? 'instructor'?>";
        const fecha = "<?= date('d/m/Y') ?>";

        // Dibujar la imagen del diploma
        img.onload = function () {
            ctx.drawImage(img, 0, 0, canvas.width, canvas.height);

            // Configuración de texto
            ctx.font = '20px Arial';
            ctx.fillStyle = '#000';
            ctx.textAlign = 'center';

            // Posicionar texto
            ctx.fillText(nombreUsuario, 400, 250); // Nombre del usuario
            ctx.fillText(curso, 400, 325); // Curso
            ctx.fillText(fecha, 570, 460); // Fecha
            ctx.fillText(instructor, 250, 460); // Fecha

            // Convertir a PDF
            const imgData = canvas.toDataURL('image/jpeg');
            const { jsPDF } = window.jspdf;
            const pdf = new jsPDF();
            pdf.addImage(imgData, 'JPEG', 0, 0, 210, 210); // Tamaño A4
            pdf.save('Diploma.pdf');
        };

        // Disparar la carga de la imagen
        img.src = img.src; // Forzar recarga de la imagen en el canvas
    });
</script>

    <script src="../JS/calificar_curso.js"></script>
    <script src="../JS/templates.js"></script>
</body>
</html>