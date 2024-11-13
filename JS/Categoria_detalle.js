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
                var nombre_categoria = document.getElementById('nombre_categoria').innerText;
                var href = '../PHP/delete_category.php?titulo='+nombre_categoria;
                 window.location.href = href;
            } else {
                // Si el usuario cancela, no hacer nada
                alert("La categoria NO ha sido eliminada.");
            }
        });
    });
