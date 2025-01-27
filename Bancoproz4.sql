drop database if exists Bancoproz4;
CREATE DATABASE IF NOT EXISTS Bancoproz4;
USE Bancoproz4;

CREATE TABLE Alunos (
    AlunoID INT PRIMARY KEY,
    PNome VARCHAR(50),
    UNome VARCHAR(50),
    Ano INT,
    Nota DECIMAL(4, 2)
);

CREATE TABLE Professores (
    ProfessorID INT PRIMARY KEY,
    PNome VARCHAR(50),
    UNome VARCHAR(50)
);

INSERT INTO Alunos (AlunoID, PNome, UNome, Ano, Nota) VALUES
(1, 'Ana', 'Silva', 1, 8.5),
(2, 'Bruno', 'Oliveira', 1, 7.0),
(3, 'Carla', 'Pereira', 2, 6.5),
(4, 'Daniel', 'Souza', 1, 9.0),
(5, 'Eduardo', 'Costa', 2, 7.5);

INSERT INTO Professores (ProfessorID, PNome, UNome) VALUES
(1, 'Fernando', 'Santos'),
(2, 'Gabriela', 'Moraes'),
(3, 'Helena', 'Almeida');

SELECT * FROM Alunos WHERE Nota > 7.0;

SELECT * FROM Alunos WHERE Ano = 1 AND Nota >= 8.0;

SELECT PNome, Nota FROM Alunos;

CREATE TABLE Professor (
    PNome VARCHAR(50),
    UNome VARCHAR(50)
);

CREATE TABLE Aluno (
    PNome VARCHAR(50),
    UNome VARCHAR(50)
);

INSERT INTO Professor (PNome, UNome) SELECT PNome, UNome FROM Professores;

INSERT INTO Aluno (PNome, UNome) SELECT PNome, UNome FROM Alunos;

SELECT PNome, UNome FROM Aluno
UNION
SELECT PNome, UNome FROM Professor;

SELECT PNome, UNome FROM Aluno
INNER JOIN Professor ON Aluno.PNome = Professor.PNome AND Aluno.UNome = Professor.UNome;

SELECT PNome, UNome FROM Aluno
WHERE (PNome, UNome) NOT IN (
    SELECT PNome, UNome FROM Professor
);
