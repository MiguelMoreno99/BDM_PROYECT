<?php
session_start();

$usuario = $_SESSION['usuario'];
?>


<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Buscador Cursos</title>
    <link rel="stylesheet" href="../CSS/GENERAL/general_styles.css">
    <link rel="stylesheet" href="../CSS/GENERAL/header.css">
    <link rel="stylesheet" href="../CSS/GENERAL/footer.css">
    <link rel="stylesheet" href="../CSS/busqueda.css">
</head>

<body>

    <!-- Header -->
    <div id="header-container"></div>

    <div class="container">
        <div class="search-container">
            <h1>Búsqueda Avanzada de Cursos: </h1>

            <form action="../.Controlador/BUsqueda.php" method="POST" class="filtros">
                <input type="hidden" name="accion" value="Getbusqueda">
                <div class="search-box">
                    <div class="input-box-text">
                        <input type="text" placeholder="Buscar Curso..." id="search-input" name="Busqueda_curso">
                    </div>

                    <div class="input-box-button">
                        <button type="" class="btn">Buscar Cursos</button>
                    </div>
                </div>
                <div class="dropdowns">
                    <label for="categories">Filtrar por Categoria:</label>
                    <input type="text" name="Busqueda_categoria" placeholder="Buscar_categoria">

                    <label for="user-order">Filtar por Creador:</label>
                    <input type="text" name="Busqueda_creador" placeholder="Buscar_creador">

                    <div class="date-range">
                        <label for="start-date">Fecha de Creación Desde:
                        </label>
                        <input type="date" id="start-date" name="fecha_inicio">

                        <label for="end-date">Hasta: </label>
                        <input type="date" id="end-date" name="fecha_fin">
                    </div>
                </div>

                <div class="results-container">
                    <?php
                    if (!empty($_SESSION['busqueda_avanzda'])) {
                        echo "<div class='curso-grid'>";
                        foreach ($_SESSION['busqueda_avanzda'] as $curso) {
                            $imagen = base64_encode($curso['Imagen']);
                            $titulo = htmlspecialchars($curso['Titulo_Curso']);
                            $descripcion = htmlspecialchars($curso['Descripcion']);
                            $categoria = htmlspecialchars($curso['Nombre_Categoria']);
                            $instructor = htmlspecialchars($curso['Nombre_Instructor']);
                            $niveles = htmlspecialchars($curso['Niveles']);
                            $precio = htmlspecialchars($curso['Precio']);

                            echo "
                <a href='curso_detalle.php?titulo=" . urlencode($titulo) . "' class='curso-link'>
                    <div class='curso-item'>
                        <img src='data:image/jpeg;base64," . $imagen . "' alt='Imagen del curso' class='curso-img'>
                        <div class='curso-info'>
                            <h3>$titulo</h3>
                            <p><strong>Categoría:</strong> $categoria</p>
                            <p><strong>Instructor:</strong> $instructor</p>
                            <p><strong>Precio:</strong> $$precio</p>
                            <p class='curso-descripcion'>$descripcion</p>
                        </div>
                    </div>
                </a>";
                        }
                        echo "</div>";
                    } else {
                        echo "<p class='no-results'>No se encontraron resultados para los filtros aplicados.</p>";
                    }
                    ?>
                </div>


        </div>
    </div>

    <!-- Footer -->
    <div id="footer-container"></div>

    <script src="../JS/templates.js"></script>

</body>

</html>