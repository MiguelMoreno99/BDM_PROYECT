let nivelActual = 1;

function agregarNivel() {
  nivelActual++;
  const contenedorNiveles = document.getElementById('contenedor-niveles');
  const nuevaSeccion = document.createElement('div');
  nuevaSeccion.classList.add('seccion');
  nuevaSeccion.setAttribute('data-nivel', nivelActual);
  nuevaSeccion.innerHTML = `
    <div class="seccion-titulo">
      <h3>Nivel ${nivelActual}: <input type="text" name="nivel-titulo-${nivelActual}" placeholder="Título del nivel"></h3>
      <button type="button" class="btn-borrar" onclick="eliminarNivel(this)">🗑️</button>
    </div>
    <div class="clase">
      <p>Contenido del nivel ${nivelActual}:</p>
      <textarea name="contenido-nivel-${nivelActual}" placeholder="Escribe el contenido del nivel aquí"></textarea>
      <div class="adjuntos">
        <label for="pdf-nivel-${nivelActual}">Adjuntar PDF:</label>
        <input type="file" id="pdf-nivel-${nivelActual}" name="pdf-nivel-${nivelActual}" accept="application/pdf">
        
        <label for="imagen-nivel-${nivelActual}">Adjuntar imagen:</label>
        <input type="file" id="imagen-nivel-${nivelActual}" name="imagen-nivel-${nivelActual}" accept="image/*">
        
        <label for="link-nivel-${nivelActual}">Link a página externa:</label>
        <input type="url" id="link-nivel-${nivelActual}" name="link-nivel-${nivelActual}" placeholder="https://example.com">
        
        <label for="video-nivel-${nivelActual}">Subir video (obligatorio):</label>
        <input type="file" id="video-nivel-${nivelActual}" name="video-nivel-${nivelActual}" accept="video/*" required>
      </div>
    </div>
  `;
  contenedorNiveles.appendChild(nuevaSeccion);
}

function eliminarNivel(elemento) {
  const nivel = elemento.closest('.seccion');
  nivel.remove();
}
