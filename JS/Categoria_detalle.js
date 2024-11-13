   // Seleccionar todos los botones de eliminar con la clase .btn-eliminar
    const botonesEliminar = document.querySelectorAll('.btn-eliminar');

    // Añadir un evento de clic a cada botón
    botonesEliminar.forEach(boton => {
        boton.addEventListener('click', function(event) {
            event.preventDefault(); // Prevenir la acción por defecto del enlace

            // Mostrar el mensaje de confirmación
            const confirmacion = confirm("¿Estás seguro de que deseas eliminar este categoria?");
            
            if (confirmacion) {
                // Si el usuario confirma, puedes proceder con la eliminación
                alert("La categoria ha sido eliminada."); // Aquí puedes añadir la lógica de eliminación
            } else {
                // Si el usuario cancela, no hacer nada
                alert("La categoria NO ha sido eliminada.");
            }
        });
    });
