<?php
require_once '../.Controlador/Curso.php';

$controller = new CourseController($config);

$curso = $controller->ShowCursoInscripcion();
$niveles = $controller->misniveles();
$inscripcion = $controller->porcentajeInscripcion();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CursoActual</title>
    <link rel="stylesheet" href="../CSS/GENERAL/general_styles.css">
    <link rel="stylesheet" href="../CSS/GENERAL/header.css">
    <link rel="stylesheet" href="../CSS/GENERAL/footer.css">
    <link rel="stylesheet" href="../CSS/curso.css">
</head>
<body>
    <div id="header-container"></div>
    <div class="main-curso">

    <div class="titulo-curso">
        <h1><?= htmlspecialchars($curso['titulo_curso']) ?></h1>
    </div>

    <div class="curso">
       <h2>Descripción de curso:</h2>
       <br>
       <p><?= htmlspecialchars($curso['descripcion_curso']) ?></p>
       <br>
       <img src="<?= htmlspecialchars($curso['imagen_curso']) ?>" alt="Imagen del curso" class="imagen-curso">
    </div>

    <?php if (!empty($niveles)): ?>
        <?php foreach ($niveles as $index => $Niveles_inscripcion): ?>

         <?php if ($Niveles_inscripcion['Nivel_terminado'] == 0): ?>

          <form id="form-nivel-<?= $index ?>" action="../.Controlador/Curso.php" method="POST">
            <input type="hidden" name="accion" value="Nivel_completado">
            <input type="hidden" name="id_inscripcion" value="<?= htmlspecialchars($Niveles_inscripcion['id_nivel_inscripcion'] ?? '0') ?>">
            <input type="hidden" name="titulo_curso" value="<?= htmlspecialchars($curso['titulo_curso']) ?>">

            <div class="nivel-curso">
                <h2><?php echo htmlspecialchars($Niveles_inscripcion['titulo_nivel_general'] ?? '0'); ?></h2>
                <br>
                <p><?php echo htmlspecialchars($Niveles_inscripcion['informacion_nivel'] ?? '0'); ?></p>
                <br>
                <br>
                <div class="video-curso">
                  <?php
                  $link_video = $Niveles_inscripcion['link_video_nivel'] ?? '';
                  if (preg_match('/(?:youtu\.be\/|youtube\.com\/(?:watch\?v=|embed\/|v\/|shorts\/))([a-zA-Z0-9_-]+)/', $link_video, $matches)) {
                    $video_id = $matches[1];
                    $embed_url = "https://www.youtube.com/embed/" . $video_id . "?enablejsapi=1";
                  } else {
                    $embed_url = ""; // Manejo de error: enlace no válido
                  }
                  ?>
                  <iframe 
                    id="video-<?= $index ?>" 
                    class="video-curso" 
                    width="560" 
                    height="315" 
                    src="<?= htmlspecialchars($embed_url) ?>" 
                    title="YouTube video player" 
                    frameborder="0" 
                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
                    allowfullscreen>
                  </iframe>
                </div>
                <br>
                <div class="recursos-curso">
                  <img src="<?= htmlspecialchars($Niveles_inscripcion['imagen_nivel'] ?? '') ?>" alt="Imagen del nivel" class="imagen-curso">
                  <br>
                  <h2>Recursos del nivel</h2>
                  <br>
                  <p>PDF: <a href="<?= htmlspecialchars($Niveles_inscripcion['documento_nivel']) ?>" download="Documento_de_apoyo.pdf">Documento de apoyo</a></p>
                  <p>Link a página externa: <a href="<?php echo htmlspecialchars($Niveles_inscripcion['referencias_nivel'] ?? '0'); ?>"> Página de apoyo</a></p>
                </div>
                <br>
                <br>
            </div>
        </form>

         <?php elseif ($Niveles_inscripcion['Nivel_terminado'] == 1): ?>

          <div class="nivel-curso">
                <h2><?php echo htmlspecialchars($Niveles_inscripcion['titulo_nivel_general'] ?? '0'); ?></h2>
                <br>
                <p><?php echo htmlspecialchars($Niveles_inscripcion['informacion_nivel'] ?? '0'); ?></p>
                <br>
                <br>
                <div class="video-curso">
                  <?php
                  $link_video = $Niveles_inscripcion['link_video_nivel'] ?? '';
                  if (preg_match('/(?:youtu\.be\/|youtube\.com\/(?:watch\?v=|embed\/|v\/|shorts\/))([a-zA-Z0-9_-]+)/', $link_video, $matches)) {
                    $video_id = $matches[1];
                    $embed_url = "https://www.youtube.com/embed/" . $video_id . "?enablejsapi=1";
                  } else {
                    $embed_url = ""; // Manejo de error: enlace no válido
                  }
                  ?>
                  <iframe 
                    id="video-<?= $index ?>" 
                    class="video-curso" 
                    width="560" 
                    height="315" 
                    src="<?= htmlspecialchars($embed_url) ?>" 
                    title="YouTube video player" 
                    frameborder="0" 
                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
                    allowfullscreen>
                  </iframe>
                </div>
                <br>
                <div class="recursos-curso">
                  <img src="<?= htmlspecialchars($Niveles_inscripcion['imagen_nivel'] ?? '') ?>" alt="Imagen del nivel" class="imagen-curso">
                  <br>
                  <h2>Recursos del nivel</h2>
                  <br>
                  <p>PDF: <a href="<?= htmlspecialchars($Niveles_inscripcion['documento_nivel']) ?>" download="Documento_de_apoyo.pdf">Documento de apoyo</a></p>
                  <p>Link a página externa: <a href="<?php echo htmlspecialchars($Niveles_inscripcion['referencias_nivel'] ?? '0'); ?>"> Página de apoyo</a></p>
                </div>
                <br>
                <br>
            </div>

         <?php endif; ?>

        <?php endforeach; ?>
    <?php else: ?>
        <div class="nivel-curso">
            <p>No hay niveles.</p>
        </div>
    <?php endif; ?>

    <?php if ($inscripcion['inscripcion_finalizada'] == 0): ?>
    <?php elseif ($inscripcion['inscripcion_finalizada'] == 1): ?>
        <div class="Boton_diploma">
            <form action="../HTML/curso_finalizado.php" method="get">
                <input type="hidden" name="titulo" value="<?= htmlspecialchars($curso['titulo_curso']) ?>">
                <input type="submit" value="Diploma" class="btn_enviar">
            </form>
        </div>
    <?php endif; ?>

  </div>
  <div id="footer-container"></div>
  <script>
    document.addEventListener("DOMContentLoaded", () => {
      const videos = document.querySelectorAll("iframe.video-curso");

      // Cargar API de YouTube
      const tag = document.createElement('script');
      tag.src = "https://www.youtube.com/iframe_api";
      const firstScriptTag = document.getElementsByTagName('script')[0];
      firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

      window.onYouTubeIframeAPIReady = function () {
        videos.forEach((video, index) => {
          new YT.Player(video.id, {
            events: {
              onStateChange: (event) => {
                if (event.data === YT.PlayerState.ENDED) {
                  const form = document.getElementById(`form-nivel-${index}`);
                  form.submit();
                }
              }
            }
          });
        });
      };
    });
  </script>
  <script src="../JS/templates.js"></script>
</body>
</html>
