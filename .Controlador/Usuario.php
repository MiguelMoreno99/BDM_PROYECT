<?php

require_once '../.Modelo/ModeloUsuario.php';
session_start();

class UserController
{
    private $userModel;

    public function __construct($config)
    {
        $this->userModel = new Modelo_Usuario($config);
    }

    public function register()
    {
        // Obtener datos del formulario
        $tipo_usuario = $_POST['tipo_usuario'];

        // Convertir la imagen a BLOB
        $imagen_usuario = isset($_FILES['imagen_usuario']) && $_FILES['imagen_usuario']['error'] == 0
            ? file_get_contents($_FILES['imagen_usuario']['tmp_name'])
            : null;

        $nombre_usuario = $_POST['nombre_usuario'];
        $apellido_paterno = $_POST['apellido_paterno'];
        $apellido_materno = $_POST['apellido_materno'];
        $genero_usuario = $_POST['genero_usuario'];
        $nacimiento_usuario = $_POST['nacimiento_usuario'];
        $correo_usuario = $_POST['correo_usuario'];
        $contrasenia_usuario = $_POST['contrasenia_usuario'];

        // Verificar si el correo ya existe
        $emailExists = $this->userModel->checkEmailExists($correo_usuario);

        if ($emailExists) {
            echo "<script>alert('Ese correo ya existe, ingrese otro.'); window.history.back();</script>";
            exit();
        }
        // Registrar usuario
        $this->userModel->registerUser([
            $tipo_usuario,
            $imagen_usuario,
            $nombre_usuario,
            $apellido_paterno,
            $apellido_materno,
            $genero_usuario,
            $nacimiento_usuario,
            $correo_usuario,
            $contrasenia_usuario
        ]);

        // Redirigir al inicio de sesión
        header('Location: ../HTML/inicio_sesion.html');
        exit();
    }

    public function login()
    {
        $correo_usuario = $_POST['correo_usuario'];
        $contrasenia_usuario = $_POST['contrasenia_usuario'];
        $UsuarioAdmin = $this->userModel->checkBlockedStatus($correo_usuario, $contrasenia_usuario);
        $UsuarioBloqueado = $this->userModel->checkBlockedStatus($correo_usuario, $contrasenia_usuario);

        if ($UsuarioBloqueado && $UsuarioBloqueado['tipo_usuario'] == 3) {
            $user = $this->userModel->loginUser($correo_usuario, $contrasenia_usuario);
            if ($user) {
                $_SESSION['usuario'] = $user;
                header('Location: ../HTML/index.php');
                exit();
            } else {
                header('Location: ../HTML/inicio_sesion.html?error=credenciales_incorrectas');
            }
        } else {
            if ($UsuarioBloqueado && $UsuarioBloqueado['usuario_bloqueado'] == 1) {
                header('Location: ../HTML/inicio_sesion.html?error=usuario_bloqueado');
                exit();
            } else {
                $user2 = $this->userModel->loginUser($correo_usuario, $contrasenia_usuario);

                if ($user2) {
                    $this->userModel->resetLoginAttempts($correo_usuario, $contrasenia_usuario);
                    $_SESSION['usuario'] = $user2;
                    header('Location: ../HTML/index.php');
                } else {
                    $this->userModel->incrementLoginAttempts($correo_usuario);
                    header('Location: ../HTML/inicio_sesion.html?error=credenciales_incorrectas');
                }
                exit();
            }
        }
    }

