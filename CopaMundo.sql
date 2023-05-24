CREATE DATABASE CopaDoMundo

USE CopaDoMundo

SET DATEFORMAT dmy

CREATE TABLE Estadios(
	idEstadio INT IDENTITY, 
	Nome VARCHAR(100) NOT NULL,
	Cidade VARCHAR(80) NOT NULL, 
	Capacidade INT NOT NULL,

	PRIMARY KEY (idEstadio),
	CHECK(Capacidade > 0)
)

INSERT INTO Estadios VALUES
('Al Thumama', 'Doha', 40000),
('Khalifa International', 'Doha', 40000),
('Ahmad bin Ali', 'Al Rayyan', 40000),
('Al Bayt', 'Al Khor', 60000),
('Lusail', 'Lusail', 80000),
('Al Janoub', 'Al Wakrah', 40000),
('Education City', 'Al Rayyan', 40000)

CREATE TABLE Selecoes(
	idSelecao INT IDENTITY, 
	Pais VARCHAR(40) NOT NULL, 
	GolsMarcados INT NOT NULL, 
	GolsSofridos INT NOT NULL,
	Pontos INT NOT NULL,

	PRIMARY KEY (idSelecao),
	CHECK (GolsMarcados >= 0),
	CHECK (GolsSofridos >= 0),
	CHECK (Pontos >= 0)
)

INSERT INTO Selecoes VALUES
('Catar', 1, 7, 0),
('Fran�a', 6, 3, 6),
('Marrocos', 4, 1, 7),
('Brasil', 3, 1, 6),
('Portugal', 6, 4, 6),
('Holanda', 5, 1, 7),
('Argentina', 5, 2, 6),
('Cro�cia', 4, 1, 5),
('Pol�nia', 2, 2, 4),
('Alemanha', 6, 5, 4)

CREATE TABLE Partidas(
	idPartida INT IDENTITY,
	Data DATE NOT NULL,
	Hora TIME NOT NULL, 
	PublicoEstimado INT NOT NULL,
	Time1 INT NOT NULL,
	Placar1 INT NOT NULL,
	Time2 INT NOT NULL,
	Placar2 INT NOT NULL,
	Resultado VARCHAR(50) DEFAULT NULL,
	Local INT NOT NULL,

	PRIMARY KEY (idPartida),
	FOREIGN KEY (Time1) REFERENCES Selecoes,
	FOREIGN KEY (Time2) REFERENCES Selecoes,
	FOREIGN KEY (Local) REFERENCES Estadios,
	CHECK (PublicoEstimado > 0),
	CHECK (Placar1 >= 0),
	CHECK (Placar2 >= 0)
)

INSERT INTO Partidas VALUES 
('25/11/2022', '16:00:00', 30000, 2, 2, 4, 1, 'Fran�a', 2),
('27/11/2022', '13:00:00', 40000, 3, 0, 1, 0, 'Empate', 1),
('30/11/2022', '07:00:00', 55000, 4, 1, 5, 2, 'Portugal', 4),
('02/12/2022', '11:00:00', 68000, 7, 0, 10, 3, null, 5),
('05/12/2022', '16:00:00', 38000, 9, 2, 6, 1, null, 3)

SELECT * FROM Estadios
SELECT * FROM Selecoes
SELECT * FROM Partidas

CREATE PROCEDURE excluiEstadios (@estadio VARCHAR(40)) AS
BEGIN
	DECLARE @codigo INT
	SET @codigo = (SELECT idEstadio FROM Estadios WHERE Cidade = @estadio)
	
	DELETE FROM Partidas WHERE local = @codigo
	DELETE FROM Estadios WHERE idEstadio = @codigo
	
END

DROP PROCEDURE excluiEstadios
EXEC excluiEstadios 'Doha'

CREATE TRIGGER verificaPartida ON PARTIDAS
FOR INSERT AS
BEGIN

DECLARE 
	@IdPartida INT,
	@codEstadio INT,
	@idEstadio INT,
	@publicoPresente INT,
	@capacidadeEstadio INT,
	@placarTime1 INT,
	@placarTime2 INT,
	@IDTime1 INT,
	@IDTime2 INT,
	@NomeTime1 VARCHAR(40),
	@NomeTime2 VARCHAR(40)

SET @IDPartida = (SELECT idPartida FROM inserted)
SET @idEstadio = (SELECT Local FROM inserted)
SET @placarTime1 = (SELECT Placar1 FROM inserted)
SET @placarTime2 = (SELECT Placar2 FROM inserted)
SET @IDTime1 = (SELECT Time1 FROM inserted)
SET @IDTime2 = (SELECT Time2 FROM inserted)
SET @NomeTime1 = (SELECT Pais from Selecoes, Partidas  WHERE Selecoes.idSelecao = @IDTime1 and Partidas.idPartida = @IDPartida)
SET @NomeTime2 = (SELECT Pais from Selecoes, Partidas WHERE Selecoes.idSelecao = @IDTime2 and Partidas.idPartida = @IDPartida)

SET @codEstadio = (SELECT idEstadio FROM Estadios WHERE idEstadio = @idEstadio)
SET @capacidadeEstadio = (SELECT capacidade FROM Estadios where idEstadio = @codEstadio)
SET @publicoPresente = (SELECT PublicoEstimado FROM inserted)

IF( @capacidadeEstadio < @publicoPresente)
	BEGIN
		ROLLBACK
		PRINT 'Partida não pode ocorrer, público estimado maior que capacidade'
	END
ELSE
	BEGIN
		IF(@placarTime1 > @placarTime2)
		BEGIN
			UPDATE Partidas SET Resultado = @NomeTime1 WHERE Partidas.idPartida = @IDPartida
		END
		IF(@placarTime1 < @placarTime2)
		BEGIN
			UPDATE Partidas SET Resultado = @NomeTime2 WHERE Partidas.idPartida = @IDPartida
		END
		IF(@placarTime1 = @placarTime2)
		BEGIN
			UPDATE Partidas SET Resultado = 'EMPATE' WHERE Partidas.idPartida = @IDPartida
		END
	END
	ROLLBACK
	PRINT ‘Partida finalizada com sucesso!’
END

CREATE TRIGGER atualizaSelecoes ON Partidas
FOR INSERT AS
BEGIN
	DECLARE 
		@idPartida INT,
		@placarSelecao1 INT,
		@placarSelecao2 INT,
		@IDSelecao1 INT,
		@IDSelecao2 INT

	SET @idPartida = (SELECT idPartida FROM inserted)
	SET @placarSelecao1 = (SELECT placar1 FROM inserted)
	SET @placarSelecao2 = (SELECT placar2 FROM inserted) 
	SET @IDSelecao1 = (SELECT Time1 FROM inserted)
	SET @IDSelecao2 = (SELECT Time2 FROM inserted)
IF(@placarTime1 > @placarTime2)
	BEGIN
		UPDATE Selecoes SET Pontos = Pontos + 3 WHERE @IDTime1 = idSelecao1
	END

	IF(@placarTime2 > @placarTime1)

	BEGIN
		UPDATE Selecoes SET Pontos = Pontos + 3 WHERE @IDTime2 = idSelecao2
	END

	IF(@placarTime1 = @placarTime2)
	BEGIN
		UPDATE Selecoes SET Pontos = Pontos + 1 WHERE @IDTime1 = idSelecao1
		UPDATE Selecoes SET Pontos = Pontos + 1 WHERE @IDTime2 = idSelecao2
	ENd

END


