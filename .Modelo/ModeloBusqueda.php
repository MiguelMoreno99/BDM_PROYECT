<?php

require_once '../PHP/database.php';

class Modelo_Busqueda
{
    private $db;

    public function __construct($config)
    {
        $this->db = new Database($config);
    }

    public function Busqueda_avanzada($titulo_curso, $nombre_categoria, $nombre_creador, $fecha_inicio, $fecha_fin)
    {
        $params = [
            $titulo_curso ?: null,
            $nombre_categoria ?: null,
            $nombre_creador ?: null,
            $fecha_inicio ?: null,
            $fecha_fin ?: null
        ];

        $stmt = $this->db->callProcedure('PROCObtenerCursosBusqueda', $params);

        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $stmt->closeCursor();

        return $result;
    }

}