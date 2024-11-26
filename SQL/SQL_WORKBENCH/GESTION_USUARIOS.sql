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
        (p_registro_usuario IS NULL OR registro_usuario = p_registro_usuario)
        AND
        (p_id_usuario IS NULL OR id_usuario = p_id_usuario)
        AND 
		(p_nombre_usuario IS NULL OR nombre_usuario = p_nombre_usuario)
        AND
        (p_correo_usuario IS NULL OR correo_usuario = p_correo_usuario)
        AND 
        (p_usuario_bloqueado IS NULL OR usuario_bloqueado = p_usuario_bloqueado)
        AND
        ((p_tipo_usuario IS NULL AND tipo_usuario <> 3) OR (p_tipo_usuario IS NOT NULL AND tipo_usuario = p_tipo_usuario));
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
SELECT * FROM tabla_usuario;
CALL PROCInsertarMensaje(4,1,"hola",now());

DELIMITER $$

CREATE PROCEDURE PROCInsertarNivelInscripcion(
    IN p_id_inscripcion INT,
    IN p_id_nivel INT,
    IN p_titulo_nivel VARCHAR(255)
)
BEGIN
    INSERT INTO tabla_niveles_inscripcion (id_inscripcion, id_nivel, titulo_nivel) 
    VALUES (p_id_inscripcion, p_id_nivel, p_titulo_nivel);
        
END$$

DELIMITER ;


