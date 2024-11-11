<?php

require_once '../.Modelo/ModeloCurso.php';
session_start();

class CourseController
{
    private $categoryModel;

    public function __construct($config)
    {
        $this->categoryModel = new Modelo_Curso($config);
    }

    public function register()
    {
        // Obtener datos del formulario
        $id_usuario = $_SESSION['usuario']['id_usuario'];

        // Convertir la imagen a BLOB
        $imagen_categoria  = isset($_FILES['imagen_categoria']) && $_FILES['imagen_categoria']['error'] == 0
            ? file_get_contents($_FILES['imagen_categoria']['tmp_name'])
            : null;

        $nombre_categoria = $_POST['titulo-curso'];
        $descripcion_categoria = $_POST['descripcion-curso'];

        // Verificar si el correo ya existe
        $categoryExists = $this->categoryModel->checkCategoryExists($nombre_categoria);

        if ($categoryExists) {
            echo "<script>alert('Ese nombre de Categoria ya existe, ingrese otro nombre.'); window.history.back();</script>";
            exit();
        }
        // Registrar usuario
        $this->categoryModel->registerCategory([
            $nombre_categoria,
            $descripcion_categoria,
            $imagen_categoria,
            $id_usuario
        ]);

        // Redirigir al inicio
        echo "<script>alert('Se Creó la Categoria Correctamente!.'); window.location.href = '../HTML/index.php';</script>";
        exit();
    }

    // public function edit()
    // {
    //     $id_usuario = $_POST['id_usuario'];

    //     // Usar una imagen actual si no se sube una nueva
    //     $imagen_usuario = !empty($_FILES['imagen_usuario']['tmp_name']) 
    //         ? file_get_contents($_FILES['imagen_usuario']['tmp_name']) 
    //         : base64_decode($_POST['imagen_actual']);

    //     // Utilizar valores de los placeholders si no se envían nuevos datos
    //     $nombre_usuario = !empty($_POST['nombre_usuario']) ? $_POST['nombre_usuario'] : (isset($_POST['placeholder_nombre']) ? $_POST['placeholder_nombre'] : null);
    //     $apellido_paterno_usuario = !empty($_POST['apellido_paterno_usuario']) ? $_POST['apellido_paterno_usuario'] : (isset($_POST['placeholder_apellido_paterno']) ? $_POST['placeholder_apellido_paterno'] : null);
    //     $apellido_materno_usuario = !empty($_POST['apellido_materno_usuario']) ? $_POST['apellido_materno_usuario'] : (isset($_POST['placeholder_apellido_materno']) ? $_POST['placeholder_apellido_materno'] : null);
    //     $correo_usuario = !empty($_POST['correo_usuario']) ? $_POST['correo_usuario'] : (isset($_POST['placeholder_correo']) ? $_POST['placeholder_correo'] : null);
    //     $contrasenia_usuario = !empty($_POST['contrasenia_usuario']) ? $_POST['contrasenia_usuario'] : (isset($_POST['placeholder_contrasenia']) ? $_POST['placeholder_contrasenia'] : null);

    //     // Verificar que no hay campos nulos antes de realizar la actualización
    //     if (is_null($nombre_usuario) || is_null($apellido_paterno_usuario) || is_null($apellido_materno_usuario) || is_null($correo_usuario) || is_null($contrasenia_usuario)) {
    //         echo "<script>alert('Por favor, completa todos los campos requeridos.'); window.history.back();</script>";
    //         exit();
    //     }



    //     // Verificar si el correo ya existe
    //     $emailExists = $this->userModel->checkEmailExists($correo_usuario);

    //     if ($emailExists && $emailExists['id_usuario'] == $id_usuario) 
    //     {
    //         // Llamar al modelo para actualizar el usuario
    //         $this->userModel->updateUser([
    //         $id_usuario,
    //         $imagen_usuario,
    //         $nombre_usuario,
    //         $apellido_paterno_usuario,
    //         $apellido_materno_usuario,
    //         $correo_usuario,
    //         $contrasenia_usuario,
    //         ]);

