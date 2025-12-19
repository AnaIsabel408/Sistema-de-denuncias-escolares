<?php
header("Content-Type: application/json");

$host = "localhost";
$db   = "bullystop";
$user = "root"; 
$pass = "";

$conn = new mysqli($host, $user, $pass, $db);
if($conn->connect_error){
    echo json_encode([]);
    exit;
}

$result = $conn->query("SELECT id, nome FROM instituicoes ORDER BY nome");
$instituicoes = [];
while($row = $result->fetch_assoc()){
    $instituicoes[] = $row;
}

echo json_encode($instituicoes);
$conn->close();
?>
