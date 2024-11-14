<?php

require_once '../.Modelo/ModeloCategoria.php';
session_start();

class CategoryController
{
    private $categoryModel;

    public function __construct($config)
    {
        $this->categoryModel = new Modelo_Categoria($config);
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

        if ($categoryExists['nombre_categoria'] == $nombre_categoria) {
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

    public function edit()
    {
        $titulo = (isset($_POST['placeholder_titulo-curso']) ? $_POST['placeholder_titulo-curso'] : null);

        // Usar una imagen actual si no se sube una nueva
        $imagen_categoria = !empty($_FILES['imagen_categoria']['tmp_name'])
            ? file_get_contents($_FILES['imagen_categoria']['tmp_name'])
            : base64_decode($_POST['imagen_actual']);

        // Utilizar valores de los placeholders si no se envían nuevos datos
        $nombre_categoria = !empty($_POST['titulo-curso']) ? $_POST['titulo-curso'] : (isset($_POST['placeholder_titulo-curso']) ? $_POST['placeholder_titulo-curso'] : null);
        $descripcion_categoria = !empty($_POST['descripcion-curso']) ? $_POST['descripcion-curso'] : (isset($_POST['placeholder_descripcion-curso']) ? $_POST['placeholder_descripcion-curso'] : null);

        // Verificar que no hay campos nulos antes de realizar la actualización
        if (is_null($nombre_categoria) || is_null($descripcion_categoria)) {
            echo "<script>alert('Por favor, completa todos los campos requeridos.'); window.history.back();</script>";
            exit();
        }

        $categoryExists = $this->categoryModel->checkCategoryExists($nombre_categoria);

        if ($categoryExists['nombre_categoria'] == $titulo) {
            $this->categoryModel->editCategory([
                $titulo,
                $nombre_categoria,
                $descripcion_categoria,
                $imagen_categoria
            ]);
            echo "<script>alert('Se Editó la Categoria Correctamente!.'); window.location.href = '../HTML/index.php';</script>";
            exit();
        }

        if ($categoryExists['nombre_categoria'] == "") {
            $this->categoryModel->editCategory([
                $titulo,
                $nombre_categoria,
                $descripcion_categoria,
                $imagen_categoria
            ]);
            echo "<script>alert('Se Editó la Categoria Correctamente!.'); window.location.href = '../HTML/index.php';</script>";
            exit();
        }

        if ($categoryExists['nombre_categoria'] == $nombre_categoria) {
            echo "<script>alert('Ese nombre de Categoria ya existe, ingrese otro nombre.'); window.history.back();</script>";
            exit();
        }
    }

    public function delete()
    {
        // Obtener el titulo de la categoría
        $titulo = isset($_GET['titulo']) ? trim($_GET['titulo']) : '';
        // Obtener datos del formulario
        $id_usuario = $_SESSION['usuario']['id_usuario'];
        echo "id usuario";
        echo $id_usuario;
        echo "titulo";
        echo $titulo;

        // Registrar usuario
        $this->categoryModel->DeleteCategory([
            $titulo,
            $id_usuario
        ]);

        // Redirigir al inicio
        echo "<script>alert('Se Borró la Categoria Correctamente!.'); window.location.href = '../HTML/index.php';</script>";
        exit();
    }

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
        if ($empty == 1) {
            echo "
            <div class='curso-item'>
                <h3>No hay Ninguna Categoria Creada</h3>
                <p>Primero cree una categoria para poder filtar los cursos</p>
            </div>
            </a>
            ";
        }
    }

    public function showCategory()
    {

        // Obtener el titulo de la categoría
        $titulo = isset($_GET['titulo']) ? trim($_GET['titulo']) : '';

        $category = $this->categoryModel->checkCategoryExists($titulo);

        echo "
        <h2 id='nombre_categoria'>" . $category['nombre_categoria'] . "</h2>
        <p class='descripcion'>
          " . $category['descripcion_categoria'] . "
        </p>

        <a href='#' class='btn-eliminar'>Eliminar Categoria</a>
        <a href='Editar_Categoria.php?titulo=" . $category['nombre_categoria'] . "' class='btn-inscribirse'>Editar Categoria</a>";
    }

    public function getCategoryInfo()
    {
        // Obtener el titulo de la categoría
        $titulo = isset($_GET['titulo']) ? trim($_GET['titulo']) : '';

        $category = $this->categoryModel->checkCategoryExists($titulo);
        return $category;
    }

    public function showInSelectCategorys()
    {
        $empty = 1;
        $categorys = $this->categoryModel->showAllCategorys();
        if ($categorys) {
            foreach ($categorys as $categoria) {
                echo "<option value=" . $categoria['id_categoria'] . ">" . $categoria['nombre_categoria'] . "</option>";
                $empty = 0;
            }
        }
        if ($empty == 1) {
            echo "<script>alert('No hay ninguna categoria creada, contacte con su administrador para que agregue por lo menos una categoria para continuar.'); window.history.back();</script>";
            exit();
        }
    }
}

// Uso en index.php:
$config = require '../PHP/config.php';
$controller = new CategoryController($config);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    switch ($_POST['accion']) {
        case 'registro_categoria':
            $controller->register();
            break;
        case 'editar_categoria':
            $controller->edit();
            break;
    }
}
