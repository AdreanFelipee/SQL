CREATE DATABASE Fidelizacao

USE Fidelizacao

SET DATEFORMAT dmy

CREATE TABLE Clientes(
	idCliente INT NOT NULL IDENTITY,
	nome VARCHAR(40) NOT NULL,
	CPF CHAR(11) NOT NULL,
	profissao VARCHAR (20) NOT NULL,
	saldoPontos INT NOT NULL DEFAULT 0,

	PRIMARY KEY (idCliente),
	UNIQUE (CPF),
	CHECK (saldoPontos >=0)
)

CREATE TABLE Compras (
	idCompras INT NOT NULL IDENTITY,
	idCliente INT NOT NULL,
	data DATETIME NOT NULL,
	valor NUMERIC (9,2) NOT NULL,
	pontosGanhos INT NOT NULL,

	PRIMARY KEY (idCompras),
	FOREIGN KEY (idCliente) REFERENCES Clientes,
	CHECK (Valor > 0),
	CHECK (pontosGanhos > 0)
)

CREATE TABLE Premios(
	idPremio int NOT NULL IDENTITY,
	descricao varchar(20) NOT NULL,
	valorPontos int NOT NULL,
	quantEstoque int NOT NULL,
	PRIMARY KEY (idPremio),
	CHECK (valorPontos > 0),
	CHECK (quantEstoque >= 0)
)

CREATE TABLE Trocas(
	idTroca int NOT NULL IDENTITY,
	idCliente int NOT NULL,
	idPremio int NOT NULL,
	quantidade int NOT NULL,
	data datetime NOT NULL,
	PRIMARY KEY (idTroca),
	FOREIGN KEY (idCliente) REFERENCES Clientes,
	FOREIGN KEY (idPremio) REFERENCES Premios,
	CHECK (quantidade > 0)
)

INSERT INTO Clientes VALUES ('André Carneiro','3252541','Carteiro',80)
INSERT INTO Clientes VALUES ('Márcio Rodrigues','4812072','Engenheiro',65)
INSERT INTO Clientes VALUES ('Cristina Santana','6971238','Contadora',100)
INSERT INTO Clientes VALUES ('Michele Medeiros','9068131','Professora',90)
INSERT INTO Clientes VALUES ('Daniel Maia','0258136','Bancário',120)
INSERT INTO Clientes VALUES ('Larissa Gomes','3254170','Professora',215)
INSERT INTO Clientes VALUES ('Rafaela Costa','9801170','Arquiteta',270)
INSERT INTO Clientes VALUES ('César Fernandes','7428109','Dentista',200)


INSERT INTO Compras VALUES (1,'02-09-2019',22.78,07)
INSERT INTO Compras VALUES (2,'12-10-2019',50.32,14)
INSERT INTO Compras VALUES (4,'30-11-2019',123.14,25)
INSERT INTO Compras VALUES (3,'08-01-2018',108.22,19)
INSERT INTO Compras VALUES (2,'12-01-2020',349.06,92)
INSERT INTO Compras VALUES (5,'22-02-2018',225.56,45)
INSERT INTO Compras VALUES (6,'22-03-2018',79,34)
INSERT INTO Compras VALUES (1,'02-11-2019',63.12,18)
INSERT INTO Compras VALUES (6,'28-07-2019',55.49,16)
INSERT INTO Compras VALUES (8,'17-08-2019',25.29,08)

INSERT INTO Premios VALUES ('Bolsa (100% couro)',300,5)
INSERT INTO Premios VALUES ('Bolsa (palha)',80,12)
INSERT INTO Premios VALUES ('Relógio masculino',160,3)
INSERT INTO Premios VALUES ('Boné (100% algodão)',40,10)
INSERT INTO Premios VALUES ('Óculos',27,30)
INSERT INTO Premios VALUES ('Chaveiro',9, 110)
INSERT INTO Premios VALUES ('Caneta',7,92)

INSERT INTO Trocas VALUES (1,3,2,'15-10-2019')
INSERT INTO Trocas VALUES (2,6,1,'29-01-2019')
INSERT INTO Trocas VALUES (3,7,1,'12-01-2019')
INSERT INTO Trocas VALUES (6,4,1,'15-10-2018')
INSERT INTO Trocas VALUES (5,3,1,'24-10-2018')
INSERT INTO Trocas VALUES (2,2,1,'06-02-2018')
INSERT INTO Trocas VALUES (4,6,2,'12-10-2018')
INSERT INTO Trocas VALUES (5,6,1,'15-12-2019')
INSERT INTO Trocas VALUES (6,7,1,'17-03-2018')

-- Quais os nomes e profissões dos clientes que têm 200 pontos ou mais?
SELECT nome, profissao FROM Clientes
WHERE saldoPontos > 200

-- Quais os nomes dos clientes que trocaram seus pontos por relógios ou bolsas?
SELECT nome FROM Clientes C, Trocas T, Premios P
WHERE C.idCliente = T.idCliente AND T.idPremio = P.idPremio
AND (P.descricao LIKE '%Relógio%' OR descricao LIKE '%Bolsa%')

SELECT nome FROM Clientes
WHERE idCliente IN
	(SELECT idCliente FROM Trocas WHERE idPremio IN 
		(SELECT idPremio FROM Premios WHERE descricao LIKE 'Relógio%' OR descricao LIKE 'Bolsa%'))

-- Quais as descrições dos prêmios disponíveis para troca?
SELECT descricao FROM Premios
WHERE quantEstoque > 0

-- Qual o valor total dos prêmios trocados em janeiro de 2019?
SELECT SUM (valorPontos) AS 'Valor total' FROM Premios P, Trocas T
WHERE P.idPremio = T.idPremio AND data BETWEEN '01-01-2019' AND '31-01-2019'

-- Qual a descrição e valor dos prêmios que começam com B ou S (em ordem decrescente de valor)?
SELECT descricao, valorPontos FROM Premios
WHERE descricao LIKE'B%' OR descricao LIKE 'S%'
ORDER BY valorPontos desc

-- Qual a média de pontos ganhos nas compras?
SELECT AVG(pontosGanhos) AS 'Média pontos ganhos' FROM Compras

-- Para cada prêmio, exibir a descrição e a quantidade de vezes que já foi trocado.
SELECT descricao, COUNT (*) AS 'Quantidade de trocas' FROM Premios P, Trocas T
WHERE P.idPremio = T.idPremio
GROUP BY descricao

-- Para cada cliente, exibir o nome e o total de pontos ganhos em todas as compras.
SELECT nome, SUM(pontosGanhos) AS 'Total pontos ganhos' FROM Clientes, Compras
WHERE Clientes.idCliente = Compras.idCliente
GROUP BY nome

-- Para cada troca, exibir o nome do cliente, a descrição do prêmio e a data.
SELECT nome, descricao, data FROM Clientes C, Trocas T, Premios P
WHERE C.idCliente = T.idCliente AND P.idPremio = T.idPremio

-- Quais os códigos dos prêmios trocados em outubro de 2018?
SELECT idPremio FROM Trocas
WHERE data BETWEEN '01-10-2018' AND '31-10-2018'