    //         // Actualizar la sesión con los nuevos datos del usuario
    //         $_SESSION['usuario']['nombre_usuario'] = $nombre_usuario;
    //         $_SESSION['usuario']['apellido_paterno'] = $apellido_paterno_usuario;
    //         $_SESSION['usuario']['apellido_materno'] = $apellido_materno_usuario;
    //         $_SESSION['usuario']['correo_usuario'] = $correo_usuario;
    //         $_SESSION['usuario']['contrasenia_usuario'] = $contrasenia_usuario;
    //         $_SESSION['usuario']['imagen_usuario'] = $imagen_usuario;

    //         echo "<script>alert('Usuario modificado.'); window.history.back();</script>";
    //         exit();
    //     }
    //     else
    //     {
    //         if ($emailExists) 
    //         {
    //             echo "<script>alert('Ese correo ya existe, ingrese otro.'); window.history.back();</script>";
    //             exit();
    //         }
    //         else
    //         {
    //            // Llamar al modelo para actualizar el usuario
    //            $this->userModel->updateUser([
    //             $id_usuario,
    //             $imagen_usuario,
    //             $nombre_usuario,
    //             $apellido_paterno_usuario,
    //             $apellido_materno_usuario,
    //             $correo_usuario,
    //             $contrasenia_usuario,
    //             ]);

    //             // Actualizar la sesión con los nuevos datos del usuario
    //             $_SESSION['usuario']['nombre_usuario'] = $nombre_usuario;
    //             $_SESSION['usuario']['apellido_paterno'] = $apellido_paterno_usuario;
    //             $_SESSION['usuario']['apellido_materno'] = $apellido_materno_usuario;
    //             $_SESSION['usuario']['correo_usuario'] = $correo_usuario;
    //             $_SESSION['usuario']['contrasenia_usuario'] = $contrasenia_usuario;
    //             $_SESSION['usuario']['imagen_usuario'] = $imagen_usuario;

    //             echo "<script>alert('Usuario modificado.'); window.history.back();</script>";
    //             exit();
    //         }
    //     }

    //     exit();
    // }

    // public function delete()
    // {
    // }

    public function showCategorys()
    {
        $empty = 1;
        $categorys = $this->categoryModel->showAllCategorys();
        if ($categorys) {
            foreach ($categorys as $categoria) {
                $imagen = base64_encode($categoria['imagen_categoria']);
                echo "
                <a href='Categoria_detalle.php?titulo=" . $categoria['nombre_categoria'] . "' class='curso-link'>
                <div class='curso-item'>
                    <img src='data:image/jpeg;base64," . $imagen . "' alt='Curso'>
                    <h3>" . $categoria['nombre_categoria'] . "</h3>
                    <p>" . $categoria['descripcion_categoria'] . ".</p>
                </div>
                </a>
                ";
                $empty = 0;
            }
        }
        if($empty==1){
            echo "
            <div class='curso-item'>
                <h3>No hay Ninguna Categoria Creada</h3>
                <p>Primero cree una categoria para poder filtar los cursos</p>
            </div>
            </a>
            ";
        }
    }

    public function showCategory(){

        // Obtener el ID de la categoría
        $titulo = isset($_GET['titulo']) ? trim($_GET['titulo']) : '';

        $category = $this->categoryModel->checkCategoryExists($titulo);

        echo "
        <h2>Categoria de " . $category['nombre_categoria'] . "</h2>
        <p class='descripcion'>
          " . $category['descripcion_categoria'] . "
        </p>

        <a href='#' class='btn-eliminar'>Eliminar Categoria</a>
        <a href='Editar_Categoria.html?titulo=" . $category['nombre_categoria'] . "' class='btn-inscribirse'>Editar Categoria</a>";
    }
}

// Uso en index.php:
$config = require '../PHP/config.php';
$controller = new CourseController($config);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    switch ($_POST['accion']) {
        case 'registro_categoria':
            $controller->register();
            break;
            // case 'editar_categoria':
            //     $controller->edit();
            //     break;
            // case 'borrar_categoria':
            //     $controller->delete();
            //     break;        
    }
}
