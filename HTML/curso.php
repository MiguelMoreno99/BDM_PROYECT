<?php
session_start();

$usuario = $_SESSION['usuario'];
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CursoActual</title>
    <script src="https://www.youtube.com/iframe_api"></script>
    <link rel="stylesheet" href="../CSS/GENERAL/general_styles.css">
    <link rel="stylesheet" href="../CSS/GENERAL/header.css">
    <link rel="stylesheet" href="../CSS/GENERAL/footer.css">
    <link rel="stylesheet" href="../CSS/curso.css">
</head>

<body>
    <div id="header-container"></div>
    <div class="main-curso">
        <div class="titulo-curso">
            <h1>TITULO DE CURSO</h1>
        </div>
        <div class="nivel-curso">
            <h1>Nivel 1</h1>
            <h2>Titulo de nivel</h2>
            <br>
            <p>Descripcion del nivel.</p>
            <br>
            <br>
            <div class="video-curso">
                <h2>Titulo de video</h2>
                <iframe id="youtube-video" width="560" height="315"
                    src="https://www.youtube.com/embed/d7toLPn_slA?enablejsapi=1"
                    title="YouTube video player"
                    frameborder="0"
                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                    allowfullscreen>
                </iframe>
                <br>
            </div>
            <br>
            <div class="recursos-curso">
                <h2>Recursos Nivel 1</h2>
                <br>
                <!-- Enlace con descarga automática -->
                <p>PDF: <a href="https://drive.google.com/uc?export=download&id=1b0qyt-PEpuaeVk61BvYv0QRoL18ojTMx" download="Nivel1-Recursos.pdf">Descargar PDF</a></p>
                <br>
                <!-- Enlace de imagen -->
                <p>Imagen adjunta: <a href="ejemplo-para-ejercicios.jpg" download>ejemplo para ejercicios.jpg</a></p>
                <br>
                <!-- Enlace externo -->
                <p>Link a pagina externa: <a href="https://www.EstaPaginaNoExiste.com" target="_blank">www.EstaPaginaNoExiste.com</a></p>
            </div>
            <br>
            <br>
            <button type="submit" class="btn_enviar">Entrar</button>
        </div>
        <div class="nivel-curso">
            <h1>Nivel 2</h1>
            <h2>Titulo de nivel</h2>
            <br>
            <p>Descripcion del nivel.</p>
            <br>
            <br>
            <div class="video-curso">
                <h2>Titulo de video</h2>
                <iframe id="youtube-video" width="560" height="315"
                    src="https://www.youtube.com/embed/d7toLPn_slA?enablejsapi=1"
                    title="YouTube video player"
                    frameborder="0"
                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                    allowfullscreen>
                </iframe>
                <br>
            </div>
            <br>
            <div class="recursos-curso">
                <h2>Recursos Nivel 2</h2>
                <br>
                <p>PDF: <a href="">ejercicios nivel 2.pdf</a></p>
                <br>
                <p>Imagen adjunta: <a href="">ejemplo para ejercicios.jpg</a></p>
                <br>
                <p>Link a pagina externa: <a href="">www.EstaPaginaNoExiste.com</a></p>
            </div>
            <br>
            <br>
            <button type="submit" class="btn_enviar">Entrar.</button>
        </div>
        <div class="nivel-curso">
            <h1>Nivel 3</h1>
            <h2>Titulo de nivel</h2>
            <br>
            <p>Descripcion del nivel.</p>
            <br>
            <br>
            <div class="video-curso">
                <h2>Titulo de video</h2>
                <iframe id="youtube-video" width="560" height="315"
                    src="https://www.youtube.com/embed/d7toLPn_slA?enablejsapi=1"
                    title="YouTube video player"
                    frameborder="0"
                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                    allowfullscreen>
                </iframe>
                <br>
            </div>
            <br>
            <div class="recursos-curso">
                <h2>Recursos Nivel 3</h2>
                <br>
                <p>PDF: <a href="">ejercicios nivel 3.pdf</a></p>
                <br>
                <p>Imagen adjunta: <a href="">ejemplo para ejercicios.jpg</a></p>
                <br>
                <p>Link a pagina externa: <a href="">www.EstaPaginaNoExiste.com</a></p>
            </div>
            <br>
            <br>
            <button type="submit" class="btn_enviar">Entrar.</button>
        </div>
        <div class="nivel-curso">
            <h1>Nivel 4</h1>
            <h2>Titulo de nivel</h2>
            <br>
            <p>Descripcion del nivel.</p>
            <br>
            <br>
            <div class="video-curso">
                <h2>Titulo de video</h2>
                <iframe id="youtube-video" width="560" height="315"
                    src="https://youtu.be/Hgck73_puuM?si=v8mKjU8Gauttmib2"
                    title="YouTube video player"
                    frameborder="0"
                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                    allowfullscreen>
                </iframe>
                <br>
            </div>
            <br>
            <div class="recursos-curso">
                <h2>Recursos Nivel 4</h2>
                <br>
                <p>PDF: <a href="">ejercicios nivel 4.pdf</a></p>
                <br>
                <p>Imagen adjunta: <a href="">ejemplo para ejercicios.jpg</a></p>
                <br>
                <p>Link a pagina externa: <a href="">www.EstaPaginaNoExiste.com</a></p>
            </div>
            <br>
            <br>
            <button type="submit" class="btn_enviar">Entrar.</button>
        </div>
    </div>
    <div id="footer-container"></div>

    <script>
        let player;

        // Función que inicializa el reproductor de YouTube
        function onYouTubeIframeAPIReady() {
            player = new YT.Player('youtube-video', {
                events: {
                    'onStateChange': onPlayerStateChange
                }
            });
        }

        // Detecta el cambio de estado del video
        function onPlayerStateChange(event) {
            if (event.data === YT.PlayerState.ENDED) {
                document.getElementById('video-completado').checked = true;
            }
        }
    </script>

    <script src="../JS/templates.js"></script>
</body>

</html>