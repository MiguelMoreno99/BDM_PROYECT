// Variables para el comentario que se quiere borrar y el modal
let comentarioSeleccionado = null;
const modal = document.getElementById('modal-borrar');
const razonBorrarInput = document.getElementById('razon-borrar');

// Mostrar el modal cuando se presiona el botón de borrar
document.querySelectorAll('.btn-borrar').forEach(button => {
  button.addEventListener('click', function() {
    comentarioSeleccionado = this.closest('.comentario-item'); // Guarda el comentario a eliminar
    modal.style.display = 'flex'; // Mostrar el modal
  });
});

// Cerrar el modal al presionar el botón de cancelar
document.getElementById('cancelar-borrar').addEventListener('click', function() {
  modal.style.display = 'none';
  razonBorrarInput.value = ''; // Limpiar el campo de texto
});

// Confirmar el borrado con la razón
document.getElementById('confirmar-borrar').addEventListener('click', function() {
  const razon = razonBorrarInput.value.trim();
  if (razon !== '') {
    console.log('Razón de borrado:', razon); // Puedes hacer algo con la razón (e.g., enviarla a un servidor)
    comentarioSeleccionado.remove(); // Elimina el comentario
    modal.style.display = 'none'; // Cierra el modal
    razonBorrarInput.value = ''; // Limpiar el campo de texto
  } else {
    alert('Por favor, escribe una razón para borrar el comentario.');
  }
});