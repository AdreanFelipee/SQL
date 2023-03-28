CREATE DATABASE AgenciaBancaria

USE AgenciaBancaria

CREATE TABLE Contas(
	idConta int not null identity,
	numAgencia char(6) not null,
	numConta char(8) not null,
	nomeCliente varchar(40) not null,
	saldo numeric(8,2) not null default 0,
	tipo char(9) not null,
	PRIMARY KEY(idConta),
	CHECK (tipo IN ('Corrente', 'Poupança'))
)

INSERT INTO Contas VALUES ('2281-0','786821-3', 'Augusto Moreira', 500,'Corrente')
INSERT INTO Contas VALUES ('2281-0','837101-4', 'Eliane Lima', 730, 'Poupança')
INSERT INTO Contas VALUES ('4978-1','261842-5', 'Romeu Gomes', 100, 'Corrente')
INSERT INTO Contas VALUES ('4978-1','035190-2', 'Lia Gonzaga', 1080, 'Poupança')
INSERT INTO Contas VALUES ('3300-9','698541-0', 'Thaísa Martins', 250, 'Corrente')

CREATE TABLE Movimentacoes(
	idMovimentacao int not null identity,
	idConta int not null,
	data date not null,
	valor numeric (8,2) not null,
	tipoMov char(8) not null,
	PRIMARY KEY (idMovimentacao),
	FOREIGN KEY (idConta) REFERENCES Contas,
	CHECK (tipoMov in ('Deposito','Saque')),
	CHECK (valor > 0)	
)

INSERT INTO Movimentacoes VALUES (1, '10/02/2020', 50, 'Deposito')
INSERT INTO Movimentacoes VALUES (2, '05/04/2020', 180, 'Saque')
INSERT INTO Movimentacoes VALUES (3, '21/07/2020', 80, 'Saque')
INSERT INTO Movimentacoes VALUES (2, '30/07/2020', 100, 'Deposito')
INSERT INTO Movimentacoes VALUES (4, '08/10/2020', 50, 'Saque')
INSERT INTO Movimentacoes VALUES (5, '15/12/2020', 200, 'Deposito')
INSERT INTO Movimentacoes VALUES (4, '02/03/2021', 300, 'Saque')

-- Visualizando os dados das tabelas
SELECT * FROM Contas
SELECT * FROM Movimentacoes

-- Criando um gatilho para atualizar o saldo sempre que uma movimentação for cadastrada.
-- Se for um saque, o saldo deverá diminuir. Se for um depósito, o saldo deverá aumentar.
CREATE TRIGGER AtualizaSaldo ON Movimentacoes FOR INSERT AS
BEGIN
	-- Criando varíáveis
	DECLARE
	@conta INT,
	@valor NUMERIC (8,2),
	@tipo CHAR(8)

	-- Atribuindo valores para as variáveis
	SET @conta = (SELECT idConta FROM INSERTED)
	SET @valor = (SELECT valor FROM INSERTED)
	SET @tipo = (SELECT tipoMov FROM INSERTED)

	-- As três instruções acima poderiam ser substituídas por uma só, usando SELECT
	-- SELECT @conta = idConta, @valor = valor, @tipo = tipoMov FROM INSERTED

	IF (@tipo = 'Saque')
	BEGIN
		UPDATE Contas
		SET saldo = saldo - @valor
		WHERE idConta = @conta
	END

	ELSE
	BEGIN
		UPDATE Contas
		SET saldo = saldo + @valor
		WHERE idConta = @conta
	END
END

-- Inserindo dados para observar as alterações
INSERT INTO Movimentacoes VALUES (4, '21/06/2021', 380,'Saque')
SELECT * FROM Contas
SELECT * FROM Movimentacoes

INSERT INTO Movimentacoes VALUES (3, '21/06/2021', 220, 'Deposito')
SELECT * FROM Contas
SELECT * FROM Movimentacoes

-- Para realizar um saque, é necessário garantir que o cliente tenha saldo suficiente.
-- Sendo assim, o gatilho AtualizaSaldo precisa ser modificado para testar essa condição.
ALTER TRIGGER AtualizaSaldo ON Movimentacoes FOR INSERT AS
BEGIN
	-- Criando varíáveis
	DECLARE
	@conta INT,
	@valor NUMERIC (8,2),
	@tipo CHAR(8),
	@saldo NUMERIC(8,2)

	-- Atribuindo valores para as variáveis
	SET @conta = (SELECT idConta FROM INSERTED)
	SET @valor = (SELECT valor FROM INSERTED)
	SET @tipo = (SELECT tipoMov FROM INSERTED)

	-- As três instruções acima poderiam ser substituídas por uma só, usando SELECT
	-- SELECT @conta = idConta, @valor = valor, @tipo = tipoMov FROM INSERTED

	IF (@tipo = 'Saque')
	BEGIN
		SET @saldo = (SELECT saldo FROM Contas WHERE idConta = @conta)
		IF (@saldo >= @valor)
		BEGIN
			UPDATE Contas
			SET saldo = saldo - @valor
			WHERE idConta = @conta
		END

		ELSE
		BEGIN
			PRINT 'Não há saldo suficiente! Saque não realizado!'
			ROLLBACK
		END
	END

	ELSE
	BEGIN
		UPDATE Contas
		SET saldo = saldo + @valor
		WHERE idConta = @conta
	END
END

-- Inserindo dados para observar as alterações
INSERT INTO Movimentacoes VALUES (5, '21/06/2021', 300,'Saque')
SELECT * FROM Contas
SELECT * FROM Movimentacoes