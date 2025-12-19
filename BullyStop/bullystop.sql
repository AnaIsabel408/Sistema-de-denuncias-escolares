-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 19-Dez-2025 às 08:55
-- Versão do servidor: 10.4.32-MariaDB
-- versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `bullystop`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `denuncia`
--

CREATE TABLE `denuncia` (
  `id` int(11) NOT NULL,
  `denunciante_id` int(11) NOT NULL,
  `vitima_id` int(11) NOT NULL,
  `tipo_agressao_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT 1,
  `descricao` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `instituicoes`
--

CREATE TABLE `instituicoes` (
  `id` int(11) NOT NULL,
  `nome` varchar(150) NOT NULL,
  `endereco` varchar(255) DEFAULT NULL,
  `cidade` varchar(100) DEFAULT NULL,
  `provincia` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `instituicoes`
--

INSERT INTO `instituicoes` (`id`, `nome`, `endereco`, `cidade`, `provincia`) VALUES
(1, 'Instituto Politecnico Dom Damião Franklin Nº8028', NULL, 'AV. Pedro de Castro Van Dunem Loy', 'Luanda'),
(2, 'Alpega', NULL, 'AV. Hoji Ya Henda', 'Luanda'),
(3, 'Colégio Albert Einstein', NULL, 'Vila', 'Luanda');

-- --------------------------------------------------------

--
-- Estrutura da tabela `status_denuncia`
--

CREATE TABLE `status_denuncia` (
  `id` int(11) NOT NULL,
  `status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `status_denuncia`
--

INSERT INTO `status_denuncia` (`id`, `status`) VALUES
(1, 'Pendente'),
(2, 'Em análise'),
(3, 'Resolvido'),
(4, 'Arquivado');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tipo_agressao`
--

CREATE TABLE `tipo_agressao` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `descricao` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `tipo_agressao`
--

INSERT INTO `tipo_agressao` (`id`, `nome`, `descricao`) VALUES
(1, 'Bullying verbal', 'Insultos, xingamentos, humilhações verbais'),
(2, 'Bullying físico', 'Empurrões, tapas, agressões físicas'),
(3, 'Cyberbullying', 'Assédio ou humilhação por meios digitais'),
(4, 'Bullying psicológico', 'Ameaças, intimidações ou manipulação'),
(5, 'Exclusão social', 'Isolamento do grupo ou ostracismo');

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuario`
--

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `idade` int(11) DEFAULT NULL,
  `codigo_estudantil` varchar(10) DEFAULT NULL,
  `senha` varchar(255) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `tipo_usuario` enum('aluno','admin') DEFAULT 'aluno',
  `instituicao_id` int(11) DEFAULT NULL,
  `criado_em` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `denuncia`
--
ALTER TABLE `denuncia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `denunciante_id` (`denunciante_id`),
  ADD KEY `vitima_id` (`vitima_id`),
  ADD KEY `tipo_agressao_id` (`tipo_agressao_id`),
  ADD KEY `status_id` (`status_id`);

--
-- Índices para tabela `instituicoes`
--
ALTER TABLE `instituicoes`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `status_denuncia`
--
ALTER TABLE `status_denuncia`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `tipo_agressao`
--
ALTER TABLE `tipo_agressao`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `instituicao_id` (`instituicao_id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `denuncia`
--
ALTER TABLE `denuncia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `instituicoes`
--
ALTER TABLE `instituicoes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `status_denuncia`
--
ALTER TABLE `status_denuncia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `tipo_agressao`
--
ALTER TABLE `tipo_agressao`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `denuncia`
--
ALTER TABLE `denuncia`
  ADD CONSTRAINT `denuncia_ibfk_1` FOREIGN KEY (`denunciante_id`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `denuncia_ibfk_2` FOREIGN KEY (`vitima_id`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `denuncia_ibfk_3` FOREIGN KEY (`tipo_agressao_id`) REFERENCES `tipo_agressao` (`id`),
  ADD CONSTRAINT `denuncia_ibfk_4` FOREIGN KEY (`status_id`) REFERENCES `status_denuncia` (`id`);

--
-- Limitadores para a tabela `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`instituicao_id`) REFERENCES `instituicoes` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
