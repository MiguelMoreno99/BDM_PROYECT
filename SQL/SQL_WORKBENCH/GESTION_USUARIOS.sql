-- Procedures

-- Gestion de usuario

DELIMITER //

CREATE PROCEDURE PROCGestiondeadmin
(
    IN p_registro_usuario DATE,
    IN p_id_usuario INT,
    IN p_nombre_usuario VARCHAR(255),
    IN p_correo_usuario VARCHAR(255),
    IN p_usuario_bloqueado TINYINT(1),
    IN p_tipo_usuario INT
)
BEGIN
    SELECT 
        id_usuario,
        nombre_usuario,
        apellido_paterno,
        correo_usuario,
        registro_usuario,
        usuario_bloqueado
    FROM 
        tabla_usuario
    WHERE 
        (p_registro_usuario IS NULL OR DATE(registro_usuario) = p_registro_usuario)
        AND (p_id_usuario IS NULL OR id_usuario = p_id_usuario)
        AND (p_nombre_usuario IS NULL OR nombre_usuario LIKE CONCAT('%', p_nombre_usuario, '%'))
        AND (p_correo_usuario IS NULL OR correo_usuario LIKE CONCAT('%', p_correo_usuario, '%'))
        AND (p_usuario_bloqueado IS NULL OR usuario_bloqueado = p_usuario_bloqueado)
        AND (p_tipo_usuario IS NULL OR tipo_usuario = p_tipo_usuario);
END //

DELIMITER ;

       

-- Bloquear Usuario

DELIMITER //
CREATE PROCEDURE PROCBloquearUsuario
(
    IN p_id_usuario INT
)
BEGIN
       UPDATE tabla_usuario
       set 
       usuario_bloqueado = 1,
	   equivocaciones_usuario = 0
       Where id_usuario = p_id_usuario;
END //
DELIMITER ;   

-- Desbloquear Usuario

DELIMITER //
CREATE PROCEDURE PROCDesbloquearUsuario
(
    IN p_id_usuario INT
)
BEGIN
       UPDATE tabla_usuario
       set 
       usuario_bloqueado = 0,
	   equivocaciones_usuario = 0
       Where id_usuario = p_id_usuario;
END //
DELIMITER ;    

-- Verificar Usuario Bloqueado

DELIMITER //
CREATE PROCEDURE PROCVerificarbloqueado
(
    IN p_correo_usuario VARCHAR(255),       
    IN p_contrasenia_usuario VARCHAR(255)   
)
BEGIN
    SELECT 
			id_usuario,
			tipo_usuario,
			usuario_bloqueado,
			registro_usuario,
			equivocaciones_usuario
    FROM 
        tabla_usuario
    WHERE 
        correo_usuario = p_correo_usuario
        AND contrasenia_usuario = p_contrasenia_usuario;
END //
DELIMITER ;

-- Validar correo

DELIMITER //
CREATE PROCEDURE PROCValidarcorreo
(   
    IN p_correo_usuario VARCHAR(255)   
)
BEGIN
    SELECT 
			id_usuario,
			nombre_usuario,
			apellido_paterno,
			apellido_materno,
            correo_usuario
    FROM 
        tabla_usuario
    WHERE 
        correo_usuario = p_correo_usuario;
END //
DELIMITER ;

-- Reiniciar intentos

DELIMITER //
CREATE PROCEDURE PROCReiniciarintentos
(
    IN p_correo_usuario VARCHAR(255),
    IN p_contrasenia_usuario VARCHAR(255)  
)
BEGIN
    UPDATE tabla_usuario 
    SET 
      usuario_bloqueado = 0,
      equivocaciones_usuario = 0
    WHERE correo_usuario = p_correo_usuario AND  contrasenia_usuario = p_contrasenia_usuario; 

END //
DELIMITER ;

-- Intentos de contraseña 

DELIMITER //
CREATE PROCEDURE PROCIntentosContra
(
    IN p_correo_usuario VARCHAR(255)
)
BEGIN
    DECLARE current_equivocaciones INT;

    -- Obtener el nÃºmero actual de equivocaciones del usuario
    SELECT equivocaciones_usuario 
    INTO current_equivocaciones
    FROM tabla_usuario 
    WHERE correo_usuario = p_correo_usuario;

    -- Verificar si ya tiene 2 intentos fallidos (el siguiente serÃ¡ el tercer intento fallido)
    IF current_equivocaciones >= 2 THEN
        -- Si ya tiene 2 intentos fallidos, se bloquea al usuario y se reinician los intentos fallidos a 0
        UPDATE tabla_usuario 
        SET 
            usuario_bloqueado = 1, 
            equivocaciones_usuario = 0 
    WHERE correo_usuario = p_correo_usuario;
    ELSE
        -- Si tiene menos de 3 intentos, se incrementa el contador de intentos fallidos
        UPDATE tabla_usuario 
        SET 
            equivocaciones_usuario = equivocaciones_usuario + 1
       WHERE correo_usuario = p_correo_usuario;
    END IF;

