<?php
require_once '../.Controlador/Curso.php';

$controller = new CourseController($config);

$curso = $controller->ShowCursoInscripcion();
$niveles = $controller->obtenerPrecioCursosYNiveles();
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
            <div class="curso-info">
                <h2 id="titulo-curso"><?= htmlspecialchars($curso['titulo_curso']) ?></h2>
                <p><strong>Total de Niveles: </strong><?= htmlspecialchars($curso['niveles_curso']) ?></p>
                <input type="hidden" name="id_curso" id="Id_curso_id" value="<?= htmlspecialchars($curso['id_curso']) ?>" readonly>

                <?php if ($curso['manejo_precio_curso'] == 0): ?>
                    <p><strong>Costo del Curso Completo: </strong>Gratis!!</p>
                <?php elseif ($curso['manejo_precio_curso'] == 1): ?>
                    <p><strong>Costo del Curso Completo: </strong> $<?= htmlspecialchars($curso['precio_curso']) ?></p>
                <?php elseif ($curso['manejo_precio_curso'] == 2): ?>
                    <p><strong>Costo por Nivel: </strong> Este Curso se maneja por venta individual de niveles, para más información del costo vea los diferentes niveles!</p>
                <?php endif; ?>

                <p class="descripcion"><?= htmlspecialchars($curso['descripcion_curso']) ?></p>
            </div>
        </div>
        <br>
        <br>
        <div class="compra-detalle">
            <h1>Detalles del Curso</h1>
            <div class="compra-detalle">
                <h2>Detalles del Curso</h2>


                <h3>Selecciona los niveles:</h3>
                <?php if ($curso['manejo_precio_curso'] == 0): ?>

                    <ul>
                        <?php foreach ($niveles as $nivel): ?>
                            <li>
                                <h4><?= isset($nivel['titulo_nivel']) ? htmlspecialchars($nivel['titulo_nivel']) : 'Título no disponible' ?></h4>
                                <input type="checkbox"
                                    class="level"
                                    data-id="<?= isset($nivel['id_nivel']) ? htmlspecialchars($nivel['id_nivel']) : '0' ?>"
                                    data-costo="<?= isset($nivel['costo_nivel']) ? htmlspecialchars($nivel['costo_nivel']) : '0' ?>"
                                    data-name="<?= isset($nivel['titulo_nivel']) ? htmlspecialchars($nivel['titulo_nivel']) : 'Nivel sin nombre' ?>" checked disabled>
                            </li>
                        <?php endforeach; ?>
                    </ul>
                    <p><strong>Total:</strong> $<span id="totalCost">0</span></p>

                <?php elseif ($curso['manejo_precio_curso'] == 2): ?>

                    <ul>
                        <?php foreach ($niveles as $nivel): ?>
                            <li>
                                <h4><?= isset($nivel['titulo_nivel']) ? htmlspecialchars($nivel['titulo_nivel']) : 'Título no disponible' ?></h4>
                                <p>Precio: $<?= isset($nivel['costo_nivel']) ? htmlspecialchars($nivel['costo_nivel']) : '0' ?></p>
                                <input type="checkbox"
                                    class="level"
                                    data-id="<?= isset($nivel['id_nivel']) ? htmlspecialchars($nivel['id_nivel']) : '0' ?>"
                                    data-costo="<?= isset($nivel['costo_nivel']) ? htmlspecialchars($nivel['costo_nivel']) : '0' ?>"
                                    data-name="<?= isset($nivel['titulo_nivel']) ? htmlspecialchars($nivel['titulo_nivel']) : 'Nivel sin nombre' ?>">
                            </li>
                        <?php endforeach; ?>
                    </ul>
                    <p><strong>Total:</strong> $<span id="totalCost">0</span></p>

                <?php elseif ($curso['manejo_precio_curso'] == 1): ?>

                    <ul>
                        <?php foreach ($niveles as $nivel): ?>
                            <li>
                                <h4><?= isset($nivel['titulo_nivel']) ? htmlspecialchars($nivel['titulo_nivel']) : 'Título no disponible' ?></h4>
                                <input type="checkbox"
                                    class="level"
                                    data-id="<?= isset($nivel['id_nivel']) ? htmlspecialchars($nivel['id_nivel']) : '0' ?>"
                                    data-costo="<?= isset($nivel['costo_nivel']) ? htmlspecialchars($nivel['costo_nivel']) : '0' ?>"
                                    data-name="<?= isset($nivel['titulo_nivel']) ? htmlspecialchars($nivel['titulo_nivel']) : 'Nivel sin nombre' ?>" checked disabled>
                            </li>
                        <?php endforeach; ?>
                    </ul>
                    <p><strong>Total:</strong> $<span id="totalCost"> <?= isset($nivel['costo_nivel']) ? htmlspecialchars($curso['precio_curso']) : '0' ?> </span></p>

                <?php endif; ?>

            </div>
            <br>
            <br>
            <br>
            <br>

            <div class="metodo-pago-div">
                <h1>Forma de pago</h1>
                <br>
                <select id="paymentMethod" name="metodo_pago" onchange="togglePaymentFields()">
                    <option value="">Seleccione un método de pago</option>

                    <?php if ($curso['manejo_precio_curso'] == 0): ?>
                        <option value="3">Gratis</option>
                    <?php elseif ($curso['manejo_precio_curso'] == 2 || $curso['manejo_precio_curso'] == 1): ?>
                        <option value="1">Tarjeta de Crédito</option>
                        <option value="0">Tarjeta de Débito</option>
                        <option value="2">PayPal</option>
                    <?php endif; ?>
                </select>

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

            <br>
            <br>

            <form id="profileForm" method="POST" enctype="multipart/form-data" action="../.Controlador/Curso.php">
                <input type="hidden" name="accion" value="registro_inscripcion">

                <?php if ($curso['manejo_precio_curso'] == 0): ?>

                    <div class="metodo-pago-div">
                        <h1>Información de compra</h1>

                        <input type="hidden" class="hidden" name="id_curso" id="displayIDCurso" value="" readonly>
                        <h2 id="displayTituloCurso">Curso Seleccionado</h2>
                        <br>
                        <Costo total>
                            <input type="hidden" id="titulo_curso" name="titulo_curso" value="<?= htmlspecialchars($curso['titulo_curso']) ?>">
                            <input type="hidden" id="id_curso" name="id_curso" value="<?= htmlspecialchars($curso['id_curso']) ?>">
                            <input type="hidden" id="id_usuario" name="id_usuario" value="<?= htmlspecialchars($_SESSION['usuario']['id_usuario'] ?? 'Usuario') ?>">
                            <h3>Niveles seleccionados:</h3>
                            <ul id="selectedLevelsList"></ul>
                            <input type="hidden" id="hiddenNiveles" name="nivelesSeleccionados" value="">
                            <input type="hidden" id="hiddenTotal" name="costo_total" value="" readonly>
                            <input type="hidden" id="hiddenForma" name="forma_pago" value="" readonly>
                            <br>
                            <input type="hidden" class="hidden" name="forma_de_pago2" id="hiddenFormadePago" value="">
                            <h2>Forma de pago: <span id="FormadePagoID"></span></h2>

                            <br>

                            <button type="submit" class="btn-compra">Inscribir Curso</button>
                            <a href="index.php" class="btn-compra">Cancelar</a>

                        <?php elseif ($curso['manejo_precio_curso'] == 2): ?>

                            <div class="metodo-pago-div">
                                <h1>Información de compra</h1>

                                <input type="hidden" class="hidden" name="id_curso" id="displayIDCurso" value="" readonly>
                                <h2 id="displayTituloCurso">Curso Seleccionado</h2>
                                <br>
                                <Costo total>
                                    <input hidden="hidden" id="titulo_curso" name="titulo_curso" value="<?= htmlspecialchars($curso['titulo_curso']) ?>">
                                    <input hidden="hidden" id="id_curso" name="id_curso" value="<?= htmlspecialchars($curso['id_curso']) ?>">
                                    <input hidden="hidden" id="id_usuario" name="id_usuario" value="<?= htmlspecialchars($_SESSION['usuario']['id_usuario'] ?? 'Usuario') ?>">
                                    <h3>Niveles seleccionados:</h3>
                                    <ul id="selectedLevelsList"></ul>
                                    <input type="hidden" id="hiddenNiveles" name="nivelesSeleccionados" value="">
                                    <input type="hidden" id="hiddenTotal" name="costo_total" value="" readonly>
                                    <input type="hidden" id="hiddenForma" name="forma_pago" value="" readonly>
                                    <br>
                                    <input type="hidden" class="hidden" name="forma_de_pago2" id="hiddenFormadePago" value="">
                                    <h2>Forma de pago: <span id="FormadePagoID"></span></h2>

                                    <br>

                                    <button type="submit" class="btn-compra">Inscribir Curso</button>
                                    <a href="index.php" class="btn-compra">Cancelar</a>
                            </div>

                        <?php elseif ($curso['manejo_precio_curso'] == 1): ?>

                            <div class="metodo-pago-div">
                                <h1>Información de compra</h1>

                                <input type="hidden" class="hidden" name="id_curso" id="displayIDCurso" value="" readonly>
                                <h2 id="displayTituloCurso">Curso Seleccionado</h2>
                                <br>
                                <Costo total>
                                    <input type="hidden" id="titulo_curso" name="titulo_curso" value="<?= htmlspecialchars($curso['titulo_curso']) ?>">
                                    <input type="hidden" id="id_curso" name="id_curso" value="<?= htmlspecialchars($curso['id_curso']) ?>">
                                    <input type="hidden" id="id_usuario" name="id_usuario" value="<?= htmlspecialchars($_SESSION['usuario']['id_usuario'] ?? 'Usuario') ?>">
                                    <input type="hidden" name="costo_total" value="<?= htmlspecialchars($curso['precio_curso']) ?>">
                                    <input type="hidden" id="hiddenForma" name="forma_pago" value="" readonly>
                                    <h3>Niveles seleccionados:</h3>
                                    <ul id="selectedLevelsList"></ul>
                                    <input type="hidden" id="hiddenNiveles" name="nivelesSeleccionados" value="">
                                    <br>
                                    <input type="hidden" class="hidden" name="forma_de_pago2" id="hiddenFormadePago" value="">
                                    <h2>Forma de pago: <span id="FormadePagoID"></span></h2>

                                    <br>

                                    <button type="submit" class="btn-compra">Inscribir Curso</button>
                                    <a href="index.php" class="btn-compra">Cancelar</a>
                            </div>

                        <?php endif; ?>

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