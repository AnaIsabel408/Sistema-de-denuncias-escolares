<?php
// Habilitar exibição de erros para debug
error_reporting(E_ALL);
ini_set('display_errors', 1);

header("Content-Type: application/json");

try {
    $host = "localhost";
    $db   = "bullystop";
    $user = "root";
    $pass = "";

    $conn = new mysqli($host, $user, $pass, $db);
    
    if($conn->connect_error){
        throw new Exception("Erro de conexão: " . $conn->connect_error);
    }

    // Verificar se os dados chegaram
    if(empty($_POST)){
        throw new Exception("Nenhum dado foi recebido");
    }

    // Validar campos obrigatórios
    $nome = $_POST['nome'] ?? "";
    $idade = $_POST['idade'] ?? "";
    $instituicao_id = $_POST['instituicao_id'] ?? null;
    $codigo_estudantil = $_POST['codigo_estudantil'] ?? "";
    $senha = $_POST['senha'] ?? "";

    // Validações
    if(empty($nome)){
        throw new Exception("Nome é obrigatório");
    }
    if(empty($idade)){
        throw new Exception("Idade é obrigatória");
    }
    if(empty($instituicao_id)){
        throw new Exception("Instituição é obrigatória");
    }
    if(empty($codigo_estudantil)){
        throw new Exception("Código estudantil é obrigatório");
    }
    if(empty($senha)){
        throw new Exception("Senha é obrigatória");
    }

    // Validar formato do código estudantil
    if(!preg_match("/^\d{4,}$/", $codigo_estudantil)){
        throw new Exception("Código estudantil deve ter pelo menos 4 números");
    }

    // Verificar se código estudantil já existe
    $stmt = $conn->prepare("SELECT id FROM usuario WHERE codigo_estudantil = ?");
    $stmt->bind_param("s", $codigo_estudantil);
    $stmt->execute();
    $result = $stmt->get_result();
    if($result->num_rows > 0){
        $stmt->close();
        throw new Exception("Código estudantil já cadastrado");
    }
    $stmt->close();

    // Hash da senha
    $senha_hash = password_hash($senha, PASSWORD_DEFAULT);

    // Inserir usuário
    $stmt = $conn->prepare("INSERT INTO usuario (nome, idade, codigo_estudantil, senha, instituicao_id) VALUES (?, ?, ?, ?, ?)");
    
    if(!$stmt){
        throw new Exception("Erro ao preparar statement: " . $conn->error);
    }

    $stmt->bind_param("sissi", $nome, $idade, $codigo_estudantil, $senha_hash, $instituicao_id);

    if(!$stmt->execute()){
        throw new Exception("Erro ao executar insert: " . $stmt->error);
    }

    $usuario_id = $stmt->insert_id;
    $stmt->close();
    $conn->close();

    echo json_encode([
        "success" => true, 
        "mensagem" => "Cadastro realizado com sucesso!",
        "usuario_id" => $usuario_id
    ]);

} catch(Exception $e) {
    // Log do erro (opcional)
    error_log("Erro no cadastro: " . $e->getMessage());
    
    echo json_encode([
        "success" => false, 
        "mensagem" => $e->getMessage()
    ]);
}
?>