    public function editUser()
    {
        $id_usuario = $_POST['id_usuario'];

        // Usar una imagen actual si no se sube una nueva
        $imagen_usuario = !empty($_FILES['imagen_usuario']['tmp_name'])
            ? file_get_contents($_FILES['imagen_usuario']['tmp_name'])
            : base64_decode($_POST['imagen_actual']);

        // Utilizar valores de los placeholders si no se envían nuevos datos
        $nombre_usuario = !empty($_POST['nombre_usuario']) ? $_POST['nombre_usuario'] : (isset($_POST['placeholder_nombre']) ? $_POST['placeholder_nombre'] : null);
        $apellido_paterno_usuario = !empty($_POST['apellido_paterno_usuario']) ? $_POST['apellido_paterno_usuario'] : (isset($_POST['placeholder_apellido_paterno']) ? $_POST['placeholder_apellido_paterno'] : null);
        $apellido_materno_usuario = !empty($_POST['apellido_materno_usuario']) ? $_POST['apellido_materno_usuario'] : (isset($_POST['placeholder_apellido_materno']) ? $_POST['placeholder_apellido_materno'] : null);
        $correo_usuario = !empty($_POST['correo_usuario']) ? $_POST['correo_usuario'] : (isset($_POST['placeholder_correo']) ? $_POST['placeholder_correo'] : null);
        $contrasenia_usuario = !empty($_POST['contrasenia_usuario']) ? $_POST['contrasenia_usuario'] : (isset($_POST['placeholder_contrasenia']) ? $_POST['placeholder_contrasenia'] : null);

        // Verificar que no hay campos nulos antes de realizar la actualización
        if (is_null($nombre_usuario) || is_null($apellido_paterno_usuario) || is_null($apellido_materno_usuario) || is_null($correo_usuario) || is_null($contrasenia_usuario)) {
            echo "<script>alert('Por favor, completa todos los campos requeridos.'); window.history.back();</script>";
            exit();
        }



        // Verificar si el correo ya existe
        $emailExists = $this->userModel->checkEmailExists($correo_usuario);

        if ($emailExists && $emailExists['id_usuario'] == $id_usuario) {
            // Llamar al modelo para actualizar el usuario
            $this->userModel->updateUser([
                $id_usuario,
                $imagen_usuario,
                $nombre_usuario,
                $apellido_paterno_usuario,
                $apellido_materno_usuario,
                $correo_usuario,
                $contrasenia_usuario,
            ]);

            // Actualizar la sesión con los nuevos datos del usuario
            $_SESSION['usuario']['nombre_usuario'] = $nombre_usuario;
            $_SESSION['usuario']['apellido_paterno'] = $apellido_paterno_usuario;
            $_SESSION['usuario']['apellido_materno'] = $apellido_materno_usuario;
            $_SESSION['usuario']['correo_usuario'] = $correo_usuario;
            $_SESSION['usuario']['contrasenia_usuario'] = $contrasenia_usuario;
            $_SESSION['usuario']['imagen_usuario'] = $imagen_usuario;

            echo "<script>alert('Usuario modificado.'); window.history.back();</script>";
            exit();
        } else {
            if ($emailExists) {
                echo "<script>alert('Ese correo ya existe, ingrese otro.'); window.history.back();</script>";
                exit();
            } else {
                // Llamar al modelo para actualizar el usuario
                $this->userModel->updateUser([
                    $id_usuario,
                    $imagen_usuario,
                    $nombre_usuario,
                    $apellido_paterno_usuario,
                    $apellido_materno_usuario,
                    $correo_usuario,
                    $contrasenia_usuario,
                ]);

                // Actualizar la sesión con los nuevos datos del usuario
                $_SESSION['usuario']['nombre_usuario'] = $nombre_usuario;
                $_SESSION['usuario']['apellido_paterno'] = $apellido_paterno_usuario;
                $_SESSION['usuario']['apellido_materno'] = $apellido_materno_usuario;
                $_SESSION['usuario']['correo_usuario'] = $correo_usuario;
                $_SESSION['usuario']['contrasenia_usuario'] = $contrasenia_usuario;
                $_SESSION['usuario']['imagen_usuario'] = $imagen_usuario;

                echo "<script>alert('Usuario modificado.'); window.history.back();</script>";
                exit();
            }
        }
    }

    public function Gestiondeadmin()
    {
        // Recibir filtros del formulario
        $registroUsuario = $_POST['registro_usuario'] ?? null;
        $idUsuario = $_POST['id_usuario'] ?? null;
        $nombreUsuario = $_POST['nombre_usuario'] ?? null;
        $correoUsuario = $_POST['correo_usuario'] ?? null;
        $usuario_bloqueado = $_POST['estado_usuario'] ?? null;
        $tipoUsuario = $_POST['tipo_usuario'] ?? null;

        // Convertir a entero si no es NULL
        if (!is_null($usuario_bloqueado)) {
            $usuario_bloqueado = (int)$usuario_bloqueado;
        }

        // Obtener los resultados usando el modelo
        $resultados = $this->userModel->getGestionAdmin(
            $registroUsuario,
            $idUsuario,
            $nombreUsuario,
            $correoUsuario,
            $usuario_bloqueado,
            $tipoUsuario
        );

        // Almacenar resultados en la sesión
        $_SESSION['admin_user_data'] = $resultados;

        // Redirigir a la página de gestión
        header('Location: ../HTML/gestion_admin.php');
        exit();
    }