END //
DELIMITER ;

-- Iniciar sesion

DELIMITER ;;
CREATE PROCEDURE PROCIniciarSesion
(
    IN p_correo_usuario VARCHAR(255),       
    IN p_contrasenia_usuario VARCHAR(255)   
)
BEGIN
    SELECT 
			id_usuario,
			tipo_usuario,
			imagen_usuario,
			usuario_bloqueado,
			nombre_usuario,
			apellido_paterno,
			apellido_materno,
			genero_usuario,
			nacimiento_usuario,
			correo_usuario,
			contrasenia_usuario,
			registro_usuario,
			equivocaciones_usuario
    FROM 
        tabla_usuario
    WHERE 
        correo_usuario = p_correo_usuario
        AND contrasenia_usuario = p_contrasenia_usuario;
END ;;
DELIMITER ;

-- Editar usuario

DELIMITER //
CREATE PROCEDURE PROCEditarUsuario
(
    IN p_id_usuario INT,  -- Buscamos por ID de usuario (parÃ¡metro renombrado)
    IN p_imagen_usuario LONGBLOB,
    IN p_nombre_usuario VARCHAR(50),
    IN p_apellido_paterno_usuario VARCHAR(50),
    IN p_apellido_materno_usuario VARCHAR(50),
    IN p_correo_usuario VARCHAR(255),
    IN p_contrasenia_usuario VARCHAR(255)  
)
BEGIN
    -- Actualizar los datos del usuario especÃ­fico donde el ID coincida
    UPDATE tabla_usuario 
    SET 
        imagen_usuario = p_imagen_usuario,
        nombre_usuario = p_nombre_usuario, 
        apellido_paterno = p_apellido_paterno_usuario, 
        apellido_materno = p_apellido_materno_usuario,
        correo_usuario = p_correo_usuario,
        contrasenia_usuario = p_contrasenia_usuario
    WHERE id_usuario = p_id_usuario;  -- Usamos el parÃ¡metro renombrado para evitar confusiÃ³n

END //
DELIMITER ;

-- Alta de usuario

DELIMITER //
CREATE PROCEDURE PROCAltaUsuario
(
	IN tipo_usuario INT,	
	IN imagen_usuario longblob,
	IN nombre_usuario VARCHAR(50),
	IN apellido_paterno VARCHAR(50),
	IN apellido_materno VARCHAR(50),
	IN genero_usuario int,
	IN nacimiento_usuario date,
	IN correo_usuario VARCHAR(255),
	IN contrasenia_usuario VARCHAR(255)
)
BEGIN
    -- Insert the new user
    INSERT INTO tabla_usuario(tipo_usuario, imagen_usuario, nombre_usuario, apellido_paterno, apellido_materno, genero_usuario, nacimiento_usuario,
    correo_usuario, contrasenia_usuario, registro_usuario)
    VALUES (tipo_usuario, imagen_usuario, nombre_usuario, apellido_paterno, apellido_materno, genero_usuario, nacimiento_usuario,
    correo_usuario, contrasenia_usuario, registro_usuario);

END //
DELIMITER ;

-- Procedure Traer_usuarios_Chat

DELIMITER $$

CREATE PROCEDURE PROCBuscarUsuarios_CHAT
(
    IN p_termino_busqueda VARCHAR(255)
)
BEGIN
    SELECT 
        id_usuario, 
        nombre_usuario, 
        apellido_paterno, 
        apellido_materno,
        tipo_usuario
    FROM tabla_usuario
    WHERE 
        (nombre_usuario LIKE CONCAT('%', p_termino_busqueda, '%'))
        OR (apellido_paterno LIKE CONCAT('%', p_termino_busqueda, '%'))
        OR (apellido_materno LIKE CONCAT('%', p_termino_busqueda, '%'));
END$$

DELIMITER ;

-- Procedure traer_mensajes

