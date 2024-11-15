<?php

require_once '../.Modelo/ModeloCurso.php';

if (session_status() === PHP_SESSION_NONE) {
    session_start(); // Iniciar la sesión si no está activa
}

class CourseController
{
    private $courseModel;

    public function __construct($config)
    {
        $this->courseModel = new Modelo_Curso($config);
    }

    public function registerCourse()
    {
        $titulo_curso = $_POST['titulo-curso'];

        $id_categoria_curso = $_POST['Categoria'];

        // Contar cuántos niveles hay en función de los nombres de los inputs
        $niveles_curso = 0;
        foreach ($_POST as $nombreCampo => $valor) {
            if (preg_match('/^nivel-titulo-(\d+)$/', $nombreCampo, $matches)) {
                $niveles_curso = max($niveles_curso, (int)$matches[1]);
            }
        }

        $manejo_precio_curso = $_POST['tipo-precio'];

        if ($manejo_precio_curso === '0' || $manejo_precio_curso === '2') {
            $precio_curso = 0;
        }
        if ($manejo_precio_curso === '1') {
            $precio_curso = $_POST['costo-curso'];
        }

        $descripcion_curso = $_POST['descripcion-curso'];

        // Convertir la imagen a BLOB
        $imagen_curso  = isset($_FILES['imagen_curso']) && $_FILES['imagen_curso']['error'] == 0
            ? file_get_contents($_FILES['imagen_curso']['tmp_name'])
            : null;

        // Obtener datos del formulario
        $id_instructor_creacion_curso = $_SESSION['usuario']['id_usuario'];

        // Verificar si el CURSO ya existe
        $courseExists = $this->courseModel->checkCourseExists($titulo_curso);

        if ($courseExists['titulo_curso'] == $titulo_curso) {
            echo "<script>alert('Ese Titulo de Curso ya existe, ingrese otro nombre.'); window.history.back();</script>";
            exit();
        }
        // Registrar curso
        $this->courseModel->registerCourse([
            $titulo_curso,
            $id_categoria_curso,
            $niveles_curso,
            $manejo_precio_curso,
            $precio_curso,
            $descripcion_curso,
            $imagen_curso,
            $id_instructor_creacion_curso
        ]);
    }

    public function registerLevel()
    {
        // Contar cuántos niveles hay en función de los nombres de los inputs
        $niveles_curso = 0;
        foreach ($_POST as $nombreCampo => $valor) {
            if (preg_match('/^nivel-titulo-(\d+)$/', $nombreCampo, $matches)) {
                $niveles_curso = max($niveles_curso, (int)$matches[1]);
            }
        }

        $titulo_curso = $_POST['titulo-curso'];
        $courseExists = $this->courseModel->checkCourseExists($titulo_curso);
        $id_curso_nivel = $courseExists['id_curso'];

        $manejo_precio_curso = $_POST['tipo-precio'];

        // Obtener datos del formulario
        $id_instructor_creacion_curso = $_SESSION['usuario']['id_usuario'];

        // Recorrer cada nivel usando el total de niveles detectado
        for ($nivel = 1; $nivel <= $niveles_curso; $nivel++) {

            $titulo_nivel = $_POST["nivel-titulo-$nivel"] ?? '';
            $informacion_nivel = $_POST["contenido-nivel-$nivel"] ?? '';
            $documento_nivel = $_POST["linkpdf-nivel-$nivel"] ?? '';
            $imagen_nivel  = isset($_FILES["imagen-nivel-$nivel"]) && $_FILES["imagen-nivel-$nivel"]['error'] == 0
                ? file_get_contents($_FILES["imagen-nivel-$nivel"]['tmp_name'])
                : null;
            $referencias_nivel = $_POST["linkpagina-nivel-$nivel"] ?? '';
            $link_video_nivel = $_POST["linkyoutube-nivel-$nivel"] ?? '';
            if ($manejo_precio_curso === '0' || $manejo_precio_curso === '1') {
                $costo_nivel = 0;
            }
            if ($manejo_precio_curso === '2') {
                $costo_nivel = $_POST["precio-nivel-$nivel"] ?? '';
            }
            // Registrar curso
            $this->courseModel->registerLevel([
                $id_instructor_creacion_curso,
                $titulo_nivel,
                $documento_nivel,
                $link_video_nivel,
                $costo_nivel,
                $id_curso_nivel,
                $informacion_nivel,
                $imagen_nivel,
                $referencias_nivel
            ]);
        }
        // Redirigir al inicio
        echo "<script>alert('Se Registró el Curso y su(s) nivel(es) Correctamente!.'); window.location.href = '../HTML/index.php';</script>";
        exit();
    }

