<?php

require_once '../PHP/database.php';

class Modelo_Curso
{
    private $db;

    public function __construct($config)
    {
        $this->db = new Database($config);
    }

    public function registerCourse($CourseData)
    {
        $stmt = $this->db->callProcedure('PROCAltaCurso', $CourseData);
        $stmt->closeCursor();
    }

    public function registerLevel($LevelData)
    {
        $stmt = $this->db->callProcedure('PROCAltaNivel', $LevelData);
        $stmt->closeCursor();
    }

    public function extraerIdDeGoogleDrive($url) {
        // Expresión regular para buscar el ID
        $patron = '/\/folders\/([a-zA-Z0-9_-]+)/';
        
        // Buscar coincidencias
        if (preg_match($patron, $url, $coincidencias)) {
            return $coincidencias[1]; // El ID está en el primer grupo de captura
        }
        
        return null; // Retorna null si no se encuentra un ID válido
    }

    function extraerIdDeYouTube($url) {
        // Expresión regular para buscar el ID en el formato corto de YouTube
        $patron = '/youtu\.be\/([a-zA-Z0-9_-]+)/';
        
        // Buscar coincidencias
        if (preg_match($patron, $url, $coincidencias)) {
            return $coincidencias[1]; // El ID está en el primer grupo de captura
        }
        
        return null; // Retorna null si no se encuentra un ID válido
    }

    public function checkCourseExists($name_course)
    {
        $stmt = $this->db->callProcedure('PROCValidarCurso2', [$name_course]);
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        $stmt->closeCursor();
        return $result;
    }

    public function showAllCourses()
    {
        $stmt = $this->db->callProcedure('PROCMostrarCursos', []);
        return $stmt;
    }

    public function vista_cursos_mas_inscripciones()
    {
        $stmt = $this->db->callProcedure('GetCursosMasInscritos', []);
        return $stmt;
    }

    public function vista_Cursos_Mejor_Puntuados()
    {
        $stmt = $this->db->callProcedure('GetCursosMejorPuntuados', []);
        return $stmt;
    }




    public function showAllCoursesByCategory($id_category)
    {
        $stmt = $this->db->callProcedure('PROCMostrarCursosPorCategoria', [$id_category]);
        return $stmt;
    }

    public function showAllLevelsOfCourse($id_course)
    {
        $stmt = $this->db->callProcedure('PROCValidarNivelesCurso', [$id_course]);
        return $stmt;
    }

    public function DeleteCourse($CourseData)
    {
        $stmt = $this->db->callProcedure('PROCBorrarCurso', $CourseData);
        $stmt->closeCursor();
    }

    public function checkCategoryExists($category)
    {
        $stmt = $this->db->callProcedure('PROCValidarCategoria', [$category]);
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        $stmt->closeCursor();
        return $result;
    }

    public function obtenerNivelesPorCurso($id_curso)
    {
        $stmt = $this->db->callProcedure('PROCMostrarNivelesPorCurso', [$id_curso]);
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $stmt->closeCursor();
        return $result;
    }

    public function obtenerInscripcion($id_curso, $id_usuario)
    {
        $stmt = $this->db->callProcedure('PROCObtenerInscripciones', [$id_curso, $id_usuario]);
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        $stmt->closeCursor();
        return $result;
    }

    public function obtenerNivelesInscrpcion($id_inscripcion)
    {
        $stmt = $this->db->callProcedure('PROCObtenerNivelesPorInscripcion', [$id_inscripcion]);
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $stmt->closeCursor();

        // Codificar las imágenes BLOB en Base64
        foreach ($result as &$nivel) {
            if (!empty($nivel['imagen_nivel'])) {
                $nivel['imagen_nivel'] = 'data:image/jpeg;base64,' . base64_encode($nivel['imagen_nivel']);
            }
        }

        return $result;
    }

    public function registerInscripcion($InscripcionData)
    {
        $stmt = $this->db->callProcedure('PROCInsertarInscripcion', $InscripcionData);
        $stmt->closeCursor();
    }

    public function registerInscripcion_niveles($InscripcionData)
    {
        $stmt = $this->db->callProcedure('PROCInsertarNivelInscripcion', $InscripcionData);
        $stmt->closeCursor();
    }

    public function checkInscripcionExista($ID_Estudiante, $ID_Curso)
    {
        $stmt = $this->db->callProcedure('PROCValidarInscripcion', [$ID_Estudiante, $ID_Curso]);
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        $stmt->closeCursor();
        return $result;
    }

    public function getCoursesByStudent($id_student)
    {
        $stmt = $this->db->callProcedure('PROCObtenerInformacionCurso', [$id_student]); // Llama al procedimiento con el ID del estudiante
        $courses = $stmt->fetchAll(PDO::FETCH_ASSOC); // Obtiene todos los resultados
        $stmt->closeCursor(); // Libera el cursor
        return $courses; // Retorna los cursos
    }