DELIMITER $$

CREATE PROCEDURE PROCObtenerMensajes_Chat
(
    IN p_usuario1 INT, -- Primer usuario
    IN p_usuario2 INT  -- Segundo usuario
)
BEGIN
    SELECT 
        id_mensaje,
        texto_mensaje,
        id_usuario1_mensaje,
        id_usuario2_mensaje,
        fecha_creacion_mensaje
    FROM 
        tabla_mensajes
    WHERE 
        (id_usuario1_mensaje = p_usuario1 AND id_usuario2_mensaje = p_usuario2)
        OR (id_usuario1_mensaje = p_usuario2 AND id_usuario2_mensaje = p_usuario1)
    ORDER BY fecha_creacion_mensaje ASC; -- Ordenar por fecha de creación
END$$

DELIMITER ;

-- Procedure Insertar_mensajes

DELIMITER $$

CREATE PROCEDURE PROCInsertarMensaje
(
    IN p_id_usuario1 INT,           -- ID del usuario que envía el mensaje
    IN p_id_usuario2 INT,           -- ID del usuario que recibe el mensaje
    IN p_texto_mensaje VARCHAR(255),-- El texto del mensaje
    IN p_fecha_creacion DATETIME    -- Fecha de creación del mensaje
)
BEGIN
    -- Insertar el mensaje en la tabla de mensajes
    INSERT INTO tabla_mensajes (texto_mensaje, id_usuario1_mensaje, id_usuario2_mensaje, fecha_creacion_mensaje)
    VALUES (p_texto_mensaje, p_id_usuario1, p_id_usuario2, p_fecha_creacion);
    
END$$

DELIMITER ;

-- CREATE PROCEDURE PROCInsertarNivelInscripcion(
--     IN p_id_inscripcion INT,
--     IN p_id_nivel INT,
--     IN p_titulo_nivel VARCHAR(255)
-- )
-- BEGIN
--     INSERT INTO tabla_niveles_inscripcion (id_inscripcion, id_nivel, titulo_nivel) 
--     VALUES (p_id_inscripcion, p_id_nivel, p_titulo_nivel)
--         
-- END $$

DELIMITER ;

-- Informacion del curso instructores

DELIMITER $$

-- CREATE PROCEDURE GetCursoInfo(
--     IN start_date DATETIME,         -- Fecha inicial del rango
--     IN end_date DATETIME,           -- Fecha final del rango
--     IN category_name VARCHAR(255),  -- Nombre de la categoría (puede ser NULL para no filtrar)
--     IN curso_deshabilitado INT,     -- Filtro de cursos deshabilitados (puede ser NULL para no filtrar)
--     IN ID_Instructor INT            -- ID del instructor (puede ser NULL para no filtrar)
-- )
-- BEGIN
--     SELECT 
--         c.nombre_categoria AS Categoria,
--         cr.titulo_curso AS Curso,
--         cr.curso_deshabilitado AS CursoDeshabilitado,
--         cr.fecha_creacion_curso AS FechaCreacion,
--         COUNT(i.id_inscripcion) AS TotalAlumnos,
--         COALESCE(AVG(i.porcentaje_avance_curso), 0) AS PromedioAvance
--     FROM 
--         tabla_categorias c
--     INNER JOIN 
--         tabla_cursos cr ON c.id_categoria = cr.id_categoria_curso
--     LEFT JOIN 
--         tabla_inscripciones i ON cr.id_curso = i.id_curso_inscripcion
--     WHERE 
--         (start_date IS NULL OR cr.fecha_creacion_curso >= start_date) AND
--         (end_date IS NULL OR cr.fecha_creacion_curso <= end_date) AND
--         (category_name IS NULL OR c.nombre_categoria = category_name) AND
--         (curso_deshabilitado IS NULL OR cr.curso_deshabilitado = curso_deshabilitado) AND
--         (ID_Instructor IS NULL OR cr.id_instructor_creacion_curso = ID_Instructor)
--     GROUP BY 
--         c.nombre_categoria, cr.titulo_curso, cr.curso_deshabilitado, cr.fecha_creacion_curso
--     ORDER BY 
--         cr.fecha_creacion_curso DESC;
-- END $$

DELIMITER ;


-- CALL GetCursoInfo('2024-11-23', NULL, 'Programación', 0);

-- Informacion del reporte de administradores

DELIMITER //

