<?php
session_start();

$usuario = $_SESSION['usuario'];
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Compra Curso</title>
    <link rel="stylesheet" href="../CSS/GENERAL/general_styles.css">
    <link rel="stylesheet" href="../CSS/compra_curso.css">
    <link rel="stylesheet" href="../CSS/GENERAL/header.css">
    <link rel="stylesheet" href="../CSS/GENERAL/footer.css">
</head>

<body>
    <div id="header-container"></div>
    <div>
        <h1 id="ComprarCurso-h1">Comprar Curso</h1>
    </div>
    <br>
    <main class="curso-detalle">
        <div class="curso-detalle-contenido">
            <?php
            require_once '../.Controlador/Curso.php';
            $controller->ShowCoursePago();
            ?>
        </div>
        <br>
        <br>
        <?php
        require_once '../.Controlador/Curso.php';
        $controller->obtenerPrecioCursosYNiveles();
        ?>
        <br>
        <br>

        <form method="POST" action="../.Controlador/Curso.php">
            <input type="hidden" name="accion" value="Traer_informacion_pago">

            <div class="metodo-pago-div">
                <h1>Forma de pago</h1>
                <br>
                <?php
                require_once '../.Controlador/Curso.php';
                $controller->obtenerFormasdepago();
                ?>

                <!-- Campos ocultos según el método de pago seleccionado -->
                <div id="freeMessage" class="hidden">
                    <p>Este curso es gratuito, no necesita realizar un pago.</p>
                </div>
                <div id="creditCardFields" class="hidden">
                    <div class="form-group">
                        <label for="cardName">Nombre del Titular</label>
                        <input type="text" id="cardName" name="cardName">
                    </div>
                    <div class="form-group">
                        <label for="cardNumber">Número de Tarjeta</label>
                        <input type="text" id="cardNumber" name="cardNumber">
                    </div>
                    <div class="form-group">
                        <label for="expiryDate">Fecha de Vencimiento</label>
                        <input type="text" id="expiryDate" name="expiryDate" placeholder="MM/AA">
                    </div>
                    <div class="form-group">
                        <label for="cvv">Código de Seguridad (CVV)</label>
                        <input type="number" id="cvv" name="cvv">
                    </div>
                </div>
                <div id="debitCardFields" class="hidden">
                    <div class="form-group">
                        <label for="debitCardName">Nombre del Titular</label>
                        <input type="text" id="debitCardName" name="debitCardName">
                    </div>
                    <div class="form-group">
                        <label for="debitCardNumber">Número de Tarjeta</label>
                        <input type="text" id="debitCardNumber" name="debitCardNumber">
                    </div>
                    <div class="form-group">
                        <label for="debitExpiryDate">Fecha de Vencimiento</label>
                        <input type="text" id="debitExpiryDate" name="debitExpiryDate" placeholder="MM/AA">
                    </div>
                    <div class="form-group">
                        <label for="debitCvv">Código de Seguridad (CVV)</label>
                        <input type="number" id="debitCvv" name="debitCvv">
                    </div>
                </div>
                <div id="paypalFields" class="hidden">
                    <div class="form-group">
                        <label for="paypalEmail">Correo Electrónico de PayPal</label>
                        <input type="text" id="paypalEmail" name="paypalEmail">
                    </div>
                </div>
            </div>
        </form>

        <br>
        <br>
        <form id="profileForm" method="POST" enctype="multipart/form-data" action="../.Controlador/Curso.php">
            <input type="hidden" name="accion" value="registro_inscripcion">

            <div class="metodo-pago-div">
                <h1>Información de compra</h1>

                <input type="text" name="id_usuario_1" id="hiddenID_USUARIO"
                    value="<?php echo htmlspecialchars($usuario['id_usuario']); ?>">

                <input type="text" name="id_curso" id="displayIDCurso" value="" readonly>

                <h2 id="displayTituloCurso">Curso Seleccionado</h2>

                <!-- Costo total -->
                <input type="hidden" name="costo_total" id="hiddenTotalCost" value="">
                <h2>Costo Total: <span id="displayTotalCost">0</span></h2>

                <!-- Forma de pago -->
                <input type="text" name="forma_de_pago2" id="hiddenFormadePago" value="">
                <h2>Forma de pago: <span id="FormadePagoID"></span></h2>

                <br>
                <!-- Niveles seleccionados -->
                <input type="text" name="nivelesSeleccionados" id="hiddenNivelesSeleccionados" value="[]">
                <h2 id="displayNiveles">Niveles seleccionados (0): Ninguno</h2>

                <button type="submit" class="btn-compra">Inscribir Curso</button>
                <a href="index.php" class="btn-compra">Cancelar</a>
            </div>
        </form>
        <br>
        <br>
        <br>
    </main>

    <div id="footer-container"></div>

    <script src="../JS/compra_curso.js"></script>
    <script src="../JS/templates.js"></script>
</body>

</html>