function llenardatos_inicio() {
    var correo = document.getElementById("correo").value;
    var contrasenia = document.getElementById("contrasenia").value;

    if (correo === "") {
        alert("Introduce el correo");
        return false;
    } else if (contrasenia === "") {
        alert("Introduce la contraseña");
        return false;
    } else {
        // Permite que el formulario se envíe normalmente
        return true;
    }
}

// Mostrar el modal si se detecta un error en la URL
window.onload = function () {
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.has('error')) {
        const errorType = urlParams.get('error');
        if (errorType === 'usuario_bloqueado') {
            document.getElementById('errorModal').style.display = 'block';
        } else if (errorType === 'credenciales_incorrectas') {
            document.getElementById('errorModal2').style.display = 'block';
        }
    }

    // Agregar evento a los botones de cerrar modal
    document.querySelectorAll('.cerrar-modal').forEach(btn => {
        btn.onclick = () => {
            btn.parentElement.parentElement.style.display = 'none';
        };
    });

    // Cerrar el modal si el usuario hace clic fuera de él
    window.onclick = function (event) {
        const modals = document.querySelectorAll('.modal');
        modals.forEach(modal => {
            if (event.target === modal) {
                modal.style.display = 'none';
            }
        });
    };
};