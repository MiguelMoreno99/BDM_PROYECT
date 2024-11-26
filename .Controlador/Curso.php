<?php

require_once '../.Modelo/ModeloCurso.php';

if (session_status() === PHP_SESSION_NONE) {
    session_start();
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
                $niveles_curso = max($niveles_curso, (int) $matches[1]);
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
        $imagen_curso = isset($_FILES['imagen_curso']) && $_FILES['imagen_curso']['error'] == 0
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
                $niveles_curso = max($niveles_curso, (int) $matches[1]);
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
            $imagen_nivel = isset($_FILES["imagen-nivel-$nivel"]) && $_FILES["imagen-nivel-$nivel"]['error'] == 0
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
        // Obtener el título del curso desde los parámetros
        $titulo = isset($_GET['titulo']) ? trim($_GET['titulo']) : '';

        // Obtener el curso desde el modelo
        $course = $this->courseModel->checkCourseExists($titulo);

        // Validar que se encontró el curso
        if (!$course || !is_array($course)) {
            echo "<p>Error: No se encontró información para el curso seleccionado.</p>";
            return; // Salir de la función si no hay datos válidos
        }

        // Validar si la imagen del curso está disponible
        $imagen_curso = isset($course['imagen_curso']) ? base64_encode($course['imagen_curso']) : '';

        // Obtener datos del usuario
        $tipo_usuario = isset($_SESSION['usuario']['tipo_usuario']) ? $_SESSION['usuario']['tipo_usuario'] : null;

        echo "  <img src='data:image/jpeg;base64," . $imagen_curso . "' class='imgCurso' alt='Curso'>
            <div class='curso-info'>
                <h2 id='titulo-curso'>" . htmlspecialchars($course['titulo_curso']) . "</h2>
                <p><strong>Total de Niveles: </strong>" . htmlspecialchars($course['niveles_curso']) . "</p>";

        // Verificar el manejo del precio del curso
        if ($course['manejo_precio_curso'] == 0) {
            echo "  <p><strong>Costo del Curso Completo: </strong>Gratis!!</p>";
        } elseif ($course['manejo_precio_curso'] == 1) {
            echo "  <p><strong>Costo del Curso Completo: </strong> $" . htmlspecialchars($course['precio_curso']) . "</p>";
        } elseif ($course['manejo_precio_curso'] == 2) {
            echo "  <p><strong>Costo por Nivel: </strong> Este Curso se maneja por venta individual de niveles. Para más información del costo, vea los diferentes niveles.</p>";
        }

        // Descripción del curso
        echo "<p class='descripcion'>" . htmlspecialchars($course['descripcion_curso']) . "</p>";

        // Botones según el tipo de usuario
        if ($tipo_usuario == 1 || $tipo_usuario == 2) {
            echo "  <a href='PagoCurso.php?titulo=" . urlencode($course['titulo_curso']) . "' class='btn-inscribirse'>Inscribirse</a>";
        } elseif ($tipo_usuario == 3) {
            echo "  <a href='#?titulo=" . urlencode($course['titulo_curso']) . "' class='btn-eliminar'>Eliminar Curso</a>";
        }

        echo "  </div>";
    }

    public function ShowCoursePago()
    {
        // Obtener el título del curso
        $titulo = isset($_GET['titulo']) ? trim($_GET['titulo']) : '';
        $_SESSION['titulo_curso'] = $titulo; // Guardar el título en la sesión

        $course = $this->courseModel->checkCourseExists($titulo);
        $imagen_curso = base64_encode($course['imagen_curso']);
        $tipo_usuario = $_SESSION['usuario']['tipo_usuario'];

        echo "<img src='data:image/jpeg;base64," . $imagen_curso . "' class='imgCurso' alt='Curso'>
        <div class='curso-info'>
            <h2 id='titulo-curso'>" . htmlspecialchars($course['titulo_curso']) . "</h2>
            <p><strong>Total de Niveles: </strong>" . htmlspecialchars($course['niveles_curso']) . "</p>
            <input type='hidden' name='id_curso' id= 'Id_curso_id' value=' " . htmlspecialchars($course['id_curso']) . "' readonly>";

        if ($course['manejo_precio_curso'] == 0) {
            echo "<p><strong>Costo del Curso Completo: </strong>Gratis!!</p>";
        } elseif ($course['manejo_precio_curso'] == 1) {
            echo "<p><strong>Costo del Curso Completo: </strong> $" . $course['precio_curso'] . "</p>";
        } elseif ($course['manejo_precio_curso'] == 2) {
            echo "<p><strong>Costo por Nivel: </strong> Este Curso se maneja por venta individual de niveles, para más información del costo vea los diferentes niveles!</p>";
        }

        echo "<p class='descripcion'>" . $course['descripcion_curso'] . "</p>";
        echo "</div>";
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


    public function obtenerPrecioCursosYNiveles()
    {
        // Obtener el título del curso desde la URL
        $titulo = isset($_GET['titulo']) ? trim($_GET['titulo']) : '';
        $course = $this->courseModel->checkCourseExists($titulo);
        $id_curso = $course['id_curso'];
        $niveles = [];
        $manejoPrecio = $course['manejo_precio_curso'];
        // Obtener los detalles del curso y niveles desde el modelo
        $courseData = $this->courseModel->obtenerNivelesPorCurso($id_curso);

        if (empty($courseData)) {
            echo "<script>alert('No se encontraron detalles para este curso!.'); window.location.href = '../HTML/index.php';</script>";
            return;
        }

        echo "<div class='compra-detalle'>";
        echo "<h1>Detalles del Curso</h1>";
        echo "<div class='compra-tipo'>";

        if ($manejoPrecio == 0) {
            echo "<div id='completeCourse'>
                  <h1>¡Curso Gratis!</h1>
                  <h2>Costo Total: <span id='totalCost'> 0 </span></h2>";
            echo "<h3>Niveles incluidos en el curso gratuito:</h3>";
            echo "<ul id='niveles-list'>";
            foreach ($courseData as $row) {
                echo "<h3>Titulo del Nivel: " . htmlspecialchars($row['titulo_nivel']) . "</h3>
                      <p>Precio del Nivel: $" . htmlspecialchars($row['costo_nivel']) . "</p>
                      <input type='checkbox' name='niveles[]' value='" . htmlspecialchars($row['id_nivel']) . "' data-costo='" . htmlspecialchars($row['costo_nivel']) . "' onchange='actualizarTotal()'  checked disabled>
                      <label>Seleccionar Nivel</label>
                      <hr>";
            }
            echo "</ul>";
            echo "</div>";
        }
        // Curso completo
        elseif ($manejoPrecio == 1) {
            echo "<div id='completeCourse'>
            <h1>Curso se vende Completo!</h1>
            <h2>Costo Total del Cursp: $ <span id='totalCost'>" . htmlspecialchars($course['precio_curso']) . "</span></h2>";
            echo "<h3>Niveles incluidos en el curso completo:</h3>";
            echo "<ul id='niveles-list'>";
            foreach ($courseData as $row) {
                echo "<h3>Titulo del Nivel: " . htmlspecialchars($row['titulo_nivel']) . "</h3>
                      <p>Precio del Nivel: $" . htmlspecialchars($row['costo_nivel']) . "</p>
                      <input type='checkbox' name='niveles[]' value='" . htmlspecialchars($row['id_nivel']) . "' data-costo='" . htmlspecialchars($row['costo_nivel']) . "' onchange='actualizarTotal()'  checked disabled>
                      <label>Seleccionar Nivel</label>
                      <hr>";
            }
            echo "</ul>";
            echo "</div>";
        }
        // Curso por niveles
        elseif ($manejoPrecio == 2) {
            echo "<div id='courseLevels'>
            <h1>Curso se vende por Separado!</h1>
            <h2>Selecciona los niveles del curso que desees comprar:</h2>";
            echo "<ul id='niveles-list'>";
            foreach ($courseData as $row) {
                echo "<h3>Titulo del Nivel: " . htmlspecialchars($row['titulo_nivel']) . "</h3>
                      <p>Precio del Nivel: $" . htmlspecialchars($row['costo_nivel']) . "</p>
                      <input type='checkbox' name='niveles[]' value='" . htmlspecialchars($row['id_nivel']) . "' data-costo='" . htmlspecialchars($row['costo_nivel']) . "' onchange='actualizarTotal()' checked>
                      <label>Seleccionar Nivel</label>
                      <hr>";
            }
            echo "</ul>";
            echo "</div>";
        }
        echo "</div>";
        echo "</div>";
    }

    public function obtenerFormasdepago()
    {
        // Obtener el título del curso desde la URL
        $titulo = isset($_GET['titulo']) ? trim($_GET['titulo']) : '';
        $course = $this->courseModel->checkCourseExists($titulo);
        $manejoPrecio = $course['manejo_precio_curso'];
        // // Obtener los detalles del curso desde el modelo
        // $courseData = $this->courseModel->obtenerNivelesPorCurso($titulo);

        // // Manejo del precio del curso
        // $manejoPrecio = $curso['manejo_precio_curso'];
        // $costo = $manejoPrecio == 0 ? 0 : $curso['costo'];

        // Construir las opciones de pago
        echo '<select id="paymentMethod" name="metodo_pago" onchange="togglePaymentFields()">';
        echo '<option value="">Seleccione un método de pago</option>';
        if ($manejoPrecio == 0) {
            // Solo mostrar opción de curso gratuito
            echo '<option value="3"><span id="FormadePago">Gratis</span></option>';
        } else {
            // Opciones estándar
            echo '<option value="1"><span id="FormadePago">Tarjeta de Crédito</span></option>';
            echo '<option value="0"><span id="FormadePago">Tarjeta de Débito</span></option>';
            echo '<option value="2"><span id="FormadePago">PayPal</span></option>';
        }
        echo '</select>';

        // // Enviar valores adicionales al formulario
        // echo '<input type="hidden" name="precio_pagado" value="' . htmlspecialchars($costo) . '">';
    }


    public function registrarInscripcion()
    {
        $id_usuario = $_POST['id_usuario_1'] ?? null;
        $id_curso = $_POST['id_curso'] ?? null;
        $costo_total = $_POST['costo_total'] ?? 0;
        $forma_de_pago = $_POST['forma_de_pago2'] ?? null;

        if ($forma_de_pago) {
            echo "<p>$forma_de_pago</p>";
        }

        $this->courseModel->registerInscripcion([
            $id_usuario,
            $id_curso,
            $forma_de_pago,
            $costo_total,
        ]);

        echo "<p>Detalles del curso no disponibles.</p>";
    }

    public function registerInscripcion_niveles()
    {
        // Obtener el ID de usuario, curso, y los niveles seleccionados del POST
        $id_usuario = $_POST['id_usuario_1'];
        $id_curso = $_POST['id_curso'];
        $nivelesSeleccionados = json_decode($_POST['nivelesSeleccionados'], true); // Decodificar el JSON

        // Validar que los datos requeridos estén presentes
        if (!$id_usuario || !$id_curso || empty($nivelesSeleccionados)) {
            echo json_encode(['error' => 'Datos insuficientes para registrar la inscripción.']);
            return;
        }

        // Verificar si existe una inscripción previa para el usuario y curso
        $inscripcionExists = $this->courseModel->checkInscripcionExista($id_usuario, $id_curso);

        // Si la inscripción no existe, manejar el error
        if (!$inscripcionExists) {
            echo json_encode(['error' => 'La inscripción no existe.']);
            return;
        }

        $id_inscripcion = $inscripcionExists['id_inscripcion'];

        // Registrar cada nivel en la base de datos
        foreach ($nivelesSeleccionados as $nivel) {
            $id_nivel = $nivel['id'];
            $titulo_nivel = $nivel['title'];

            // Llamar al modelo para insertar el nivel
            $this->courseModel->registerInscripcion_niveles([
                'p_id_inscripcion' => $id_inscripcion,
                'p_id_nivel' => $id_nivel,
                'p_titulo_nivel' => $titulo_nivel
            ]);
        }

        echo json_encode(['success' => 'Niveles registrados correctamente.']);
    }

    public function miscursos()
    {
        // Obtener el ID del usuario desde la sesión
        $id_student = $_SESSION['usuario']['id_usuario'];

        // Obtener los cursos del estudiante desde el modelo
        $courses = $this->courseModel->getCoursesByStudent($id_student);

        // Mostrar la información en HTML
        echo '<div class="main-cursos">';
        foreach ($courses as $course) {
            echo '<div class="seccion-curso">';
            echo '<img src="data:image/jpeg;base64,' . base64_encode($course['imagen_curso']) . '" alt="imagen del curso">';
            echo '<div class="titulo-curso">';
            echo '<h1>' . htmlspecialchars($course['titulo_curso']) . '</h1>';
            echo '</div>';
            echo '<br><br>';
            echo '<div class="progreso-curso">';
            echo '<h2>Progreso</h2>';
            echo '<br>';
            echo '<progress value="' . htmlspecialchars($course['porcentaje_avance_curso']) . '" max="100"></progress>';
            echo '</div>';
            echo '<br><br>';
            echo '<div class="boton-div">';
            echo '<a href="../HTML/curso.html">ENTRAR</a>';
            echo '</div>';
            echo '</div>';
        }
        echo '</div>';
    }

    public function CursoInfo()
    {
        $start_date = $_POST['fecha_inicio'] ?? null;
        $end_date = $_POST['fecha_fin'] ?? null;
        $category_name = $_POST['categoria'] ?? null;
        $curso_deshabilitado = $_POST['estado'] ?? null;

        $id_instructor_creacion_curso = $_SESSION['usuario']['id_usuario'];

        if (!is_null($curso_deshabilitado)) {
            $curso_deshabilitado = (int) $curso_deshabilitado;
        }

        $resultados = $this->courseModel->GetCursoInfo(
            $start_date,
            $end_date,
            $category_name,
            $curso_deshabilitado,
            $id_instructor_creacion_curso,

        );

        $_SESSION['curso_data'] = $resultados;

        header('Location: ../HTML/gestion_instructor.php');
        exit();
    }

    public function CursoAlumno()
    {
        // Obtener el id del curso seleccionado desde el formulario
        $ID_Curso = $_POST['curso_seleccionado'] ?? null;

        // Verificar que se haya recibido un ID de curso válido
        if ($ID_Curso) {
            // Obtener los datos de los estudiantes para el curso seleccionado
            $resultados = $this->courseModel->GetCursoAlumno($ID_Curso);

            // Almacenar los resultados en la sesión
            $_SESSION['curso_Alumno'] = $resultados;

            // Redirigir al mismo formulario con los resultados cargados
            header('Location: ../HTML/gestion_instructor.php');
            exit();
        } else {
            // Si no se ha seleccionado un curso, redirigir con un mensaje de error
            $_SESSION['error'] = 'Por favor, seleccione un curso.';
            header('Location: ../HTML/gestion_instructor.php');
            exit();
        }
    }

    public function AlumnosCursos()
    {
        // Obtener el id del estudiante desde la sesión
        $id_estudiante = $_SESSION['usuario']['id_usuario'];

        // Obtener los valores de los filtros desde el formulario
        $fecha_inscripcion = $_POST['fecha_inicio'] ?? null;
        $ultima_fecha = $_POST['fecha_fin'] ?? null;
        $nombre_categoria = $_POST['categoria'] ?? null;
        $inscripcion_finalizada = $_POST['cursos'] ?? null;
        $estado = $_POST['estado'] ?? null;


        if (!is_null($inscripcion_finalizada)) {
            $inscripcion_finalizada = (int) $inscripcion_finalizada;
            if ($inscripcion_finalizada !== 0 && $inscripcion_finalizada !== 1) {
                $inscripcion_finalizada = null;
            }
        }

        if (!is_null($estado)) {
            $estado = (int) $estado;
        }

        $resultados = $this->courseModel->GetEstudianteInfo(
            $id_estudiante,
            $fecha_inscripcion,
            $ultima_fecha,
            $nombre_categoria,
            $inscripcion_finalizada,
            $estado
        );

        $_SESSION['Alumno_datos'] = $resultados;

        header('Location: ../HTML/gestion_usuario.php');
        exit();
    }
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

        case 'Traer_informacion_pago':
            $controller->obtenerFormasdepago();

        case 'registro_inscripcion':
            $controller->registrarInscripcion();
            $controller->registerInscripcion_niveles();
            break;
        case 'Curso_Info':
            $controller->CursoInfo();
            break;
        case 'Curso_Alumno':
            $controller->CursoAlumno();
            break;

        case 'Alumnos_Cursos':
            $controller->AlumnosCursos();
            break;
    }
}
