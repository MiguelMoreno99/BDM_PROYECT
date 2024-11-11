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

            <!-- Curso 1 -->
            <a href="curso_pyton.html" class="curso-link">
                <div class="curso-item">
                    <img src="../assets/cursos/img/PythonLogo.png" alt="Curso 1">
                    <h3>Curso de Programación en Python</h3>
                    <p>Aprende las bases de la programación con Python, uno de los lenguajes más populares en el mundo.
                    </p>
                </div>
            </a>

            <!-- Curso 2 -->
            <a href="curso_pyton.html" class="curso-link">
                <div class="curso-item">
                    <img src="../assets/cursos/img/DesWeb.png" alt="Curso 2">
                    <h3>Curso de Desarrollo Web</h3>
                    <p>Domina HTML, CSS y JavaScript para crear sitios web dinámicos y atractivos.</p>
                </div>
            </a>

            <!-- Curso 3 -->
            <a href="curso_pyton.html" class="curso-link">
                <div class="curso-item">
                    <img src="../assets/cursos/img/DisGraf.png" alt="Curso 3">
                    <h3>Curso de Diseño Gráfico</h3>
                    <p>Desarrolla habilidades para diseñar logotipos, folletos y material visual con herramientas
                        profesionales.</p>
                </div>
            </a>

            <!-- Curso 5 -->
            <a href="curso_pyton.html" class="curso-link">
                <div class="curso-item">
                    <img src="../assets/cursos/img/IA.png" alt="Curso 5">
                    <h3>Curso de Inteligencia Artificial</h3>
                    <p>Aprende a desarrollar proyectos de IA y machine learning con técnicas avanzadas.</p>
                </div>
            </a>

            <!-- Curso 6 -->
            <a href="curso_pyton.html" class="curso-link">
                <div class="curso-item">
                    <img src="../assets/cursos/img/DataBase.png" alt="Curso 6">
                    <h3>Curso de Bases de Datos</h3>
                    <p>Comprende los fundamentos de las bases de datos SQL y NoSQL para gestionar grandes volúmenes de
                        datos.</p>
                </div>
            </a>

            <!-- Curso 7 -->
            <a href="curso_pyton.html" class="curso-link">
                <div class="curso-item">
                    <img src="../assets/cursos/img/CiberSeg.png" alt="Curso 7">
                    <h3>Curso de Ciberseguridad</h3>
                    <p>Protege sistemas y redes de ciberataques y aprende las mejores prácticas en seguridad
                        informática.
                    </p>
                </div>
            </a>

            <!-- Curso 8 -->
            <a href="curso_pyton.html" class="curso-link">
                <div class="curso-item">
                    <img src="../assets/cursos/img/Apps.png" alt="Curso 8">
                    <h3>Curso de Desarrollo de Apps Móviles</h3>
                    <p>Crea aplicaciones móviles para Android e iOS utilizando lenguajes y frameworks populares.</p>
                </div>
            </a>

            <!-- Curso 9 -->
            <a href="curso_pyton.html" class="curso-link">
                <div class="curso-item">
                    <img src="../assets/cursos/img/BlockChain.png" alt="Curso 9">
                    <h3>Curso de Blockchain</h3>
                    <p>Descubre cómo funcionan las tecnologías detrás de las criptomonedas y las aplicaciones de
                        blockchain.
                    </p>
                </div>
            </a>

        </div>
    </main>

    <!-- Footer -->
    <div id="footer-container"></div>

    <script src="../JS/templates.js"></script>
    <script src="../JS/Categoria_detalle.js"></script>
</body>

</html>