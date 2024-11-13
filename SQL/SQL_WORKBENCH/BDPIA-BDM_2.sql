create database db_leveluplearning;
use db_leveluplearning;
DROP TABLE IF EXISTS `tabla_categorias`;
CREATE TABLE `tabla_categorias` (
  `id_categoria` int NOT NULL AUTO_INCREMENT,
  `nombre_categoria` varchar(255) NOT NULL,
  `descripcion_categoria` varchar(255) NOT NULL,
  `imagen_categoria` longblob,
  `id_administrador_creador` int DEFAULT NULL,
  `fecha_creacion_categoria` datetime DEFAULT NULL,
  `categoria_eliminada` bit(1) DEFAULT b'0',
  `id_administrador_elimina_categoria` int DEFAULT NULL,
  `fecha_eliminacion_categoria` datetime DEFAULT NULL,
  PRIMARY KEY (`id_categoria`),
  KEY `id_administrador_creador` (`id_administrador_creador`),
  KEY `id_administrador_elimina_categoria` (`id_administrador_elimina_categoria`),
  CONSTRAINT `tabla_categorias_ibfk_1` FOREIGN KEY (`id_administrador_creador`) REFERENCES `tabla_usuario` (`id_usuario`),
  CONSTRAINT `tabla_categorias_ibfk_2` FOREIGN KEY (`id_administrador_elimina_categoria`) REFERENCES `tabla_usuario` (`id_usuario`)
);

DROP TABLE IF EXISTS `tabla_comentarios`;
CREATE TABLE `tabla_comentarios` (
  `id_comentario` int NOT NULL AUTO_INCREMENT,
  `descripcion_comentario` varchar(255) NOT NULL,
  `id_curso_comentario` int NOT NULL,
  `id_estudiante_comentario` int NOT NULL,
  `calificacion_curso` int NOT NULL,
  `comentario_eliminado` bit(1) DEFAULT b'0',
  `fecha_creacion_comentario` datetime DEFAULT NULL,
  `fecha_eliminacion_comentario` datetime DEFAULT NULL,
  `causa_eliminacion_comentario` varchar(255) DEFAULT NULL,
  `id_administrador_eliminacion_comentario` int DEFAULT NULL,
  PRIMARY KEY (`id_comentario`),
  KEY `id_curso_comentario` (`id_curso_comentario`),
  KEY `id_estudiante_comentario` (`id_estudiante_comentario`),
  KEY `id_administrador_eliminacion_comentario` (`id_administrador_eliminacion_comentario`),
  CONSTRAINT `tabla_comentarios_ibfk_1` FOREIGN KEY (`id_curso_comentario`) REFERENCES `tabla_cursos` (`id_curso`),
  CONSTRAINT `tabla_comentarios_ibfk_2` FOREIGN KEY (`id_estudiante_comentario`) REFERENCES `tabla_usuario` (`id_usuario`),
  CONSTRAINT `tabla_comentarios_ibfk_3` FOREIGN KEY (`id_administrador_eliminacion_comentario`) REFERENCES `tabla_usuario` (`id_usuario`)
);

DROP TABLE IF EXISTS `tabla_cursos`;
CREATE TABLE `tabla_cursos` (
  `id_curso` int NOT NULL AUTO_INCREMENT,
  `titulo_curso` varchar(255) NOT NULL,
  `id_categoria_curso` int DEFAULT NULL,
  `niveles_curso` int NOT NULL,
  `manejo_precio_curso` int NOT NULL,
  `precio_curso` float DEFAULT NULL,
  `descripcion_curso` varchar(100) DEFAULT NULL,
  `porcentaje_resenas_positivas` float DEFAULT '0',
  `imagen_curso` longblob,
  `curso_deshabilitado` bit(1) DEFAULT b'0',
  `fecha_creacion_curso` datetime DEFAULT NULL,
  `id_instructor_creacion_curso` int DEFAULT NULL,
  `id_instructor_eliminacion_curso` int DEFAULT NULL,
  `fecha_eliminacion_curso` datetime DEFAULT NULL,
  PRIMARY KEY (`id_curso`),
  KEY `id_categoria_curso` (`id_categoria_curso`),
  KEY `id_instructor_creacion_curso` (`id_instructor_creacion_curso`),
  KEY `id_instructor_eliminacion_curso` (`id_instructor_eliminacion_curso`),
  CONSTRAINT `tabla_cursos_ibfk_1` FOREIGN KEY (`id_categoria_curso`) REFERENCES `tabla_categorias` (`id_categoria`),
  CONSTRAINT `tabla_cursos_ibfk_2` FOREIGN KEY (`id_instructor_creacion_curso`) REFERENCES `tabla_usuario` (`id_usuario`),
  CONSTRAINT `tabla_cursos_ibfk_3` FOREIGN KEY (`id_instructor_eliminacion_curso`) REFERENCES `tabla_usuario` (`id_usuario`)
);

