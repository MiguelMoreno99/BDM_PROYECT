-- insertar comentarios

DELIMITER $$

CREATE PROCEDURE PROCAgregarComentario(
    IN p_descripcion_comentario VARCHAR(255),
    IN p_id_curso_comentario INT,
    IN p_id_estudiante_comentario INT,
    IN p_calificacion_curso INT
)
BEGIN
    -- Insertar el nuevo comentario en la tabla
    INSERT INTO tabla_comentarios (
        descripcion_comentario,
        id_curso_comentario,
        id_estudiante_comentario,
        calificacion_curso
    ) VALUES (
        p_descripcion_comentario,
        p_id_curso_comentario,
        p_id_estudiante_comentario,
        p_calificacion_curso
    );
END$$

DELIMITER ;

-- Mostrar Comentarios

DELIMITER $$

CREATE PROCEDURE PROCObtenerComentariosConUsuario (
    IN p_id_curso INT
)
BEGIN
    SELECT 
        c.id_comentario,
        c.descripcion_comentario,
        c.id_curso_comentario,
        c.id_estudiante_comentario,
        c.calificacion_curso,
        c.comentario_eliminado,
        c.fecha_creacion_comentario,
        c.fecha_eliminacion_comentario,
        c.causa_eliminacion_comentario,
        c.id_administrador_eliminacion_comentario,
        u.nombre_usuario,
        u.apellido_paterno,
        u.apellido_materno,
        u.correo_usuario,
        u.tipo_usuario,
        u.usuario_bloqueado
    FROM 
        tabla_comentarios c
    INNER JOIN 
        tabla_usuario u
    ON 
        c.id_estudiante_comentario = u.id_usuario
    WHERE 
		c.id_curso_comentario = p_id_curso;
END $$

DELIMITER ;

--CALL PROCObtenerComentariosConUsuario(4);

-- Borrar comentario

DELIMITER //

CREATE PROCEDURE PROCEliminarComentario (
    IN p_id_comentario INT,                      -- ID del comentario a eliminar
    IN p_causa_eliminacion VARCHAR(255),         -- Causa de la eliminación
    IN p_id_administrador INT                    -- ID del administrador que realiza la acción
)
BEGIN
    -- Actualizar el comentario directamente
    UPDATE tabla_comentarios
    SET 
        comentario_eliminado = 1, 
        causa_eliminacion_comentario = p_causa_eliminacion,
        fecha_eliminacion_comentario = NOW(), 
        id_administrador_eliminacion_comentario = p_id_administrador
    WHERE id_comentario = p_id_comentario;
END //

DELIMITER ;

--CALL PROCEliminarComentario(3, 'Contenido ofensivo', 15);