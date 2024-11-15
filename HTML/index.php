<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Página Principal</title>
    <link rel="stylesheet" href="../CSS/GENERAL/general_styles.css">
    <link rel="stylesheet" href="../CSS/GENERAL/header.css">
    <link rel="stylesheet" href="../CSS/GENERAL/footer.css">
    <link rel="stylesheet" href="../CSS/index.css">
</head>

<body>
    <!-- Header -->
    <div id="header-container"></div>

    <br>

    <h1>Categorias</h1>
    <!-- Contenedor de Cursos -->
    <main class="cursos-contenedor">

        <br>

        <div class="cursos-lista">
            <?php
            require_once '../.Controlador/Categoria.php';
            $controller->showCategorys();
            ?>
        </div>
    </main>

    <br>
    <h1>Cursos</h1>
    <br>

    <!-- Contenedor de Cursos -->
    <main class="cursos-contenedor">
        <div class="cursos-lista">
            <?php
            require_once '../.Controlador/Curso.php';
            $controller->showCourses();
            ?>
        </div>
    </main>

    <div id="footer-container"></div>

    <script src="../JS/templates.js"></script>
</body>

</html>