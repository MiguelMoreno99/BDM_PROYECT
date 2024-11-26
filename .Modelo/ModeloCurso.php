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

    public function checkCourseExists($name_course)
    {
        $stmt = $this->db->callProcedure('PROCValidarCurso', [$name_course]);
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        $stmt->closeCursor();
        return $result;
    }

    public function showAllCourses()
    {
        $stmt = $this->db->callProcedure('PROCMostrarCursos', []);
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

    public function registerInscripcion($InscripcionData)
    {
        $stmt = $this->db->callProcedure('PROCInsertarInscripcion', $InscripcionData);
        $stmt->closeCursor();
    }

    public function registerInscripcion_niveles($InscripcionData)
    {
        $stmt = $this->db->callProcedure('PROCInsertar_nivel_inscripcion', $InscripcionData);
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
}
?>