function llenardatos_inicio()
{
    var correo = document.getElementById("correo").value;
    var contrasenia = document.getElementById("contrasenia").value;

    if(correo ==="")
    {               
        alert("Introduce el correo");
    }
    else if (contrasenia ==="")
    {
        alert("Introduce la contraseña");

    }
    else
    {
        alert("Inicio exitoso");
    }
}