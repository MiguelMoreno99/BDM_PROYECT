<?php

require_once '../.Modelo/ModeloCurso.php';
session_start();

class CourseController
{
    private $courseModel;

    public function __construct($config)
    {
        $this->courseModel = new Modelo_Curso($config);
    }

    public function registerCourse()
    {
        echo "<script>alert('Se Registró el Curso Correctamente!.'); window.location.href = '../HTML/index.php';</script>";
        exit();
    }

    public function registerLevel()
    {
        echo "<script>alert('Se Registraron los niveles Correctamente!.'); window.location.href = '../HTML/index.php';</script>";
        exit();
    }

    // public function delete()
    // {
    //     // Obtener el titulo de la categoría
    //     $titulo = isset($_GET['titulo']) ? trim($_GET['titulo']) : '';
    //     // Obtener datos del formulario
    //     $id_usuario = $_SESSION['usuario']['id_usuario'];
    //     echo "id usuario";
    //     echo $id_usuario;
    //     echo "titulo";
    //     echo $titulo;

    //     // Registrar usuario
    //     $this->categoryModel->DeleteCategory([
    //         $titulo,
    //         $id_usuario
    //     ]);

    //     // Redirigir al inicio
    //     echo "<script>alert('Se Borró la Categoria Correctamente!.'); window.location.href = '../HTML/index.php';</script>";
    //     exit();
    // }

    // public function showCategorys()
    // {
    //     $empty = 1;
    //     $categorys = $this->categoryModel->showAllCategorys();
    //     if ($categorys) {
    //         foreach ($categorys as $categoria) {
    //             $imagen = base64_encode($categoria['imagen_categoria']);
    //             echo "
    //             <a href='Categoria_detalle.php?titulo=" . $categoria['nombre_categoria'] . "' class='curso-link'>
    //             <div class='curso-item'>
    //                 <img src='data:image/jpeg;base64," . $imagen . "' alt='Curso'>
    //                 <h3>" . $categoria['nombre_categoria'] . "</h3>
    //                 <p>" . $categoria['descripcion_categoria'] . ".</p>
    //             </div>
    //             </a>
    //             ";
    //             $empty = 0;
    //         }
    //     }
    //     if ($empty == 1) {
    //         echo "
    //         <div class='curso-item'>
    //             <h3>No hay Ninguna Categoria Creada</h3>
    //             <p>Primero cree una categoria para poder filtar los cursos</p>
    //         </div>
    //         </a>
    //         ";
    //     }
    // }

    // public function showCategory()
    // {

    //     // Obtener el titulo de la categoría
    //     $titulo = isset($_GET['titulo']) ? trim($_GET['titulo']) : '';

    //     $category = $this->categoryModel->checkCategoryExists($titulo);

    //     echo "
    //     <h2 id='nombre_categoria'>" . $category['nombre_categoria'] . "</h2>
    //     <p class='descripcion'>
    //       " . $category['descripcion_categoria'] . "
    //     </p>

    //     <a href='#' class='btn-eliminar'>Eliminar Categoria</a>
    //     <a href='Editar_Categoria.php?titulo=" . $category['nombre_categoria'] . "' class='btn-inscribirse'>Editar Categoria</a>";
    // }

    // public function getCategoryInfo()
    // {
    //     // Obtener el titulo de la categoría
    //     $titulo = isset($_GET['titulo']) ? trim($_GET['titulo']) : '';

    //     $category = $this->categoryModel->checkCategoryExists($titulo);
    //     return $category;
    // }
}

// Uso en index.php:
$config = require '../PHP/config.php';
$controller = new CourseController($config);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    switch ($_POST['accion']) {
        case 'registro_curso':
            $controller->registerLevel();
            break;
    }
}