CREATE PROCEDURE PROCObtenerReporteUsuario1()
BEGIN
    SELECT 
        u.id_usuario AS ID_Usuario,
        CONCAT(u.nombre_usuario, ' ', u.apellido_paterno, ' ', u.apellido_materno) AS Nombre_Completo,
        u.registro_usuario AS Registro_Usuario,
        COUNT(c.id_curso) AS Numero_Cursos,
        COALESCE(SUM(c.precio_curso), 0) AS Total_Ganancias
    FROM 
        tabla_usuario u
    LEFT JOIN 
        tabla_cursos c 
        ON u.id_usuario = c.id_instructor_creacion_curso
    WHERE 
        u.tipo_usuario = 1
    GROUP BY 
        u.id_usuario, u.nombre_usuario, u.apellido_paterno, u.apellido_materno, u.nacimiento_usuario;
END //

DELIMITER ;

-- CALL PROCObtenerReporteUsuario1();

-- Informacion del reporte de estudiante

DELIMITER //

CREATE PROCEDURE PROCObtenerReporteUsuarios2()
BEGIN
    SELECT 
        u.id_usuario AS ID_Usuario,
        CONCAT(u.nombre_usuario, ' ', u.apellido_paterno, ' ', u.apellido_materno) AS Nombre_Completo,
        u.registro_usuario AS Registro_Usuario,
        COUNT(i.id_inscripcion) AS Numero_Cursos_Inscritos,
        ROUND(AVG(i.porcentaje_avance_curso), 2) AS Porcentaje_Cursos_Completados
    FROM 
        tabla_usuario u
    LEFT JOIN 
        tabla_inscripciones i ON u.id_usuario = i.id_estudiante_inscripcion
    WHERE 
        u.tipo_usuario = 2 -- Filtra solo estudiantes
    GROUP BY 
        u.id_usuario, u.nombre_usuario, u.apellido_paterno, u.apellido_materno, u.nacimiento_usuario;
END //

DELIMITER ;

-- CALL PROCObtenerReporteUsuarios2();

-- Obtener informacion para la busqueda

DELIMITER //

CREATE PROCEDURE PROCObtenerCursosBusqueda(
    IN filtro_titulo_curso VARCHAR(255),         -- Filtro por título del curso
    IN filtro_nombre_categoria VARCHAR(255),     -- Filtro por nombre de la categoría
    IN filtro_nombre_instructor VARCHAR(255),    -- Filtro por nombre del instructor
    IN fecha_inicio DATE,                        -- Fecha de creación inicio
    IN fecha_fin DATE                            -- Fecha de creación fin
)
BEGIN
    SELECT 
        c.id_curso AS ID_Curso,
        c.titulo_curso AS Titulo_Curso,
        cat.nombre_categoria AS Nombre_Categoria,
        CONCAT(u.nombre_usuario, ' ', u.apellido_paterno, ' ', u.apellido_materno) AS Nombre_Instructor,
        c.niveles_curso AS Niveles,
        c.precio_curso AS Precio,
        c.imagen_curso AS Imagen,
        c.porcentaje_resenas_positivas AS Porcentaje_Resenas_Positivas,
        c.fecha_creacion_curso AS Fecha_Creacion,
        c.descripcion_curso AS Descripcion
    FROM 
        tabla_cursos c
    LEFT JOIN 
        tabla_categorias cat ON c.id_categoria_curso = cat.id_categoria
    LEFT JOIN 
        tabla_usuario u ON c.id_instructor_creacion_curso = u.id_usuario
    WHERE 
        c.curso_deshabilitado = 0 AND
        (filtro_titulo_curso IS NULL OR c.titulo_curso LIKE CONCAT('%', filtro_titulo_curso, '%')) AND
        (filtro_nombre_categoria IS NULL OR cat.nombre_categoria LIKE CONCAT('%', filtro_nombre_categoria, '%')) AND
        (filtro_nombre_instructor IS NULL OR 
            CONCAT(u.nombre_usuario, ' ', u.apellido_paterno, ' ', u.apellido_materno) LIKE CONCAT('%', filtro_nombre_instructor, '%')) AND
        (fecha_inicio IS NULL OR c.fecha_creacion_curso >= fecha_inicio) AND
        (fecha_fin IS NULL OR c.fecha_creacion_curso <= fecha_fin)
    ORDER BY 
        c.fecha_creacion_curso DESC;
END //

DELIMITER ;


-- CALL PROCObtenerCursosBusqueda(NULL, NULL, NULL, '2024-11-22', NULL);