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

-- Quais os nomes e profiss�es dos clientes que t�m 200 pontos ou mais?
SELECT nome, profissao FROM Clientes
WHERE saldoPontos > 200

-- Quais os nomes dos clientes que trocaram seus pontos por rel�gios ou bolsas?
SELECT nome FROM Clientes C, Trocas T, Premios P
WHERE C.idCliente = T.idCliente AND T.idPremio = P.idPremio
AND (P.descricao LIKE '%Rel�gio%' OR descricao LIKE '%Bolsa%')

SELECT nome FROM Clientes
WHERE idCliente IN
	(SELECT idCliente FROM Trocas WHERE idPremio IN 
		(SELECT idPremio FROM Premios WHERE descricao LIKE 'Rel�gio%' OR descricao LIKE 'Bolsa%'))

-- Quais as descri��es dos pr�mios dispon�veis para troca?
SELECT descricao FROM Premios
WHERE quantEstoque > 0

-- Qual o valor total dos pr�mios trocados em janeiro de 2019?
SELECT SUM (valorPontos) AS 'Valor total' FROM Premios P, Trocas T
WHERE P.idPremio = T.idPremio AND data BETWEEN '01-01-2019' AND '31-01-2019'

-- Qual a descri��o e valor dos pr�mios que come�am com B ou S (em ordem decrescente de valor)?
SELECT descricao, valorPontos FROM Premios
WHERE descricao LIKE'B%' OR descricao LIKE 'S%'
ORDER BY valorPontos desc

-- Qual a m�dia de pontos ganhos nas compras?
SELECT AVG(pontosGanhos) AS 'M�dia pontos ganhos' FROM Compras

-- Para cada pr�mio, exibir a descri��o e a quantidade de vezes que j� foi trocado.
SELECT descricao, COUNT (*) AS 'Quantidade de trocas' FROM Premios P, Trocas T
WHERE P.idPremio = T.idPremio
GROUP BY descricao

-- Para cada cliente, exibir o nome e o total de pontos ganhos em todas as compras.
SELECT nome, SUM(pontosGanhos) AS 'Total pontos ganhos' FROM Clientes, Compras
WHERE Clientes.idCliente = Compras.idCliente
GROUP BY nome

-- Para cada troca, exibir o nome do cliente, a descri��o do pr�mio e a data.
SELECT nome, descricao, data FROM Clientes C, Trocas T, Premios P
WHERE C.idCliente = T.idCliente AND P.idPremio = T.idPremio

-- Quais os c�digos dos pr�mios trocados em outubro de 2018?
SELECT idPremio FROM Trocas
WHERE data BETWEEN '01-10-2018' AND '31-10-2018'

-- FUN��ES


--Crie uma fun��o chamada MediaComprasFeitas que receba por par�metro o nome de um cliente e retorne o valor m�dio das compras feitas por ele.

CREATE FUNCTION MediaComprasFeitas (@nome VARCHAR(50))
RETURNS NUMERIC (10,2) AS
BEGIN 
	DECLARE @codigo INT, @media NUMERIC(10,2)
	SET @codigo = (SELECT idCliente FROM Clientes WHERE nome = @nome)
	SET @media = (SELECT AVG(valor) FROM Compras WHERE idCliente = @codigo)

	RETURN @media
END

SELECT dbo.MediaComprasFeitas ('Cristina Santana') 'M�dia Compras'

-- Crie uma fun��o chamada PremiosTrocadosPer�odo que receba por par�metro duas datas e retorne a quantidade total de pr�mios que foram trocadas nesse per�odo.
CREATE FUNCTION PremiosTrocadosPeriodo (@dataI DATETIME, @dataF DATETIME)
RETURNS INT AS
BEGIN
	DECLARE @quant INT
	SET @quant = (SELECT SUM(quantidade) FROM Trocas WHERE data BETWEEN @dataI AND @dataF)
	RETURN @quant
END

SELECT dbo.PremiosTrocadosPeriodo ('01/07/2018', '31/12/2018') 'Quantidade no per�odo'

-- Crie uma fun��o chamada GastoM�ximoCliente que receba por par�metro o CPF de um cliente e retorne o maior valor de uma compra feita por ele.
CREATE FUNCTION GastoMaximoCliente (@cpf CHAR (11))
RETURNS NUMERIC (10,2) AS
BEGIN
	DECLARE @codigo INT, @valorMax NUMERIC (10,2)
	SET @codigo = (SELECT idCliente FROM Clientes WHERE CPF = @cpf)
	SET @valorMax = (SELECT MAX(valor) FROM Compras WHERE idCliente = @codigo)
	RETURN @valorMAx
END

