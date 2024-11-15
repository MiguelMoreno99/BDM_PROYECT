// Variables para el comentario que se quiere borrar y el modal
let comentarioSeleccionado = null;
const modal = document.getElementById('modal-borrar');
const razonBorrarInput = document.getElementById('razon-borrar');

// Mostrar el modal cuando se presiona el botón de borrar
document.querySelectorAll('.btn-borrar').forEach(button => {
  button.addEventListener('click', function () {
    comentarioSeleccionado = this.closest('.comentario-item'); // Guarda el comentario a eliminar
    modal.style.display = 'flex'; // Mostrar el modal
  });
});

// Cerrar el modal al presionar el botón de cancelar
document.getElementById('cancelar-borrar').addEventListener('click', function () {
  modal.style.display = 'none';
  razonBorrarInput.value = ''; // Limpiar el campo de texto
});

// Confirmar el borrado con la razón
document.getElementById('confirmar-borrar').addEventListener('click', function () {
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

// Seleccionar todos los botones de eliminar con la clase .btn-eliminar
const botonesEliminar = document.querySelectorAll('.btn-eliminar');

// Añadir un evento de clic a cada botón
botonesEliminar.forEach(boton => {
  boton.addEventListener('click', function (event) {
    event.preventDefault(); // Prevenir la acción por defecto del enlace

    // Mostrar el mensaje de confirmación
    const confirmacion = confirm("¿Estás seguro de que deseas eliminar este Curso?");

    if (confirmacion) {
      // Si el usuario confirma, puedes proceder con la eliminación
      var nombre_curso = document.getElementById('titulo-curso').innerText;
      var href = '../PHP/delete_course.php?titulo=' + nombre_curso;
      window.location.href = href;
    } else {
      // Si el usuario cancela, no hacer nada
      alert("El Curso NO ha sido eliminado.");
    }
  });
});