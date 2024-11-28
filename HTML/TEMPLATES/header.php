<?php
session_start();

$usuario = $_SESSION['usuario'];
?>

<template id="header-template">
    <header class="main-header">
        <div class="logo">
            <img src="../assets/images/logo.webp" alt="Logo">
        </div>
        <nav class="nav-opciones">
            <ul>
                <li><a href="index.php">Inicio</a></li>

                <li><a href="busqueda.html">Busqueda</a></li>

                <?php if (isset($_SESSION['usuario'])): ?>
                <li><a href="Editar_Perfil.php">Editar Perfil</a></li>
                <?php else: ?>

                <?php endif; ?>  

                <?php if (isset($_SESSION['usuario'])): ?>
                    <li><a href="dms.php">Mensajes</a></li>
                <?php else: ?>

                <?php endif; ?>

                <?php if (isset($_SESSION['usuario']) && $_SESSION['usuario']['tipo_usuario'] == 2): ?>
                   <li><a href="MisCursos.php">Mis Cursos</a></li>
                <?php else: ?>

                <?php endif; ?>

                <?php if (isset($_SESSION['usuario']) && $_SESSION['usuario']['tipo_usuario'] == 1): ?>
                    <li><a href="crear_curso.php">Crear Curso</a></li>
                <?php else: ?>

                <?php endif; ?>

                <?php if (isset($_SESSION['usuario']) && $_SESSION['usuario']['tipo_usuario'] == 3): ?>
                    <li><a href="crear_categoria.html">Crear Categoria</a></li>
                <?php else: ?>

                <?php endif; ?>

                <?php if (isset($_SESSION['usuario']) && $_SESSION['usuario']['tipo_usuario'] == 3): ?>
                    <li><a href="gestion_admin.php">Gestión Administradores</a></li>
                <?php else: ?>

                <?php endif; ?>

                <?php if (isset($_SESSION['usuario']) && $_SESSION['usuario']['tipo_usuario'] == 2): ?>
                    <li><a href="gestion_usuario.php">Gestión Alumnos</a></li>
                <?php else: ?>

                <?php endif; ?>

                <?php if (isset($_SESSION['usuario']) && $_SESSION['usuario']['tipo_usuario'] == 1): ?>
                    <li><a href="gestion_instructor.php">Gestión Instructores</a></li>
                <?php else: ?>

                <?php endif; ?>

                
                <?php if (isset($_SESSION['usuario']) && $_SESSION['usuario']['tipo_usuario'] == 3): ?>
                    <!-- <li><a href="reportes.html">Reportes</a></li> -->
                <?php else: ?>

                <?php endif; ?>

                <?php if (isset($_SESSION['usuario'])): ?>
                    <li><a href="../.Vista/cerrarsesion.php">Cerrar Sesión</a></li>
                    <img src="data:image/jpeg;base64,<?php echo base64_encode($usuario['imagen_usuario']); ?>" alt="Imagen de perfil" style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover;">               
                <?php else: ?>
                    <li><a href="inicio_sesion.html">Iniciar Sesión</a></li>
                    <li><a href="registro.html">Registrarse</a></li>
                <?php endif; ?>

            </ul>
        </nav>
    </header>
</template>
