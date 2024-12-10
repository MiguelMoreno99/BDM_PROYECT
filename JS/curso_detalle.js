// Referencias a elementos clave del DOM
const modal = document.getElementById('modal-borrar'); // Modal de confirmación
const razonBorrarInput = document.getElementById('razon-borrar'); // Campo de texto para la razón
const modalComentarioId = document.getElementById('comentario-id'); // Campo oculto para el ID del comentario
const cancelarBorrarBtn = document.getElementById('cancelar-borrar'); // Botón de cancelar

// Mostrar el modal al hacer clic en un botón de borrar
document.querySelectorAll('.btn-borrar').forEach(button => {
  button.addEventListener('click', function () {
    const comentarioId = this.getAttribute('data-id'); // Obtener el ID del comentario desde el atributo data-id
    if (comentarioId) {
      modalComentarioId.value = comentarioId; // Asignar el ID al campo oculto
      console.log('ID del comentario asignado:', comentarioId); // Confirmar en la consola
      modal.style.display = 'flex'; // Mostrar el modal
    } else {
      console.error('No se pudo obtener el ID del comentario.');
    }
  });
});

// Cerrar el modal al hacer clic en el botón de cancelar
cancelarBorrarBtn.addEventListener('click', function () {
  modal.style.display = 'none'; // Ocultar el modal
  razonBorrarInput.value = ''; // Limpiar el campo de texto
  modalComentarioId.value = ''; // Limpiar el ID del comentario
});

// Para depuración, confirma que los datos se envían correctamente al servidor
const formulario = document.querySelector('form');
formulario.addEventListener('submit', function (e) {
  console.log('Datos enviados al servidor:', new FormData(this));
  // Elimina la línea de preventDefault() en producción
  // e.preventDefault();
});

