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

    <?php
    require_once '../.Controlador/Curso.php';
    $controller->misniveles();
    ?>

    <div id="footer-container"></div>
    <script src="../JS/templates.js"></script>
</body>

</html>