<?php

class Database
{
    public $connection;

    public function __construct($config)
    {
        // Accede a la configuración de la base de datos
        $dbConfig = $config['database'];

        // Construir el DSN con los valores correctos
        $dsn = 'mysql:host=' . $dbConfig['host'] . ';dbname=' . $dbConfig['dbname'] . ';charset=utf8mb4;port=' . $dbConfig['port'];

        try {
            $this->connection = new PDO($dsn, $dbConfig['user'], $dbConfig['password']);
            $this->connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); // Manejo de errores
        } catch (PDOException $e) {
            // Manejar la excepción de conexión
            die("Connection failed: " . $e->getMessage());
        }
    }

    public function query($query)
    {
        $stmt = $this->connection->prepare($query);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function callProcedure($procedureName, $params)
    {
        $placeholders = implode(',', array_fill(0, count($params), '?'));
        $stmt = $this->connection->prepare("CALL $procedureName($placeholders)");
        $stmt->execute($params);
        return $stmt;
    }
}

?>            