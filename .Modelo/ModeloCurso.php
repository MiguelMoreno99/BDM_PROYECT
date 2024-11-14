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
        $stmt = $this->db->callProcedure('PROCMostrarCursos',[]);
        return $stmt;
    }

    public function showAllCoursesByCategory($id_category)
    {
        $stmt = $this->db->callProcedure('PROCMostrarCursosPorCategoria',[$id_category]);
        return $stmt;
    }

    public function showAllLevelsOfCourse($id_course)
    {
        $stmt = $this->db->callProcedure('PROCValidarNivelesCurso',[$id_course]);
        return $stmt;
    }

    public function DeleteCourse($CourseData)
    {
        $stmt = $this->db->callProcedure('PROCBorrarCurso', $CourseData);
        $stmt->closeCursor();
    }
}
?>