    public function showCourses()
    {
        $empty = 1;
        $courses = $this->courseModel->showAllCourses();
        if ($courses) {
            foreach ($courses as $curso) {
                $imagen = base64_encode($curso['imagen_curso']);
                echo "
                    <a href='curso_detalle.php?titulo=" . $curso['titulo_curso'] . "'' class='curso-link'>
                        <div class='curso-item'>
                            <img src='data:image/jpeg;base64," . $imagen . "' alt='Curso'>
                            <h3>" . $curso['titulo_curso'] . "</h3>
                            <p>" . $curso['descripcion_curso'] . "</p>
                        </div>
                    </a>";
                $empty = 0;
            }
        }
        if ($empty == 1) {
            echo "
            <div class='curso-item'>
                <h3>No hay Ningun Curso Creado!</h3>
                <p>Primero cree algun curso para poder ver mas informacion</p>
            </div>
            ";
        }
    }

    public function showCoursesByCategory()
    {
        // Obtener el titulo de la categoría
        $titulo = isset($_GET['titulo']) ? trim($_GET['titulo']) : '';
        $category = $this->courseModel->checkCategoryExists($titulo);
        $id_categoria = $category['id_categoria'];

        $empty = 1;
        $courses = $this->courseModel->showAllCoursesByCategory($id_categoria);
        if ($courses) {
            foreach ($courses as $curso) {
                $imagen = base64_encode($curso['imagen_curso']);
                echo "
                    <a href='curso_detalle.php?titulo=" . $curso['titulo_curso'] . "'' class='curso-link'>
                        <div class='curso-item'>
                            <img src='data:image/jpeg;base64," . $imagen . "' alt='Curso'>
                            <h3>" . $curso['titulo_curso'] . "</h3>
                            <p>" . $curso['descripcion_curso'] . "</p>
                        </div>
                    </a>";
                $empty = 0;
            }
        }
        if ($empty == 1) {
            echo "
            <div class='curso-item'>
                <h3>No hay Ningun Curso En esta Categoria!</h3>
                <p>Cree Un curso con esta categoria para poder vizualizarla aqui!</p>
            </div>
            ";
        }
    }

    public function showCourse()
    {
        // Obtener el titulo del curso
        $titulo = isset($_GET['titulo']) ? trim($_GET['titulo']) : '';
        $course = $this->courseModel->checkCourseExists($titulo);
        $imagen_curso = base64_encode($course['imagen_curso']);
        // Obtener datos del formulario
        $tipo_usuario = $_SESSION['usuario']['tipo_usuario'];

        echo "  <img src='data:image/jpeg;base64," . $imagen_curso . "' class='imgCurso' alt='Curso'>
                <div class='curso-info'>
                    <h2 id='titulo-curso'>" . $course['titulo_curso'] . "</h2>
                    <p><strong>Total de Niveles: </strong>" . $course['niveles_curso'] . "</p>";
        if ($course['manejo_precio_curso'] == 0) {
            echo "  <p><strong>Costo del Curso Completo: </strong>Gratis!!</p>";
        }
        if ($course['manejo_precio_curso'] == 1) {
            echo "  <p><strong>Costo del Curso Completo: </strong> $" . $course['precio_curso'] . "</p>";
        }
        if ($course['manejo_precio_curso'] == 2) {
            echo "  <p><strong>Costo por Nivel: </strong> Este Curso se maneja por venta individual de niveles, para mas informacion del costo vea los diferentes niveles!</p>";
        }
        echo "      <p class='descripcion'>" . $course['descripcion_curso'] . "</p>";
        if ($tipo_usuario == 1) {
            echo "  <a href='PagoCurso.html?titulo=" . $course['titulo_curso'] . "'' class='btn-inscribirse'>Inscribirse</a>";
        }
        if ($tipo_usuario == 2) {
            echo "  <a href='PagoCurso.html?titulo=" . $course['titulo_curso'] . "'' class='btn-inscribirse'>Inscribirse</a>";
        }
        if ($tipo_usuario == 3) {
            echo "  <a href='#?titulo=" . $course['titulo_curso'] . "'' class='btn-eliminar'>Eliminar Curso</a>";
        }
        echo "  </div>
             ";
    }

    public function deleteCourse()
    {
        // Obtener el titulo de la categoría
        $titulo = isset($_GET['titulo']) ? trim($_GET['titulo']) : '';
        // Obtener datos del formulario
        $id_usuario = $_SESSION['usuario']['id_usuario'];

        // Registrar usuario
        $this->courseModel->deleteCourse([
            $titulo,
            $id_usuario
        ]);

        // Redirigir al inicio
        echo "<script>alert('Se Borró el Curso Correctamente!.'); window.location.href = '../HTML/index.php';</script>";
        exit();
    }

    // public function getCourseInfo()
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
            $controller->registerCourse();
            $controller->registerLevel();
            break;
    }
}
