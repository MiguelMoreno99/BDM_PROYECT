<div class="editar">
    <h2>Editar Perfil</h2>
    <form id="profileForm" method="POST" enctype="multipart/form-data" action="../.Controlador/Usuario.php" onsubmit="return Modificardatos_usuarios();">
        <input type="hidden" name="accion" value="Editar_usuario">
        <input type="hidden" name="id_usuario" value="<?php echo $usuario['id_usuario']; ?>">

        <!-- Campo oculto para enviar la imagen actual -->
        <input type="hidden" name="imagen_actual" value="<?php echo base64_encode($usuario['imagen_usuario']); ?>">
        
        <!-- Campos ocultos para los placeholders -->
        <input type="hidden" name="placeholder_nombre" value="<?php echo $usuario['nombre_usuario']; ?>">
        <input type="hidden" name="placeholder_apellido_paterno" value="<?php echo $usuario['apellido_paterno']; ?>">
        <input type="hidden" name="placeholder_apellido_materno" value="<?php echo $usuario['apellido_materno']; ?>">
        <input type="hidden" name="placeholder_correo" value="<?php echo $usuario['correo_usuario']; ?>">
        <input type="hidden" name="placeholder_contrasenia" value="<?php echo $usuario['contrasenia_usuario']; ?>">

        <div class="form-group">
            <label for="nombre">Nombre(s):</label>
            <input type="text" id="nombre" name="nombre_usuario" placeholder="<?php echo $usuario['nombre_usuario']; ?>">
        </div>

        <div class="form-group">
            <label for="apellido">Apellido paterno:</label>
            <input type="text" id="apellido" name="apellido_paterno_usuario" placeholder="<?php echo $usuario['apellido_paterno']; ?>">
        </div>

        <div class="form-group">
            <label for="apellido_materno">Apellido materno:</label>
            <input type="text" id="apellido_materno" name="apellido_materno_usuario" placeholder="<?php echo $usuario['apellido_materno']; ?>">
        </div>

        <div class="form-group">
            <label for="email">Correo Electrónico:</label>
            <input type="text" id="email" name="correo_usuario" placeholder="<?php echo $usuario['correo_usuario']; ?>">
        </div>

        <div class="form-group">
            <label for="password">Contraseña:</label>
            <input type="text" id="password" name="contrasenia_usuario" placeholder="<?php echo $usuario['contrasenia_usuario']; ?>">
        </div>

        <div class="form-group">
            <label for="profile_picture">Foto de Perfil:</label>
            <img src="data:image/jpeg;base64,<?php echo base64_encode($usuario['imagen_usuario']); ?>" 
                alt="Imagen de perfil" 
                style="width: 150px; height: 150px; object-fit: cover; margin-bottom: 10px;">
            <input type="file" id="profile_picture" name="imagen_usuario" accept="image/*">
        </div>

        <button type="submit" class="btn-submit">Guardar Cambios</button>
    </form>
</div>