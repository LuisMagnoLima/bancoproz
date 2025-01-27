drop database if exists Bancoproz;
CREATE DATABASE IF NOT EXISTS Bancoproz;
USE Bancoproz;

CREATE TABLE if not exists Cliente (
    Identificador INT PRIMARY KEY,
    Nome VARCHAR(50),
    Telefone LONGTEXT,
    Endereco VARCHAR(255),
    Email TEXT
);

INSERT INTO Cliente (Identificador, Nome, Telefone, Endereco, Email) VALUES
(1, 'Reinaldo', '68 0945-8723', 'Rua 10, 34, São Paulo, SP, 12345-000, Brasil', 'reinaldo000@gmail.com'),
(2, 'Nestor', '92 5400-0043', 'Avenida Bela, 45, Paulo Afonso, BA, 00034-000, Brasil', 'nestor123@gmail.com'),
(3, 'Raquel', '87 4300-0000', 'Rua Cardoso, 100, Salvador, BA, 22222-000, Brasil', 'raquel@outlook.com'),
(4, 'Tati', '41 5400-1232', 'Bairro Canoa, 002, Rio de Janeiro, RJ, 34251-324, Brasil', 'tati000@gmail.com'),
(5, 'Lia', '98 1234-5678', 'Rua 50, 41, Maceió, AL, 32450-435, Brasil', 'lia@outlook.com'),
(6, 'Paty', '71 2123-2425', 'Rua 01, 500, Pinheiros, SP, 90000-000, Brasil', 'paty@outlook.com');

Select * from Cliente;