SELECT dbo.GastoMaximoCliente ('3252541')
SELECT dbo.GastoMaximoCliente (CPF) 'Valor m�ximo' FROM Clientes WHERE nome = 'Daniel Maia'

-- Crie uma fun��o chamada HistoricoTrocasPremio que receba por par�metro a descri��o de um pr�mio e um ano, e retorne o nome do cliente e a data de cada troca daquele pr�mio realizada naquele ano.
CREATE FUNCTION HistoricoTrocasPremio (@desc VARCHAR(50), @ano INT)
RETURNS TABLE AS
RETURN
SELECT C.nome, T.data FROM Clientes C INNER JOIN
Trocas T ON C.idCliente = T.idCliente INNER JOIN
Premios P ON T.idCliente = P.idPremio
WHERE P.descricao = @desc AND YEAR(data) = @ano

SELECT * FROM HistoricoTrocasPremio ('Chaveiro', 2019) ORDER BY nome

-- PROCEDIMENTOS

-- Crie um procedimento chamado PremiosEstoqueBaixo que exiba a descri��o e a
-- quantidade em estoque dos pr�mios que tenham menos de 10 unidades dispon�veis. Em
-- seguida, execute esse procedimento.

CREATE PROCEDURE PremiosEstoqueBaixo AS
SELECT descricao, quantEstoque FROM Premios
WHERE quantEstoque < 10

EXEC PremiosEstoqueBaixo

-- Crie um procedimento chamado PremiosMaisValiosos que exiba todos os dados dos
-- cinco pr�mios com maior valor em pontos em ordem decrescente. Em seguida, execute
-- esse procedimento.

CREATE PROCEDURE PremiosMaisValiosos AS
SELECT TOP 5 * FROM Premios
ORDER BY valorPontos DESC

EXEC PremiosMaisValiosos

-- Crie um procedimento chamado AtualizaProfissao que receba por par�metro o nome de
-- um cliente e sua nova profiss�o e atualize seu cadastro.

CREATE PROCEDURE AtualizaProfissao (@cliente VARCHAR (50), @novaProfissao VARCHAR(40)) AS
BEGIN 
	DECLARE @codigo INT
	SET @codigo = (SELECT idCliente FROM Clientes WHERE nome = @cliente)

	UPDATE Clientes
	SET profissao = @novaProfissao
	WHERE idCliente = @codigo
END

SELECT nome, profissao FROM Clientes
EXEC AtualizaProfissao 'Daniel Maia', 'Padeiro'

-- Crie um procedimento chamado AtualizaPontuacao que receba por par�metro um
-- IDCompra e uma nova quantidade de pontos ganhos e, al�m de atualizar a tabela
-- Compras, atualize tamb�m o saldo de pontos do respectivo Cliente. (Dica: dependendo
-- do novo valor, essa atualiza��o poder� aumentar ou diminuir o saldo do cliente)

CREATE PROCEDURE AtualizaPontucao (@compra INT, @novaPontuacao INT) AS
BEGIN 
	DECLARE @pontuacaoAtual INT, @cliente INT, @diferenca INT
	
	SET @cliente = (SELECT idcliente FROM Compras WHERE idCompras = @compra)

	SET @pontuacaoAtual = (SELECT PontosGanhos FROM Compras WHERE idCompras = @compra)

	UPDATE Compras SET pontosGanhos = @novaPontuacao
	WHERE idCompras = @compra

	IF (@novaPontuacao > @pontuacaoAtual)
	BEGIN
		SET @diferenca = @novaPontuacao - @pontuacaoAtual

		UPDATE Clientes SET saldoPontos = saldoPontos + @diferenca
		WHERE idCliente = @cliente
	END
	ELSE
	BEGIN
		SET @diferenca = @pontuacaoAtual - @novaPontuacao

		UPDATE Clientes SET saldoPontos = saldoPontos - @diferenca
		WHERE idCliente = @cliente
	END
END

EXEC AtualizaPontucao 3, 70
EXEC AtualizaPontucao 3, 10

-- Crie um procedimento chamado ExcluiClientes que receba por par�metro o nome de um cliente e exclua todos os seus dados do sistema.

CREATE PROCEDURE ExcluiClientes (@cliente VARCHAR(60)) AS
BEGIN
	DECLARE @codigo INT

	SET @codigo = (SELECT idCliente FROM Clientes WHERE nome = @cliente)

	DELETE FROM Compras 
	WHERE idCliente = @codigo

	DELETE FROM Trocas
	WHERE idCliente = @codigo
	
	DELETE FROM Clientes 
	WHERE idCliente = @codigo
END

SELECT * FROM Clientes

EXEC ExcluiClientes 'Larissa Gomes'
