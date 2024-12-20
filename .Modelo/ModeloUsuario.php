<?php

require_once '../PHP/database.php';

class Modelo_Usuario
{
    private $db;

    public function __construct($config)
    {
        $this->db = new Database($config);
    }

    public function checkEmailExists($email)
    {
        $stmt = $this->db->callProcedure('PROCValidarcorreo', [$email]);
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        $stmt->closeCursor();
        return $result;
    }

    public function registerUser($userData)
    {
        $stmt = $this->db->callProcedure('PROCAltaUsuario', $userData);
        $stmt->closeCursor();
    }

    public function loginUser($email, $password)
    {
        $stmt = $this->db->callProcedure('PROCIniciarSesion', [$email, $password]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);
        $stmt->closeCursor();
        return $user;
    }

    public function checkBlockedStatus($email, $password)
    {
        $stmt = $this->db->callProcedure('PROCVerificarBloqueado', [$email, $password]);
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        $stmt->closeCursor();
        return $result;
    }

    public function incrementLoginAttempts($email)
    {
        $stmt = $this->db->callProcedure('PROCIntentosContra', [$email]);
        $stmt->closeCursor();
    }

    public function resetLoginAttempts($email, $password)
    {
        $stmt = $this->db->callProcedure('PROCReiniciarintentos', [$email, $password]);
        $stmt->closeCursor();
    }

    public function updateUser($userData)
    {
        $stmt = $this->db->callProcedure('PROCEditarUsuario', $userData);
        $stmt->closeCursor();
    }

    public function getGestionAdmin($registro_usuario, $id_usuario, $nombre_usuario, $correo_usuario, $usuario_bloqueado, $tipo_usuario)
    {
        $params = [
            $registro_usuario ?: null,
            $id_usuario ?: null,
            $nombre_usuario ?: null,
            $correo_usuario ?: null,
            $usuario_bloqueado ?: null,
            $tipo_usuario ?: null
        ];

        $stmt = $this->db->callProcedure('PROCGestiondeadmin', $params);

        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $stmt->closeCursor();

        return $result;
    }

    public function BloquearUsuario($id_usuario)
    {
        $stmt = $this->db->callProcedure('PROCBloquearUsuario', [$id_usuario]);
        $stmt->closeCursor();
    }

    public function DesbloquearUsuario($id_usuario)
    {
        $stmt = $this->db->callProcedure('PROCDesbloquearUsuario', [$id_usuario]);
        $stmt->closeCursor();
    }

    public function buscarUsuariosChat($terminoBusqueda)
    {
        $stmt = $this->db->callProcedure('PROCBuscarUsuarios_CHAT', [$terminoBusqueda]);
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $stmt->closeCursor();
        return $result;
    }

    public function obtenerMensajesEntreUsuarios($idUsuario1, $idUsuario2)
    {
        $stmt = $this->db->callProcedure('PROCObtenerMensajes_Chat', [$idUsuario1, $idUsuario2]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function insertarMensaje($id_usuario1, $id_usuario2, $texto_mensaje, $fecha_creacion)
    {

        // Llamamos al procedimiento para insertar el mensaje en la base de datos
        $stmt = $this->db->callProcedure('PROCInsertarMensaje', [
            $id_usuario1,
            $id_usuario2,
            $texto_mensaje,
            $fecha_creacion
        ]);
        // Cerrar el cursor de la consulta
        $stmt->closeCursor();
    }

    public function getReporteInstructor()
    {
        $stmt = $this->db->callProcedure('PROCObtenerReporteUsuario1', []);

        // Obtener todos los resultados
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

        // Cerrar el cursor para liberar recursos
        $stmt->closeCursor();

        // Retornar los resultados al controlador
        return $result;
    }

    public function getReporteEstudiante()
    {
        $stmt = $this->db->callProcedure('PROCObtenerReporteUsuarios2', []);

        // Obtener todos los resultados
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

        // Cerrar el cursor para liberar recursos
        $stmt->closeCursor();

        // Retornar los resultados al controlador
        return $result;
    }
}
