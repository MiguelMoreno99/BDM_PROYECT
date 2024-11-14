document.getElementById('tipo-precio').addEventListener('change', function() {
  const precioCompletoGroup = document.getElementById('precio-completo-group');
  const contenedorNiveles = document.getElementById('contenedor-niveles');

  if (this.value === 'completo') {
    // Mostrar solo el precio completo
    precioCompletoGroup.style.display = 'block';
    contenedorNiveles.querySelectorAll('.precio-nivel').forEach(el => el.style.display = 'none');
  } else if (this.value === 'nivel') {
    // Ocultar el precio completo y mostrar los precios por nivel
    precioCompletoGroup.style.display = 'none';
    contenedorNiveles.querySelectorAll('.precio-nivel').forEach(el => el.style.display = 'block');
  } else {
    // Ocultar todos los precios
    precioCompletoGroup.style.display = 'none';
    contenedorNiveles.querySelectorAll('.precio-nivel').forEach(el => el.style.display = 'none');
  }
});

let nivelActual = 0;  // Empieza en 0, porque no hay ningún nivel al inicio

function agregarNivel() {
  nivelActual++;
  const contenedorNiveles = document.getElementById('contenedor-niveles');
  const nuevaSeccion = document.createElement('div');
  nuevaSeccion.classList.add('seccion');
  nuevaSeccion.setAttribute('data-nivel', nivelActual);
  nuevaSeccion.innerHTML = `
    <div class="seccion-titulo">
      <h3>Nivel ${nivelActual}: <input type="text" name="nivel-titulo-${nivelActual}" placeholder="Título del nivel" required></h3>
      <button type="button" class="btn-borrar" onclick="eliminarNivel(this)">🗑️</button>
    </div>
    <div class="clase">
      <p>Contenido del nivel ${nivelActual}:</p>
      <textarea name="contenido-nivel-${nivelActual}" placeholder="Escribe el contenido del nivel aquí" required></textarea>
      <div class="adjuntos">
        <label for="linkpdf-nivel-${nivelActual}">Link de drive del PDF:</label>
        <input type="url" id="linkpdf-nivel-${nivelActual}" name="linkpdf-nivel-${nivelActual}" placeholder="https://drive.google.com/file/...">
        
        <label for="imagen-nivel-${nivelActual}">Adjuntar imagen:</label>
        <input type="file" id="imagen-nivel-${nivelActual}" name="imagen-nivel-${nivelActual}" accept="image/*">
        
        <label for="linkpagina-nivel-${nivelActual}">Link a página externa:</label>
        <input type="url" id="linkpagina-nivel-${nivelActual}" name="linkpagina-nivel-${nivelActual}" placeholder="https://www.w3schools.com/css/...">
        
        <label for="linkyoutube-nivel-${nivelActual}">Link Youtube Video:</label>
        <input type="url" id="linkyoutube-nivel-${nivelActual}" name="linkyoutube-nivel-${nivelActual}" placeholder="https://www.youtube.com/watch...">
      </div>
      <div class="precio-nivel" style="display: none;">
        <label for="precio-nivel-${nivelActual}">Costo del nivel ($):</label>
        <input type="number" id="precio-nivel-${nivelActual}" name="precio-nivel-${nivelActual}" placeholder="Costo del nivel">
      </div>
    </div>
  `;
  contenedorNiveles.appendChild(nuevaSeccion);

  // Si está seleccionado "Precio por cada nivel", mostrar los campos de precio en los nuevos niveles
  const tipoPrecio = document.getElementById('tipo-precio').value;
  if (tipoPrecio === 'nivel') {
    nuevaSeccion.querySelector('.precio-nivel').style.display = 'block';
  }
}

function eliminarNivel(elemento) {
  const nivel = elemento.closest('.seccion');
  nivel.remove();
}