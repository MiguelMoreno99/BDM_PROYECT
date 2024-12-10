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

    public function showCursoMejorCalificado()
    {
        $empty = 1;
        $courses = $this->courseModel->vista_Cursos_Mejor_Puntuados();
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


    public function showCursoMasInscrito()
    {
        $empty = true;
        $courses = $this->courseModel->vista_cursos_mas_inscripciones();

        if (!empty($courses)) {
            foreach ($courses as $curso) {
                // Verificar que $curso sea un array antes de acceder a sus claves
                if (is_array($curso)) {
                    $imagen = base64_encode($curso['imagen_curso']);
                    echo "
                        <a href='curso_detalle.php?titulo=" . $curso['titulo_curso'] . "' class='curso-link'>
                            <div class='curso-item'>
                                <img src='data:image/jpeg;base64," . $imagen . "' alt='Curso'>
                                <h3>" . $curso['titulo_curso'] . "</h3>
                                <p>" . $curso['descripcion_curso'] . "</p>
                            </div>
                        </a>";
                    $empty = false;
                }
            }
        }

        if ($empty) {
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

        $id_usuario_ins = $_POST['id_usuario'];
        $id_curso_ins = $_POST['id_curso'];
        $manejoPrecio_ins = $_POST['forma_pago'];
        $costo_total_ins = $_POST['costo_total'];

        $this->courseModel->registerInscripcion([
            $id_usuario_ins,
            $id_curso_ins,
            $manejoPrecio_ins,
            $costo_total_ins,
        ]);
    }

    public function registerInscripcion_niveles()
    {
        // Obtener el ID de usuario, curso, y niveles seleccionados del POST
        $titulo_curso = $_POST['titulo_curso'];
        $id_usuario = $_POST['id_usuario'];
        $id_curso = $_POST['id_curso'];
        $nivelesSeleccionados = json_decode($_POST['nivelesSeleccionados'], true); // Decodificar los niveles seleccionados

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

        // Obtener el ID de inscripción existente
        $id_inscripcion = $inscripcionExists['id_inscripcion'];

        // Registrar los niveles seleccionados
        foreach ($nivelesSeleccionados as $nivel) {
            $this->courseModel->registerInscripcion_niveles([
                $id_inscripcion,         // ID de inscripción
                $nivel['levelID'],       // ID del nivel
                $nivel['levelName'],     // Título del nivel
            ]);
        }

        echo "<script>alert('Curso inscrito.'); window.location.href = '../HTML/curso_detalle.php?titulo=" . urlencode($titulo_curso) . "';</script>";
    }

    public function miscursos()
    {
        // Obtener el ID del usuario desde la sesión
        $id_student = $_SESSION['usuario']['id_usuario'];

        // Obtener los cursos del estudiante desde el modelo
        $courses = $this->courseModel->getCoursesByStudent($id_student);

        return is_array($courses) ? $courses : [];
    }

    public function misniveles()
    {
        // Obtén el ID del estudiante de la sesión
        $id_estudiante = isset($_SESSION['usuario']['id_usuario']) ? $_SESSION['usuario']['id_usuario'] : null;

        if (!$id_estudiante) {
            die("Error: No se pudo obtener el ID del usuario.");
        }

        // Valida el título del curso
        $titulo = isset($_GET['titulo']) ? trim($_GET['titulo']) : '';
        $curso = $this->courseModel->checkCourseExists($titulo);

        if (!$curso || !isset($curso['id_curso'])) {
            die("Error: No se encontró el curso con el título especificado.");
        }

        $id_curso = $curso['id_curso'];

        // Obtén la inscripción
        $inscripcion = $this->courseModel->obtenerInscripcion($id_curso, $id_estudiante);

        $id_inscripcion = $inscripcion['id_inscripcion'];

        $Niveles_inscripcion = $this->courseModel->obtenerNivelesInscrpcion($id_inscripcion);

        // Devuelve un array de comentarios o vacío
        return is_array($Niveles_inscripcion) ? $Niveles_inscripcion : [];
    }

    public function porcentajeInscripcion()
    {
        // Obtén el ID del estudiante de la sesión
        $id_estudiante = isset($_SESSION['usuario']['id_usuario']) ? $_SESSION['usuario']['id_usuario'] : null;

        if (!$id_estudiante) {
            die("Error: No se pudo obtener el ID del usuario.");
        }

        // Valida el título del curso
        $titulo = isset($_GET['titulo']) ? trim($_GET['titulo']) : '';
        $curso = $this->courseModel->checkCourseExists($titulo);

        if (!$curso || !isset($curso['id_curso'])) {
            die("Error: No se encontró el curso con el título especificado.");
        }

        $id_curso = $curso['id_curso'];

        // Obtén la inscripción
        $inscripcion = $this->courseModel->obtenerInscripcion($id_curso, $id_estudiante);

        return [

            'porcentaje_avance_curso' => $inscripcion['porcentaje_avance_curso'],
            'id_inscripcion' => $inscripcion['id_inscripcion'],
            'inscripcion_finalizada' => $inscripcion['inscripcion_finalizada'],
        ];
    }

    public function actualizar_progreso()
    {

        // Obtener los datos del formulario POST
        $id_estudiante = $_SESSION['usuario']['id_usuario'] ?? null;
        $progresocurso = $_POST['progreso_curso'];
        $id_inscripcion = $_POST['id_inscripcion'] ?? null;
        $titulo = $_POST['titulo_curso'] ?? null;

        $this->courseModel->ActualizarAvanceCurso($id_inscripcion, $progresocurso);
        echo "<script>window.location.href = '../HTML/cursoinscrito.php?titulo=" . urlencode($titulo) . "';</script>";

        exit();
    }

    public function Actualizar_UltimoIngreso()
    {
        // Obtener los datos del formulario POST
        $id_inscripcion = $_POST['id_inscripcion'] ?? null;
        $titulo = $_POST['Titulo'] ?? null;

        $this->courseModel->ActualizarUltimoIngreso($id_inscripcion);
        echo "<script>window.location.href = '../HTML/cursoinscrito.php?titulo=" . urlencode($titulo) . "';</script>";

        exit();
    }


    public function NivelCompletado()
    {
        // Obtener los datos del formulario POST
        $id_inscripcion = $_POST['id_inscripcion'] ?? null;
        $titulo = $_POST['titulo_curso'] ?? null;

        if ($id_inscripcion) {
            $this->courseModel->Actualizarnivelterminado($id_inscripcion);
            echo "<script> window.location.href = '../HTML/cursoinscrito.php?titulo=" . urlencode($titulo) . "';</script>";
        } else {
            echo "<script>alert('Faltan datos.'); window.location.href = '../HTML/cursoinscrito.php?titulo=" . urlencode($titulo) . "';</script>";
        }

        exit();
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

    public function Desactivar_curso()
    {
        $ID_Curso = $_POST['curso_seleccionado'] ?? null;

        if ($ID_Curso) {
            $this->courseModel->DeshabilitarCurso($ID_Curso);
            $_SESSION['success'] = 'Curso desactivado con éxito.';
        } else {
            $_SESSION['error'] = 'No se seleccionó un curso para desactivar.';
        }

        header('Location: ../HTML/gestion_instructor.php');
        exit();
    }

    public function Activar_Curso()
    {
        $ID_Curso = $_POST['curso_seleccionado'] ?? null;

        if ($ID_Curso) {
            $this->courseModel->HabilitarCurso($ID_Curso);
            $_SESSION['success'] = 'Curso activado con éxito.';
        } else {
            $_SESSION['error'] = 'No se seleccionó un curso para activar.';
        }

        header('Location: ../HTML/gestion_instructor.php');
        exit();
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

    public function Cursofinalizado()
    {
        $titulo_curso_finalizado = isset($_GET['titulo']) ? trim($_GET['titulo']) : '';

        if (empty($titulo_curso_finalizado)) {
            return ['error' => 'Error: Título del curso no proporcionado.'];
        }

        $course = $this->courseModel->ObtenerCursoPorTitulo($titulo_curso_finalizado);

        if (!$course) {
            return ['error' => 'Error: Curso no encontrado.'];
        }

        $imagen_curso = isset($course['imagen_curso']) ? 'data:image/png;base64,' . base64_encode($course['imagen_curso']) : '';

        return [
            'id_curso' => $course['id_curso'],
            'titulo_curso' => $course['titulo_curso'],
            'imagen_curso' => $imagen_curso,
            'id_instructor' => $course['id_instructor_creacion_curso'],
        ];
    }

    public function ShowCursoInscripcion()
    {
        // Obtener el título del curso
        $titulo = isset($_GET['titulo']) ? trim($_GET['titulo']) : '';
        $_SESSION['titulo_curso'] = $titulo; // Guardar el título en la sesión

        $course = $this->courseModel->checkCourseExists($titulo);

        $imagen_curso = isset($course['imagen_curso']) ? 'data:image/png;base64,' . base64_encode($course['imagen_curso']) : '';
        $tipo_usuario = $_SESSION['usuario']['tipo_usuario'];

        return [
            'id_curso' => $course['id_curso'],
            'titulo_curso' => $course['titulo_curso'],
            'imagen_curso' => $imagen_curso,
            'precio_curso' => $course['precio_curso'],
            'niveles_curso' => $course['niveles_curso'],
            'manejo_precio_curso' => $course['manejo_precio_curso'],
            'descripcion_curso' => $course['descripcion_curso']
        ];
    }

    public function obtenerPrecioCursosYNiveles()
    {
        // Obtener el título del curso desde la URL
        $titulo = isset($_GET['titulo']) ? trim($_GET['titulo']) : '';
        $_SESSION['titulo_curso'] = $titulo;

        // Verificar si el curso existe
        $course = $this->courseModel->checkCourseExists($titulo);

        if (!$course) {
            throw new Exception('El curso no existe.');
        }

        $id_curso = $course['id_curso'];
        $niveles = $this->courseModel->obtenerNivelesPorCurso($id_curso);

        return is_array($niveles) ? $niveles : [];
    }


    public function Cursoinstructor()
    {
        $titulo_curso_finalizado = isset($_GET['titulo']) ? trim($_GET['titulo']) : '';

        if (empty($titulo_curso_finalizado)) {
            return ['error' => 'Error: Título del curso no proporcionado.'];
        }

        $course = $this->courseModel->ObtenerCursoPorTitulo($titulo_curso_finalizado);

        if (!$course) {
            return ['error' => 'Error: Curso no encontrado.'];
        }

        $id_instructo = $course['id_instructor_creacion_curso'] ?? null;

        $Instructor = $this->courseModel->ObtenerinfoInstructor($id_instructo);

        return [
            'id_usuario' => $Instructor['id_usuario'],
            'nombre_usuario' => $Instructor['nombre_usuario']
        ];
    }


    public function Insertarcomentario()
    {
        // Obtener los datos del formulario POST    
        $id_estudiante = $_SESSION['usuario']['id_usuario'] ?? null;
        $estrellas = $_POST['star'] ?? null;
        $Comentarios = $_POST['Comentario'] ?? null;

        // Obtener el título del curso desde el parámetro POST
        $titulo_curso_finalizado = isset($_POST['titulo']) ? trim($_POST['titulo']) : '';

        if (empty($titulo_curso_finalizado)) {
            echo 'Error: Título no encontrado o datos inválidos.';
            exit;
        }

        // Obtener el curso por el título
        $course = $this->courseModel->ObtenerCursoPorTitulo($titulo_curso_finalizado);

        if (!$course) {
            echo 'Error: Curso no encontrado.';
            exit;
        }

        // Obtener el ID del curso
        $id_curso = $course['id_curso'];

        // Insertar el comentario en la base de datos a través del modelo
        $resultado = $this->courseModel->ModeloInsertarComentario(
            $Comentarios,
            $id_curso,
            $id_estudiante,
            $estrellas
        );

        if ($resultado) {
            echo "<script>alert('Comentario registrado correctamente.'); window.location.href = '../HTML/curso_finalizado.php?titulo=" . urlencode($titulo_curso_finalizado) . "';</script>";
        } else {
            echo "<script>alert('Comentario registrado correctamente.'); window.location.href = '../HTML/curso_finalizado.php?titulo=" . urlencode($titulo_curso_finalizado) . "';</script>";
        }
    }

    public function Insertardiploma()
    {
        // Obtener los datos del formulario POST    
        $id_estudiante = $_SESSION['usuario']['id_usuario'] ?? null;
        $id_instructor = $_POST['id_instructor'] ?? null;
        $id_curso = $_POST['id_curso'] ?? null;
        $titulo = $_POST['titulo'] ?? null;

        // Insertar el comentario en la base de datos a través del modelo
        $resultado = $this->courseModel->insertar_diploma(
            $id_curso,
            $id_estudiante,
            $id_instructor
        );

        if ($resultado) {
            echo "<script>alert('diploma listo.'); window.location.href = '../HTML/curso_finalizado.php?titulo=" . urlencode($titulo) . "';</script>";
        } else {
            echo "<script>alert('diploma listo.'); window.location.href = '../HTML/curso_finalizado.php?titulo=" . urlencode($titulo) . "';</script>";
        }
    }

    public function MostrarCurso()
    {
        // Obtener el título del curso desde los parámetros
        $titulo = isset($_GET['titulo']) ? trim($_GET['titulo']) : '';

        // Obtener el curso desde el modelo
        $course = $this->courseModel->checkCourseExists($titulo);

        // Validar que se encontró el curso
        if (!$course || !is_array($course)) {
            return [
                'error' => 'No se encontró información para el curso seleccionado.',
            ];
        }

        // Validar si la imagen del curso está disponible
        $imagen_curso = isset($course['imagen_curso']) ? base64_encode($course['imagen_curso']) : null;

        // Obtener datos del usuario
        $tipo_usuario = isset($_SESSION['usuario']['tipo_usuario']) ? $_SESSION['usuario']['tipo_usuario'] : null;

        return [
            'titulo_curso' => $course['titulo_curso'] ?? 'Sin título',
            'imagen_curso' => $imagen_curso,
            'niveles_curso' => $course['niveles_curso'] ?? 'No especificado',
            'manejo_precio_curso' => $course['manejo_precio_curso'] ?? 0,
            'precio_curso' => $course['precio_curso'] ?? 0,
            'descripcion_curso' => $course['descripcion_curso'] ?? 'Sin descripción',
            'tipo_usuario' => $tipo_usuario,
        ];
    }

    public function Mostrar_comentarios()
    {
        $id_estudiante = $_SESSION['usuario']['id_usuario'] ?? null;
        $titulo = isset($_GET['titulo']) ? trim($_GET['titulo']) : null;

        if (!$titulo) {
            echo 'Error: Título no proporcionado o inválido.';
            return [];
        }

        $course = $this->courseModel->ObtenerCursoPorTitulo($titulo);
        if (!$course) {
            echo 'Error: Curso no encontrado.';
            return [];
        }

        $id_curso = $course['id_curso'] ?? null;
        if (!$id_curso) {
            echo 'Error: ID del curso no encontrado.';
            return [];
        }

        // Obtener todos los comentarios relacionados con el curso
        $comentarios = $this->courseModel->Obtenerinfocomentarios($id_curso);

        // Devuelve un array de comentarios o vacío
        return is_array($comentarios) ? $comentarios : [];
    }

    public function Borrar_comentario()
    {
        $id_administrador = $_SESSION['usuario']['id_usuario'] ?? null;
        $razon_borrar = $_POST['razon-borrar'] ?? null;
        $id_comentario = $_POST['comentario_id'] ?? null;

        if (!$id_comentario) {
            echo "<script>alert('Falta el id_comentario.');</script>";
            return;
        }

        if (!$razon_borrar) {
            echo "<script>alert('Falta la razon.');</script>";
            return;
        }

        if (!$id_administrador) {
            echo "<script>alert('Falta el id administrador.');</script>";
            return;
        }

        // Llama al método en el modelo
        $this->courseModel->eliminarComentario($id_comentario, $razon_borrar, $id_administrador);

        echo "<script>alert('Se elimino el comentario.'); window.location.href = '../HTML/index.php';</script>";
        return;
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
        case 'Desactivarcurso':
            $controller->Desactivar_curso();
            break;
        case 'ActivarCurso':
            $controller->Activar_Curso();
            break;
        case 'Alumnos_Cursos':
            $controller->AlumnosCursos();
            break;
        case 'Insertar_comentario':
            $controller->Insertarcomentario();
            break;
        case 'Curso_finalizado':
            $controller->Cursofinalizado();
            break;
        case 'BorrarComentario':
            $controller->Borrar_comentario();
            break;
        case 'Insertar_diploma':
            $controller->Insertardiploma();
            break;
        case 'actualizarprogreso':
            $controller->actualizar_progreso();
            break;
        case 'Nivel_completado':
            $controller->NivelCompletado();
            break;
        case 'ActualizarUltimoIngreso':
            $controller->Actualizar_UltimoIngreso();
            break;
    }
}
