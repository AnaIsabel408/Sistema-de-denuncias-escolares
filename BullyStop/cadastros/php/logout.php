<?php
session_start();

// Destruir todas as variáveis de sessão
$_SESSION = array();

// Destruir o cookie de sessão
if (isset($_COOKIE[session_name()])) {
    setcookie(session_name(), '', time()-3600, '/');
}

// Destruir a sessão
session_destroy();

// Retornar resposta JSON
header("Content-Type: application/json");
echo json_encode([
    "success" => true,
    "mensagem" => "Logout realizado com sucesso"
]);
?>