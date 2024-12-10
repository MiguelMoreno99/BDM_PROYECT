let nivelActual = 0;  // Empieza en 0, porque no hay ningún nivel al inicio

document.getElementById('tipo-precio').addEventListener('change', function() {
  const precioCompletoGroup = document.getElementById('precio-completo-group');
  const contenedorNiveles = document.getElementById('contenedor-niveles');

  if (this.value === '1') {
    // Mostrar solo el precio completo
    precioCompletoGroup.style.display = 'block';
    contenedorNiveles.querySelectorAll('.precio-nivel').forEach(el => el.style.display = 'none');
  } else if (this.value === '2') {
    // Ocultar el precio completo y mostrar los precios por nivel
    precioCompletoGroup.style.display = 'none';
    contenedorNiveles.querySelectorAll('.precio-nivel').forEach(el => el.style.display = 'block');
  } else {
    // Ocultar todos los precios
    precioCompletoGroup.style.display = 'none';
    contenedorNiveles.querySelectorAll('.precio-nivel').forEach(el => el.style.display = 'none');
  }
});

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
      <textarea name="contenido-nivel-${nivelActual}" placeholder="Escribe el contenido del nivel aquí" required maxlength="100"></textarea>
      <div class="adjuntos">
        <label for="linkpdf-nivel-${nivelActual}">Link de drive del PDF:</label>
        <input type="url" id="linkpdf-nivel-${nivelActual}" name="linkpdf-nivel-${nivelActual}" placeholder="https://drive.google.com/file/..." required>
        
        <label for="imagen-nivel-${nivelActual}">Adjuntar imagen:</label>
        <input type="file" id="imagen-nivel-${nivelActual}" name="imagen-nivel-${nivelActual}" accept="image/*" required>
        
        <label for="linkpagina-nivel-${nivelActual}">Link a página externa:</label>
        <input type="url" id="linkpagina-nivel-${nivelActual}" name="linkpagina-nivel-${nivelActual}" placeholder="https://www.w3schools.com/css/..." >
        
        <label for="linkyoutube-nivel-${nivelActual}">Link YouTube Video:</label>
        <input type="url" id="linkyoutube-nivel-${nivelActual}" name="linkyoutube-nivel-${nivelActual}" placeholder="https://www.youtube.com/watch..." required>
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
  if (tipoPrecio === '2') {
    nuevaSeccion.querySelector('.precio-nivel').style.display = 'block';
  }

  // Agregar validaciones en tiempo real
  nuevaSeccion.querySelector('textarea').addEventListener('input', validarDescripcionNivel);
  nuevaSeccion.querySelector('input[name^="linkyoutube"]').addEventListener('input', validarLinkYoutube);
  nuevaSeccion.querySelector('input[name^="linkpdf"]').addEventListener('input', validarLinkDrive);
}

function validarDescripcionNivel(event) {
  const maxLength = 100;
  const currentLength = event.target.value.length;
  if (currentLength > maxLength) {
    event.target.value = event.target.value.slice(0, maxLength);
  }
}

function validarLinkYoutube(event) {
  const link = event.target.value;
  const youtubePattern = /^(https?:\/\/)?(www\.)?(youtube\.com|youtu\.?be)\/.+$/;

  if (!youtubePattern.test(link)) {
    alert("Por favor, ingrese un enlace válido de YouTube.");
    event.target.value = '';
  }
}

function validarLinkDrive(event) {
  const link = event.target.value;
  const drivePattern = /^(https?:\/\/)?(www\.)?(drive\.google\.com)\/.+$/;

  if (!drivePattern.test(link)) {
    alert("Por favor, ingrese un enlace válido de Google Drive.");
    event.target.value = '';
  }
}

function eliminarNivel(elemento) {
  const nivel = elemento.closest('.seccion');
  nivel.remove();
  actualizarNumerosNiveles();
}

function actualizarNumerosNiveles() {
  const contenedorNiveles = document.getElementById('contenedor-niveles');
  const secciones = contenedorNiveles.getElementsByClassName('seccion');
  nivelActual = 0;

  Array.from(secciones).forEach((seccion, index) => {
    nivelActual = index + 1;
    seccion.setAttribute('data-nivel', nivelActual);
    seccion.querySelector('.seccion-titulo h3').innerHTML = `Nivel ${nivelActual}: <input type="text" name="nivel-titulo-${nivelActual}" placeholder="Título del nivel" required>`;
    seccion.querySelector('textarea').setAttribute('name', `contenido-nivel-${nivelActual}`);
    seccion.querySelector('label[for^="linkpdf"]').setAttribute('for', `linkpdf-nivel-${nivelActual}`);
    seccion.querySelector('input[name^="linkpdf"]').setAttribute('name', `linkpdf-nivel-${nivelActual}`);
    seccion.querySelector('label[for^="imagen"]').setAttribute('for', `imagen-nivel-${nivelActual}`);
    seccion.querySelector('input[name^="imagen"]').setAttribute('name', `imagen-nivel-${nivelActual}`);
    seccion.querySelector('label[for^="linkpagina"]').setAttribute('for', `linkpagina-nivel-${nivelActual}`);
    seccion.querySelector('input[name^="linkpagina"]').setAttribute('name', `linkpagina-nivel-${nivelActual}`);
    seccion.querySelector('label[for^="linkyoutube"]').setAttribute('for', `linkyoutube-nivel-${nivelActual}`);
    seccion.querySelector('input[name^="linkyoutube"]').setAttribute('name', `linkyoutube-nivel-${nivelActual}`);
    seccion.querySelector('label[for^="precio"]').setAttribute('for', `precio-nivel-${nivelActual}`);
    seccion.querySelector('input[name^="precio"]').setAttribute('name', `precio-nivel-${nivelActual}`);
  });
}

document.addEventListener('DOMContentLoaded', () => {
  // Agregar validación de longitud de descripción para los niveles existentes al cargar la página
  document.querySelectorAll('textarea[name^="contenido-nivel"]').forEach(textarea => {
    textarea.addEventListener('input', validarDescripcionNivel);
  });

  // Agregar validación de link de YouTube para los niveles existentes al cargar la página
  document.querySelectorAll('input[name^="linkyoutube"]').forEach(input => {
    input.addEventListener('input', validarLinkYoutube);
  });

  // Agregar validación de link de Google Drive para los niveles existentes al cargar la página
  document.querySelectorAll('input[name^="linkpdf"]').forEach(input => {
    input.addEventListener('input', validarLinkDrive);
  });
});
