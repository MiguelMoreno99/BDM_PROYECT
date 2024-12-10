<?php

require_once '../.Modelo/ModeloBusqueda.php';
session_start();

class BusquedaController
{
    private $busquedaModel;

    public function __construct($config)
    {
        $this->busquedaModel = new Modelo_Busqueda($config);
    }

    public function GetBusqueda_avanzada()
    {
        // Recibir filtros del formulario
        $titulo_curso = $_POST['Busqueda_curso'] ?? null;
        $nombre_categoria = $_POST['Buscar_categoria'] ?? null;
        $nombre_creador = $_POST['Buscar_creador'] ?? null;
        $fecha_inicio = $_POST['fecha_inicio'] ?? null;
        $fecha_fin = $_POST['fecha_fin'] ?? null;

        // Obtener los resultados usando el modelo
        $resultados = $this->busquedaModel->Busqueda_avanzada(
            $titulo_curso,
            $nombre_categoria,
            $nombre_creador,
            $fecha_inicio,
            $fecha_fin
        );

        // Almacenar resultados en la sesión
        $_SESSION['busqueda_avanzda'] = $resultados;

        // Redirigir a la página de gestión
        header('Location: ../HTML/busqueda.php');
        exit();
    }
}

// Uso en index.php:
$config = require '../PHP/config.php';
$controller = new BusquedaController($config);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    switch ($_POST['accion']) {
        case 'Getbusqueda':
            $controller->GetBusqueda_avanzada();
            break;
    }
}
