<?php 
require_once '../.Controlador/Curso.php';

$controller = new CourseController($config);

// Obtener información del curso y comentarios
$curso_finalizado = $controller->MostrarCurso();
$comentarios = $controller->Mostrar_comentarios();
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalle del Curso</title>
    <link rel="stylesheet" href="../CSS/GENERAL/general_styles.css">
    <link rel="stylesheet" href="../CSS/GENERAL/header.css">
    <link rel="stylesheet" href="../CSS/GENERAL/footer.css">
    <link rel="stylesheet" href="../CSS/curso_detalle.css">
</head>

<body>

  <!-- Modal para Confirmación de Borrado -->
  <form action="../.Controlador/Curso.php" method="POST">
   <input type="hidden" name="accion" value="BorrarComentario">
   <div id="modal-borrar" class="modal" style="display: none;">
    <div class="modal-contenido">
        <h3>¿Por qué quieres borrar este comentario?</h3>
        <textarea id="razon-borrar" name="razon-borrar" placeholder="Escribe la razón aquí..."></textarea>
        <input type="hidden" name="comentario_id" id="comentario-id" value="">
        <div class="modal-buttons">
            <button type="submit" id="confirmar-borrar" class="btn-borrar">Borrar</button>
            <button type="button" id="cancelar-borrar" class="btn-cancelar">Cancelar</button>
        </div>
    </div>
</div>
</form>

    <!-- Header -->
    <div id="header-container"></div>

    <!-- Contenido del Curso -->
    <main class="curso-detalle">
        <div class="curso-detalle-contenido">
            <?php if (isset($curso_finalizado['error'])): ?>
                <p class="error"><?php echo htmlspecialchars($curso_finalizado['error']); ?></p>
            <?php else: ?>
                <img src="data:image/jpeg;base64,<?php echo $curso_finalizado['imagen_curso']; ?>" class="imgCurso" alt="Imagen del Curso">
                <div class="curso-info">
                    <h2 id="titulo-curso"><?php echo htmlspecialchars($curso_finalizado['titulo_curso']); ?></h2>
                    <p><strong>Total de Niveles: </strong><?php echo htmlspecialchars($curso_finalizado['niveles_curso']); ?></p>

                    <?php if ($curso_finalizado['manejo_precio_curso'] == 0): ?>
                        <p><strong>Costo del Curso Completo: </strong>Gratis!!</p>
                    <?php elseif ($curso_finalizado['manejo_precio_curso'] == 1): ?>
                        <p><strong>Costo del Curso Completo: </strong>$<?php echo htmlspecialchars($curso_finalizado['precio_curso']); ?></p>
                    <?php elseif ($curso_finalizado['manejo_precio_curso'] == 2): ?>
                        <p><strong>Costo por Nivel: </strong>Este curso se maneja por venta individual de niveles. Para más información del costo, vea los diferentes niveles.</p>
                    <?php endif; ?>

                    <p class="descripcion"><?php echo htmlspecialchars($curso_finalizado['descripcion_curso']); ?></p>

                    <?php if ($curso_finalizado['tipo_usuario'] == 1 || $curso_finalizado['tipo_usuario'] == 2): ?>
                        <a href="PagoCurso.php?titulo=<?php echo urlencode($curso_finalizado['titulo_curso']); ?>" class="btn-inscribirse">Inscribirse</a>
                    <?php elseif ($curso_finalizado['tipo_usuario'] == 2): ?>
                    <?php elseif ($curso_finalizado['tipo_usuario'] == 3): ?>

                    <?php endif; ?>
                </div>
            <?php endif; ?>
        </div>

<!-- Sección de Calificaciones y Comentarios -->
<section class="comentarios">
    <h3>Reseñas y Calificaciones</h3>

    <?php if (!empty($comentarios)): ?>
        <?php foreach ($comentarios as $comentario): ?>
            <div class="comentario-item" id="comentario-<?php echo $comentario['id_comentario']; ?>">
                <p><strong><?php echo htmlspecialchars($comentario['nombre_usuario'] ?? 'Usuario desconocido'); ?></strong></p>

                <?php if ($comentario['comentario_eliminado'] == 1): ?>
                    <p><em>Comentario eliminado</em></p>
                    <p><strong>Causa:</strong> <?php echo htmlspecialchars($comentario['causa_eliminacion_comentario'] ?? 'No especificada'); ?></p>
                <?php else: ?>
                    <p><?php echo htmlspecialchars($comentario['descripcion_comentario'] ?? 'Sin comentario'); ?></p>
                    <p>Calificación: <?php echo htmlspecialchars($comentario['calificacion_curso'] ?? 0); ?> ⭐</p>
                <?php endif; ?>

                <?php if (isset($curso_finalizado['tipo_usuario']) && $curso_finalizado['tipo_usuario'] == 3 && $comentario['comentario_eliminado'] == 0): ?>
                    <!-- Mostrar botón solo para usuarios tipo 3 -->
                    <button class="btn-borrar" data-id="<?php echo $comentario['id_comentario']; ?>">Borrar</button>
                <?php endif; ?>
            </div>
        <?php endforeach; ?>
    <?php else: ?>
        <p>No hay comentarios para este curso aún.</p>
    <?php endif; ?>
</section>

    </main>

    <!-- Footer -->
    <div id="footer-container"></div>

    <script src="../JS/templates.js"></script>
    <script src="../JS/curso_detalle.js"></script>
</body>

</html>