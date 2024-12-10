<?php

require_once '../PHP/database.php';

class Modelo_Categoria
{
    private $db;

    public function __construct($config)
    {
        $this->db = new Database($config);
    }

    public function registerCategory($CategoryData)
    {
        $stmt = $this->db->callProcedure('PROCAltaCategoria', $CategoryData);
        $stmt->closeCursor();
    }

    public function editCategory($CategoryData)
    {
        $stmt = $this->db->callProcedure('PROCEditarCategoria', $CategoryData);
        $stmt->closeCursor();
    }

    public function checkCategoryExists($category)
    {
        $stmt = $this->db->callProcedure('PROCValidarCategoria', [$category]);
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        $stmt->closeCursor();
        return $result;
    }

    public function showAllCategorys()
    {
        $stmt = $this->db->callProcedure('PROCMostrarCategorias', []);
        return $stmt;
    }

    public function DeleteCategory($CategoryData)
    {
        $stmt = $this->db->callProcedure('EliminarCategoriaConCursos', $CategoryData);
        $stmt->closeCursor();
    }
}