DROP TABLE IF EXISTS `tabla_diplomas`;
CREATE TABLE `tabla_diplomas` (
  `id_diploma` int NOT NULL AUTO_INCREMENT,
  `fecha_terminacion_diploma` datetime NOT NULL,
  `id_curso_diploma` int NOT NULL,
  `id_estudiante_diploma` int NOT NULL,
  `id_instructor_diploma` int NOT NULL,
  `imagen_curso_diploma` longblob,
  `promedio_diploma` float DEFAULT '0',
  PRIMARY KEY (`id_diploma`),
  KEY `id_curso_diploma` (`id_curso_diploma`),
  KEY `id_estudiante_diploma` (`id_estudiante_diploma`),
  KEY `id_instructor_diploma` (`id_instructor_diploma`),
  CONSTRAINT `tabla_diplomas_ibfk_1` FOREIGN KEY (`id_curso_diploma`) REFERENCES `tabla_cursos` (`id_curso`),
  CONSTRAINT `tabla_diplomas_ibfk_2` FOREIGN KEY (`id_estudiante_diploma`) REFERENCES `tabla_usuario` (`id_usuario`),
  CONSTRAINT `tabla_diplomas_ibfk_3` FOREIGN KEY (`id_instructor_diploma`) REFERENCES `tabla_usuario` (`id_usuario`)
);

DROP TABLE IF EXISTS `tabla_inscripciones`;
CREATE TABLE `tabla_inscripciones` (
  `id_inscripcion` int NOT NULL AUTO_INCREMENT,
  `id_estudiante_inscripcion` int NOT NULL,
  `id_curso_inscripcion` int NOT NULL,
  `fecha_inscripcion` datetime DEFAULT NULL,
  `ultima_fecha_ingreso` datetime DEFAULT NULL,
  `fecha_terminacion_inscripcion` datetime DEFAULT NULL,
  `inscripcion_finalizada` bit(1) DEFAULT b'0',
  `metodo_pago_inscripcion` int NOT NULL,
  `porcentaje_avance_curso` float DEFAULT '0',
  PRIMARY KEY (`id_inscripcion`),
  KEY `id_estudiante_inscripcion` (`id_estudiante_inscripcion`),
  KEY `id_curso_inscripcion` (`id_curso_inscripcion`),
  CONSTRAINT `tabla_inscripciones_ibfk_1` FOREIGN KEY (`id_estudiante_inscripcion`) REFERENCES `tabla_usuario` (`id_usuario`),
  CONSTRAINT `tabla_inscripciones_ibfk_2` FOREIGN KEY (`id_curso_inscripcion`) REFERENCES `tabla_cursos` (`id_curso`)
);

DROP TABLE IF EXISTS `tabla_mensajes`;
CREATE TABLE `tabla_mensajes` (
  `id_mensaje` int NOT NULL AUTO_INCREMENT,
  `texto_mensaje` varchar(255) NOT NULL,
  `id_curso_mensaje` int NOT NULL,
  `id_estudiante_mensaje` int NOT NULL,
  `id_instructor_mensaje` int NOT NULL,
  `fecha_creacion_mensaje` datetime DEFAULT NULL,
  PRIMARY KEY (`id_mensaje`),
  KEY `id_curso_mensaje` (`id_curso_mensaje`),
  KEY `id_estudiante_mensaje` (`id_estudiante_mensaje`),
  KEY `id_instructor_mensaje` (`id_instructor_mensaje`),
  CONSTRAINT `tabla_mensajes_ibfk_1` FOREIGN KEY (`id_curso_mensaje`) REFERENCES `tabla_cursos` (`id_curso`),
  CONSTRAINT `tabla_mensajes_ibfk_2` FOREIGN KEY (`id_estudiante_mensaje`) REFERENCES `tabla_usuario` (`id_usuario`),
  CONSTRAINT `tabla_mensajes_ibfk_3` FOREIGN KEY (`id_instructor_mensaje`) REFERENCES `tabla_usuario` (`id_usuario`)
);

DROP TABLE IF EXISTS `tabla_niveles`;
CREATE TABLE `tabla_niveles` (
  `id_nivel` int NOT NULL AUTO_INCREMENT,
  `id_instructor_nivel` int NOT NULL,
  `titulo_nivel` varchar(255) NOT NULL,
  `documento_nivel` varchar(255) DEFAULT NULL,
  `link_video_nivel` varchar(255) NOT NULL,
  `costo_nivel` float DEFAULT '0',
  `id_curso_nivel` int NOT NULL,
  `informacion_nivel` varchar(255) NOT NULL,
  `imagen_nivel` longblob,
  `referencias_nivel` varchar(255) NOT NULL,
  `fecha_creacion_nivel` datetime DEFAULT NULL,
  PRIMARY KEY (`id_nivel`),
  KEY `id_instructor_nivel` (`id_instructor_nivel`),
  KEY `id_curso_nivel` (`id_curso_nivel`),
  CONSTRAINT `tabla_niveles_ibfk_1` FOREIGN KEY (`id_instructor_nivel`) REFERENCES `tabla_usuario` (`id_usuario`),
  CONSTRAINT `tabla_niveles_ibfk_2` FOREIGN KEY (`id_curso_nivel`) REFERENCES `tabla_cursos` (`id_curso`)
);

DROP TABLE IF EXISTS `tabla_usuario`;
CREATE TABLE `tabla_usuario` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `tipo_usuario` int NOT NULL,
  `imagen_usuario` longblob,
  `usuario_bloqueado` bit(1) DEFAULT b'0',
  `nombre_usuario` varchar(50) NOT NULL,
  `apellido_paterno` varchar(50) NOT NULL,
  `apellido_materno` varchar(50) NOT NULL,
  `genero_usuario` int NOT NULL,
  `nacimiento_usuario` date NOT NULL,
  `correo_usuario` varchar(255) NOT NULL,
  `contrasenia_usuario` varchar(255) NOT NULL,
  `registro_usuario` datetime DEFAULT NULL,
  `equivocaciones_usuario` int DEFAULT '0',
  PRIMARY KEY (`id_usuario`)
);
