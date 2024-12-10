<?php
require_once '../.Controlador/Curso.php';

$controller = new CourseController($config);

// Obtener información del curso y comentarios
$courses = $controller->miscursos();
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mis Cursos</title>
    <link rel="stylesheet" href="../CSS/GENERAL/general_styles.css">
    <link rel="stylesheet" href="../CSS/GENERAL/header.css">
    <link rel="stylesheet" href="../CSS/GENERAL/footer.css">
    <link rel="stylesheet" href="../CSS/MisCursos.css">
</head>

<body>
    <div id="header-container"></div>
    <h1 id="titulo">MIS CURSOS</h1>

    <div class="main-cursos">
        <?php foreach ($courses as $course): ?>
            <div class="seccion-curso">
                <img src="data:image/jpeg;base64,<?= base64_encode($course['imagen_curso']) ?>" alt="imagen del curso">
                <div class="titulo-curso">
                    <h1><?= htmlspecialchars($course['titulo_curso']) ?></h1>
                </div>
                <br><br>
                <div class="progreso-curso">
                    <h2>Progreso</h2>
                    <br>
                    <progress value="<?= htmlspecialchars($course['porcentaje_avance_curso']) ?>" max="100"></progress>
                </div>
                <br><br>

                <form id="profileForm" method="POST" action="../.Controlador/Curso.php">
                    <input type="hidden" name="accion" value="ActualizarUltimoIngreso">
                    <input type="hidden" name="id_inscripcion" value="<?= htmlspecialchars($course['id_inscripcion']) ?>">
                    <input type="hidden" name="Titulo" value="<?= htmlspecialchars($course['titulo_curso']) ?>">
                    <button type="submit" id="entrar" class="boton">Entrar</button>
                </form>

            </div>
        <?php endforeach; ?>
    </div>

    <div id="footer-container"></div>

    <script src="../JS/templates.js"></script>
</body>

</html>