<?php
session_start();

$usuario = $_SESSION['usuario'];
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mensajes Directos</title>
    <link rel="stylesheet" href="../CSS/GENERAL/general_styles.css">
    <link rel="stylesheet" href="../CSS/GENERAL/header.css">
    <link rel="stylesheet" href="../CSS/GENERAL/footer.css">
    <link rel="stylesheet" href="../CSS/dms.css">
</head>

<body>
    <!-- Header -->
    <div id="header-container"></div>

    <div class="dm-container">
        <!-- DMS abiertos -->
        <div class="sidebar">
            <h2>Chats</h2>

            <!-- Formulario para buscar usuarios -->
            <form id="profileForm" method="POST" enctype="multipart/form-data" action="../.Controlador/Usuario.php">
                <input type="hidden" name="accion" value="Buscar_usuario_chat">
                <div class="search-container">
                    <input type="text" id="nombre_usuario" name="nombre_usuario" placeholder="Buscar usuario">
                    <button type="submit" class="btn-search">Buscar</button>
                </div>
            </form>

            <!-- Resultados de búsqueda -->
            <?php
            if (isset($_SESSION['chat_search_results']) && !empty($_SESSION['chat_search_results'])) {
                echo "<ul class='chat-list'>";
                foreach ($_SESSION['chat_search_results'] as $usuario) {
                    echo "<li class='chat-item' data-id='{$usuario['id_usuario']}' data-name='{$usuario['nombre_usuario']} {$usuario['apellido_paterno']} {$usuario['apellido_materno']}'>
                            {$usuario['nombre_usuario']} {$usuario['apellido_paterno']} {$usuario['apellido_materno']}
                          </li>";
                }
                echo "</ul>";
            } else {
                echo "<p>No se encontraron resultados. Intente con otro nombre.</p>";
            }
            ?>

        </div>

        <!-- Ventana de conversación -->
        <div class="chat-window">
            <div class="chat-header">
                <!-- Aquí se actualizará dinámicamente el usuario seleccionado -->
                <h3>Usuario 1</h3>
            </div>

            <div class="chat-messages">
                <!-- Mensajes de ejemplo -->
                <div class="message received">Ejemplo 1</div>
            </div>

            <!-- Entrada de mensaje -->
            <div class="message-input">
                <input type="text" placeholder="Escribe un mensaje..." id="message-box">
                <button id="send-btn">Enviar</button>
            </div>
        </div>

    </div>

    <!-- Footer -->
    <div id="footer-container"></div>

    <!-- Script para actualizar el encabezado dinámicamente y cargar los mensajes -->
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const chatItems = document.querySelectorAll('.chat-item');
            const chatHeader = document.querySelector('.chat-header h3');
            const chatMessages = document.querySelector('.chat-messages');
            const sendButton = document.getElementById('send-btn');
            const messageBox = document.getElementById('message-box');

            let currentUserId = null; // Usuario receptor
            const senderUserId = <?php echo $_SESSION['usuario']['id_usuario']; ?>; // Usuario que inició sesión (PHP)

            // Evento de clic en cada usuario
            chatItems.forEach(item => {
                item.addEventListener('click', () => {
                    const userId = item.getAttribute('data-id');
                    const userName = item.getAttribute('data-name');

                    // Actualiza el encabezado del chat
                    chatHeader.textContent = `${userName}`;
                    currentUserId = userId;

                    // Cargar los mensajes anteriores
                    fetch('../.Controlador/Usuario.php', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded'
                            },
                            body: `accion=Obtener_mensajes_chat&id_usuario2=${userId}`,
                        })
                        .then(response => response.json())
                        .then(data => {
                            chatMessages.innerHTML = ''; // Limpiar mensajes previos

                            if (data.error) {
                                chatMessages.innerHTML = `<div class="message error">${data.error}</div>`;
                            } else {
                                data.forEach(mensaje => {
                                    const messageDiv = document.createElement('div');
                                    messageDiv.classList.add('message', mensaje.id_usuario1_mensaje == senderUserId ? 'sent' : 'received');

                                    const messageText = document.createElement('span');
                                    messageText.classList.add('message-text');
                                    messageText.textContent = mensaje.texto_mensaje;

                                    const messageDate = document.createElement('span');
                                    messageDate.classList.add('message-date');
                                    const date = new Date(mensaje.fecha_creacion_mensaje);
                                    messageDate.textContent = `${date.getDate()}/${date.getMonth() + 1}/${date.getFullYear()} ${date.getHours()}:${date.getMinutes()}`;

                                    messageDiv.appendChild(messageText);
                                    messageDiv.appendChild(messageDate);
                                    chatMessages.appendChild(messageDiv);
                                });
                            }
                        })
                        .catch(error => {
                            chatMessages.innerHTML = `<div class="message error">Error al cargar mensajes.</div>`;
                            console.error('Error:', error);
                        });
                });
            });

            // Enviar mensaje
            sendButton.addEventListener('click', () => {
                const messageContent = messageBox.value.trim();

                if (messageContent && currentUserId) {
                    fetch('../.Controlador/Usuario.php', {
                            method: 'POST',
                            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                            body: `accion=insertarMensaje&id_usuario2=${currentUserId}&texto_mensaje=${encodeURIComponent(messageContent)}`,
                        })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                const messageDiv = document.createElement('div');
                                messageDiv.classList.add('message', 'sent');

                                const messageText = document.createElement('span');
                                messageText.classList.add('message-text');
                                messageText.textContent = messageContent;

                                const messageDate = document.createElement('span');
                                messageDate.classList.add('message-date');
                                const date = new Date();
                                messageDate.textContent = `${date.getDate()}/${date.getMonth() + 1}/${date.getFullYear()} ${date.getHours()}:${date.getMinutes()}`;

                                messageDiv.appendChild(messageText);
                                messageDiv.appendChild(messageDate);
                                chatMessages.appendChild(messageDiv);

                                messageBox.value = ''; // Limpiar el cuadro de texto
                            } else if (data.error) {
                                alert(data.error);
                            }
                        })
                        .catch(error => console.error('Error:', error));
                } else {
                    alert('Escriba un mensaje antes de enviar.');
                }
            });
        });
    </script>

    <!-- Carga de plantillas para header y footer -->
    <script src="../JS/templates.js"></script>
</body>

</html>