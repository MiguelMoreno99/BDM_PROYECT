<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalle de Categoria</title>
    <link rel="stylesheet" href="../CSS/GENERAL/general_styles.css">
    <link rel="stylesheet" href="../CSS/GENERAL/header.css">
    <link rel="stylesheet" href="../CSS/GENERAL/footer.css">
    <link rel="stylesheet" href="../CSS/Categoria_detalle.css">
</head>

<body>
    <!-- Header -->
    <div id="header-container"></div>

    <!-- Contenedor de Cursos -->
    <main class="cursos-contenedor">

        <div class="curso-detalle-contenido">
            <div class="curso-info">
                <?php
                require_once '../.Controlador/Categoria.php';
                $controller->showCategory();
                ?>
            </div>
        </div>

        <br>
        <br>
        <br>
        <br>

        <div class="cursos-lista">
            <?php
            require_once '../.Controlador/Curso.php';
            $controller->showCoursesByCategory();
            ?>
        </div>
    </main>

    <!-- Footer -->
    <div id="footer-container"></div>

    <script src="../JS/templates.js"></script>
    <script src="../JS/Categoria_detalle.js"></script>
</body>

</html>