drop database if exists Bancoproz;
CREATE DATABASE Bancoproz;
USE Bancoproz;

CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY,
    Nome VARCHAR(100),
    Cidade VARCHAR(50)
);

CREATE TABLE Pedidos (
    PedidoID INT PRIMARY KEY,
    Data DATE,
    ClienteID INT,
    Valor DECIMAL(10, 2),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

INSERT INTO Clientes (ClienteID, Nome, Cidade) VALUES
(1, 'João Silva', 'São Paulo'),
(2, 'Maria Oliveira', 'Rio de Janeiro'),
(3, 'Carlos Pereira', 'Belo Horizonte');

INSERT INTO Pedidos (PedidoID, Data, ClienteID, Valor) VALUES
(1, '2025-01-01', 1, 500.00),
(2, '2025-01-02', 2, 150.00),
(3, '2025-01-03', 1, 200.00),
(4, '2025-01-04', 3, 350.00);

SELECT Clientes.Nome, Clientes.Cidade, Pedidos.PedidoID, Pedidos.Data, Pedidos.Valor
FROM Clientes
JOIN Pedidos ON Clientes.ClienteID = Pedidos.ClienteID;

SELECT Clientes.Nome, Pedidos.PedidoID, Pedidos.Data, Pedidos.Valor
FROM Clientes
JOIN Pedidos ON Clientes.ClienteID = Pedidos.ClienteID
WHERE Clientes.Cidade = 'São Paulo';

show tables