    public function GetCursoInfo($start_date, $end_date, $category_name, $curso_deshabilitado, $ID_Instructor)
    {
        $params = [
            $start_date ?: null,
            $end_date ?: null,
            $category_name ?: null,
            $curso_deshabilitado ?: null,
            $ID_Instructor ?: null,
        ];

        $stmt = $this->db->callProcedure('GetCursoInfo', $params);

        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $stmt->closeCursor();

        return $result;
    }

    public function GetCursoAlumno($ID_Curso)
    {
        $params = [
            $ID_Curso ?: null,
        ];

        $stmt = $this->db->callProcedure('ObtenerDatosInscripcionPorCurso', $params);

        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $stmt->closeCursor();

        return $result;
    }

    public function DeshabilitarCurso($ID_Curso)
    {
        $params = [
            $ID_Curso ?: null,
        ];

        $stmt = $this->db->callProcedure('DeshabilitarCurso', $params);

        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $stmt->closeCursor();

        return $result;
    }

    public function HabilitarCurso($ID_Curso)
    {
        $params = [
            $ID_Curso ?: null,
        ];

        $stmt = $this->db->callProcedure('HabilitarCurso', $params);

        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $stmt->closeCursor();

        return $result;
    }

    public function GetEstudianteInfo($id_estudiante, $fecha_inscripcion, $ultima_fecha, $nombre_categoria, $inscripcion_finalizada, $estado)
    {
        $params = [
            $id_estudiante ?: null,
            $fecha_inscripcion ?: null,
            $ultima_fecha ?: null,
            $nombre_categoria ?: null,
            $inscripcion_finalizada ?: null,
            $estado ?: null
        ];

        // Llamar al procedimiento almacenado para obtener los resultados
        $stmt = $this->db->callProcedure('GetDetallesCursoPorEstudianteConFechas', $params);

        // Obtener los resultados y cerrar el cursor
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $stmt->closeCursor();

        return $result;
    }

    public function ObtenerCursoPorTitulo($name_course)
    {
        $stmt = $this->db->callProcedure('PROCObtenerCursoPorTitulo', [$name_course]);
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        $stmt->closeCursor();
        return $result;
    }

    public function ModeloInsertarComentario($comentario, $id_curso, $id_estudiante, $estrellas)
    {
        $parametros = [
            $comentario,
            $id_curso,
            $id_estudiante,
            $estrellas,
        ];

        // Llama al procedimiento almacenado
        return $this->db->callProcedure('PROCAgregarComentario', $parametros);
    }

    public function Obtenerinfocomentarios($id_curso)
    {
        $stmt = $this->db->callProcedure('PROCObtenerComentariosConUsuario', [$id_curso]);
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $stmt->closeCursor();
        return $result ?: [];
    }

    public function eliminarComentario($id_comentario, $causa_eliminacion, $id_administrador)
    {
        $params = [
            $id_comentario,        // ID del comentario
            $causa_eliminacion,    // Razón de la eliminación
            $id_administrador      // ID del administrador
        ];

        // Llama al procedimiento almacenado
        $stmt = $this->db->callProcedure('PROCEliminarComentario', $params);
        $stmt->closeCursor(); // Libera el cursor
    }

    public function ObtenerinfoInstructor($id_instructor)
    {
        $stmt = $this->db->callProcedure('PROCObtener_usuario_por_id', [$id_instructor]);
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        $stmt->closeCursor();
        return $result;
    }

    public function insertar_diploma($id_curso, $id_estudiante, $id_instructor)
    {
        $params = [
            $id_curso,
            $id_estudiante,
            $id_instructor
        ];

        $stmt = $this->db->callProcedure('PROCInsertarDiploma', $params);
        $stmt->closeCursor();
    }

    public function ActualizarAvanceCurso($id_inscripcion, $porcentaje)
    {
        $params = [
            $id_inscripcion,
            $porcentaje
        ];

        $stmt = $this->db->callProcedure('PROCActualizarAvanceCurso', $params);
        $stmt->closeCursor();
    }

    public function Actualizarnivelterminado($id_inscripcion)
    {
        $params = [
            $id_inscripcion
        ];
        $stmt = $this->db->callProcedure('PROCActualizarNivelTerminado', $params);
        $stmt->closeCursor();
    }

    public function ActualizarUltimoIngreso($id_inscripcion)
    {
        $params = [
            $id_inscripcion
        ];
        $stmt = $this->db->callProcedure('ActualizarUltimoIngreso', $params);
        $stmt->closeCursor();
    }
}
