function Modificardatos_usuarios() {
    var correo_re = document.getElementById("email").value.trim();
    var contrasenia_re = document.getElementById("password").value.trim();
    var validacion_correo = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
    var validacion_contrasenia = /^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]).{8,}$/;


    if (correo_re !== "" && !validacion_correo.test(correo_re)) {
        alert("Por favor, introduce un correo electrónico válido.");
        return false;
    }

    if (contrasenia_re !== "" && !validacion_contrasenia.test(contrasenia_re)) {
        alert("Por favor, introduce una contraseña válida. Debe tener al menos 8 caracteres, una mayúscula, una minúscula, un número y un carácter especial.");
        return false;
    }

    return true;
}