    public function bloquearUsuario()
    {
        $id_usuario = $_POST['usuario_seleccionado'] ?? null;

        if ($id_usuario) {
            $this->userModel->BloquearUsuario($id_usuario);
            echo "<script>alert('Usuario bloqueado.'); window.location.href = '../HTML/gestion_admin.php';</script>";
            header('Location: ../HTML/gestion_admin.php');
        } else {
            echo "<script>alert('No se seleccionó ningún usuario.'); window.history.back();</script>";
        }
        exit();
    }

    public function DesbloquearUsuario()
    {
        $id_usuario = $_POST['usuario_seleccionado'] ?? null;

        if ($id_usuario) {
            $this->userModel->DesbloquearUsuario($id_usuario);
            echo "<script>alert('Usuario Desbloqueado.'); window.location.href = '../HTML/gestion_admin.php';</script>";
        } else {
            echo "<script>alert('No se seleccionó ningún usuario.'); window.history.back();</script>";
        }
        exit();
    }

    public function buscarUsuariosChat()
    {
        $terminoBusqueda = $_POST['nombre_usuario'] ?? '';
        $usuarios = $this->userModel->buscarUsuariosChat($terminoBusqueda);
        $_SESSION['chat_search_results'] = !empty($usuarios) ? $usuarios : [];

        header('Location: ../HTML/dms.php');
        exit();
    }

    public function obtenerMensajesChat()
    {
        $idUsuario2 = $_POST['id_usuario2'] ?? null;

        if ($idUsuario2) {
            // Llamamos al modelo para obtener los mensajes entre los usuarios
            $mensajes = $this->userModel->obtenerMensajesEntreUsuarios($_SESSION['usuario']['id_usuario'], $idUsuario2);
            echo json_encode($mensajes);  // Devolvemos los mensajes como JSON
        } else {
            echo json_encode(['error' => 'Usuario no seleccionado.']);  // Si no se selecciona usuario
        }
        exit();
    }

    public function insertarMensaje()
    {
        // Capturar los datos del formulario enviados vía POST
        $id_usuario1 = $_SESSION['usuario']['id_usuario']; // Usuario actual que envía el mensaje
        $id_usuario2 = $_POST['id_usuario2'] ?? null; // Usuario receptor
        $texto_mensaje = $_POST['texto_mensaje'] ?? null;
        $fecha_creacion = date('Y-m-d H:i:s'); // Fecha y hora actual

        // Verificar que los campos necesarios no estén vacíos
        if (is_null($id_usuario2) || empty($texto_mensaje)) {
            echo json_encode(['error' => 'Todos los campos son obligatorios.']);
            exit();
        }

        // Llamar al modelo para insertar el mensaje
        $this->userModel->insertarMensaje($id_usuario1, $id_usuario2, $texto_mensaje, $fecha_creacion);

        // Retornar una respuesta indicando que el mensaje fue enviado correctamente
        echo json_encode(['success' => 'Mensaje enviado correctamente.']);
        exit();
    }

    public function showReporteInstructor()
    {
        // Obtener los resultados usando el modelo
        $resultados = $this->userModel->getReporteInstructor();

        // Almacenar resultados en la sesión
        $_SESSION['Reporte_Instructor'] = $resultados;

        // Redirigir a la página de gestión
        header('Location: ../HTML/reportes.php');
        exit();
    }

    public function showReporteEstudiante()
    {
        // Obtener los resultados usando el modelo
        $resultados = $this->userModel->getReporteEstudiante();

        // Almacenar resultados en la sesión
        $_SESSION['Reporte_Estudiante'] = $resultados;

        // Redirigir a la página de gestión
        header('Location: ../HTML/reportes.php');
        exit();
    }
}

// Uso en index.php:
$config = require '../PHP/config.php';
$controller = new UserController($config);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    switch ($_POST['accion']) {
        case 'registro':
            $controller->register();
            break;
        case 'Iniciar_sesion':
            $controller->login();
            break;
        case 'Gestion_admin':
            $controller->Gestiondeadmin();
            break;
        case 'Reporte_instructor':
            $controller->showReporteInstructor();
            break;

        case 'Reporte_estudiante':
            $controller->showReporteEstudiante();
            break;
        case 'Editar_usuario':
            $controller->editUser();
            break;
        case 'bloquear_usuarios':
            $controller->bloquearUsuario();
            break;
        case 'Desbloquear_usuarios':
            $controller->DesbloquearUsuario();
            break;
        case 'Buscar_usuario_chat':
            $controller->buscarUsuariosChat();
            break;
        case 'Obtener_mensajes_chat':
            $controller->obtenerMensajesChat();
            break;
        case 'insertarMensaje':
            $controller->insertarMensaje();
            break;
        default:
            echo json_encode(['error' => 'Acción no válida.']);
            break;
    }
}
