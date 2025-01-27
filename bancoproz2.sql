
DROP DATABASE IGREJA;
CREATE DATABASE IF NOT EXISTS Igreja;
USE Igreja;

CREATE TABLE IF NOT EXISTS Membros (
    id_membro INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    telefone VARCHAR(20),
    endereco TEXT,
    data_nascimento DATE,
    data_entrada DATE
);

CREATE TABLE IF NOT EXISTS Ministerios (
    id_ministerio INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome VARCHAR(100),
    descricao LONGTEXT,
    id_membro INT NOT NULL,
    FOREIGN KEY (id_membro) REFERENCES Membros(id_membro)
);

CREATE TABLE IF NOT EXISTS Locais (
    id_local INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    endereco LONGTEXT,
    capacidade INT,
    descricao LONGTEXT
);

CREATE TABLE IF NOT EXISTS Eventos (
    id_evento INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    descricao LONGTEXT,
    tipo VARCHAR(100),
    data_inicio DATETIME NOT NULL,
    data_fim DATETIME,
    id_local INT,
    FOREIGN KEY (id_local) REFERENCES Locais(id_local)
);

CREATE TABLE IF NOT EXISTS Reunioes (
    id_reuniao INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    descricao LONGTEXT,
    tipo VARCHAR(100),
    data_inicio DATETIME NOT NULL,
    data_fim DATETIME,
    id_ministerio INT,
    id_local INT,
    FOREIGN KEY (id_ministerio) REFERENCES Ministerios(id_ministerio),
    FOREIGN KEY (id_local) REFERENCES Locais(id_local)
);

INSERT INTO Membros (nome, email, telefone, endereco, data_nascimento, data_entrada)
VALUES
('José Vicente', 'josevicente@email.com', '98912345678', 'Rua Grande, 123, Centro, São Luís, MA', '2000-01-15', CURDATE()),
('Yan Garrido', 'yangarrido@email.com', '98923456789', 'Avenida Litorânea, 456, Calhau, São Luís, MA', '2001-05-22', CURDATE()),
('Luis Guilherme', 'luisguilherme@email.com', '98934567890', 'Rua Portugal, 789, Praia Grande, São Luís, MA', '2002-08-10', CURDATE()),
('Luis Magno', 'luismagno@email.com', '98945678901', 'Rua São Pantaleão, 321, Madre Deus, São Luís,MA', '2003-11-30', CURDATE()),
('Marcos André', 'marcosandre@email.com', '98956789012', 'Avenida dos Holandeses, s/n, Olho d’Água, São Luís, MA', '2004-02-18', CURDATE()),
('João', 'joao@email.com', '98967890123', 'Rua das Hortas, 1001, Centro, São Luís, MA', '2000-09-10', CURDATE()),
('Juan', 'juan@email.com', '98978901234', 'Avenida Guajajaras, 10, São Cristóvão, São Luís, MA', '2001-03-25', CURDATE());

INSERT INTO Ministerios (nome, descricao, id_membro)
VALUES
('Ministério de Adoração', 'Responsável pela música e louvor da igreja', 1),
('Ministério Infantil', 'Ministério dedicado ao cuidado das crianças', 2),
('Ministério de Ensino', 'Responsável pelos estudos bíblicos e seminários', 3),
('Ministério de Oração', 'Grupo de oração pela igreja e pela comunidade', 4),
('Ministério de Louvor', 'Grupo responsável pelo louvor da igreja', 5),
('Ministério Jovem', 'Grupo de jovens para atividades e cultos especiais', 6);

INSERT INTO Locais (nome, endereco, capacidade, descricao)
VALUES
('Igreja Central', 'Rua da Paz, 101, Centro, São Luís, MA', 200, 'Local de culto principal'),
('Igreja Filial', 'Avenida Brasil, 202, Cohab, São Luís, MA', 100, 'Local para encontros menores'),
('Auditório', 'Rua do Sol, 303, Centro, São Luís, MA', 150, 'Auditório para eventos e reuniões');

INSERT INTO Eventos (nome, descricao, tipo, data_inicio, data_fim, id_local)
VALUES
('Culto de Adoração', 'Culto semanal para louvor e adoração', 'Culto', '2024-11-25 19:00:00', '2024-11-25 21:00:00', 1),
('Seminário de Liderança', 'Seminário sobre liderança cristã', 'Seminário', '2024-12-01 09:00:00', '2024-12-01 17:00:00', 2),
('Palestra sobre Família', 'Palestra com foco na educação familiar', 'Palestra', '2024-12-10 19:00:00', '2024-12-10 21:00:00', 1);

INSERT INTO Reunioes (nome, descricao, tipo, data_inicio, data_fim, id_ministerio, id_local)
VALUES
('Reunião de Oração', 'Encontro semanal de oração', 'Reunião de oração', '2024-11-26 19:00:00', '2024-11-26 20:30:00', 1, 1),
('Reunião de Planejamento', 'Reunião de planejamento da equipe de eventos', 'Reunião de planejamento', '2024-11-29 09:00:00', '2024-11-29 12:00:00', 2, 2);

SELECT 
    Membros.nome AS Nome_Membro,
    Ministerios.nome AS Nome_Ministerio,
    Ministerios.descricao AS Descricao_Ministerio
FROM 
    Membros
LEFT JOIN 
    Ministerios ON Membros.id_membro = Ministerios.id_membro;

SELECT 
    Eventos.nome AS Nome_Evento,
    Eventos.descricao AS Descricao_Evento,
    Locais.nome AS Nome_Local,
    Locais.endereco AS Endereco_Local
FROM 
    Eventos
INNER JOIN 
    Locais ON Eventos.id_local = Locais.id_local;

SELECT 
    Reunioes.nome AS Nome_Reuniao,
    Reunioes.descricao AS Descricao_Reuniao,
    Ministerios.nome AS Nome_Ministerio,
    Locais.nome AS Nome_Local
FROM 
    Reunioes
INNER JOIN 
    Ministerios ON Reunioes.id_ministerio = Ministerios.id_ministerio
INNER JOIN 
    Locais ON Reunioes.id_local = Locais.id_local;

CREATE TABLE IF NOT EXISTS Historico_Eventos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_evento INT,
    alteracao VARCHAR(255),
    data_alteracao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

CREATE TRIGGER apos_atualizacao_evento
AFTER UPDATE ON Eventos
FOR EACH ROW
BEGIN
    INSERT INTO Historico_Eventos (id_evento, alteracao)
    VALUES (NEW.id_evento, CONCAT('Evento alterado de "', OLD.nome, '" para "', NEW.nome, '"'));
END //

CREATE TRIGGER antes_inserir_evento
BEFORE INSERT ON Eventos
FOR EACH ROW
BEGIN
    IF NEW.data_fim IS NULL THEN
        SET NEW.data_fim = DATE_ADD(NEW.data_inicio, INTERVAL 2 HOUR);
    END IF;
END //

DELIMITER ;
