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

    <?php
            require_once '../.Controlador/Curso.php';
            $controller->miscursos();
    ?>

    </div>

  <div id="footer-container"></div>

    <script src="../JS/templates.js"></script>
    
</body>

</html>