<br>
<br>

<h1>Editar categoria</h1>

<br>
<br>
<form id="crear-curso-form" class="crear-curso-form" action="../.Controlador/Categoria.php" method="POST"
    enctype="multipart/form-data" onsubmit="return Llenardatos_creacion(event);">
    <!-- Campo oculto para indicar que es un registro -->
    <input type="hidden" name="accion" value="editar_categoria">

    <!-- Campo oculto para enviar la imagen actual -->
    <input type="hidden" name="imagen_actual" value="<?php echo base64_encode($categoria['imagen_categoria']); ?>">

    <!-- Campos ocultos para los placeholders -->
    <input type="hidden" name="placeholder_titulo-curso" value="<?php echo $categoria['nombre_categoria']; ?>">
    <input type="hidden" name="placeholder_descripcion-curso" value="<?php echo $categoria['descripcion_categoria']; ?>">

    <div class="form-group">
        <label for="nombre">Nombre del categoria:</label>
        <input type="text" id="titulo-curso" name="titulo-curso" placeholder="<?php echo $categoria['nombre_categoria']; ?>">
    </div>

    <div class="form-group">
        <label for="descripcion-curso">Descripción del categoria:</label>
        <input type="text" id="descripcion-curso" name="descripcion-curso" placeholder="<?php echo $categoria['descripcion_categoria']; ?>">
    </div>

    <div class="form-group">
        <label for="imagen-curso">Imagen de Categoria:</label>
        <img class="CategoryPreview" id="CategoryPreview" src="data:image/jpeg;base64,<?php echo base64_encode($categoria['imagen_categoria']); ?>"
            alt="Imagen de categoria"
            style="width: 150px; height: 150px; object-fit: cover; margin-bottom: 10px;">
        <input type="file" id="Foto" name="imagen_categoria" accept="image/*" onchange="loadFile(event)">
    </div>
    <br>
    <br>
    <br>
    <br>
    <button type="submit" class="btn-crear-curso">Editar Categoria</button>
</form>