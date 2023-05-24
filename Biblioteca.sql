CREATE DATABASE Biblioteca

USE Biblioteca

SET DATEFORMAT dmy

CREATE TABLE Usuarios (
	IDUsuario INT NOT NULL IDENTITY,
	nome VARCHAR(80) NOT NULL,
	RG CHAR(6) NOT NULL,
	sexo CHAR(1) NOT NULL,
	tipo VARCHAR(11) NOT NULL DEFAULT 'Discente',
	PRIMARY KEY (IDUsuario),
	UNIQUE (RG),
	CHECK (sexo IN ('M', 'F')),
	CHECK (tipo IN ('Docente', 'Discente', 'Funcionário'))
)

CREATE TABLE Livros (
	IDLivro INT NOT NULL IDENTITY,
	titulo VARCHAR(40) NOT NULL,
	genero VARCHAR(15),
	ano INT,
	situacao VARCHAR(10) NOT NULL DEFAULT 'Disponível',
	precoCusto NUMERIC(6,2) NOT NULL,
	PRIMARY KEY (IDLivro),
	CHECK (situacao IN ('Emprestado', 'Disponível'))
)

CREATE TABLE Emprestimos (
	IDEmprestimo INT NOT NULL IDENTITY,
	IDUsuario INT NOT NULL, 		
	IDLivro INT NOT NULL,
	dataSaida DATETIME NOT NULL,
	dataDevolucao DATETIME NOT NULL,
	PRIMARY KEY (IDEmprestimo),
	FOREIGN KEY (IDUsuario) REFERENCES Usuarios,
	FOREIGN KEY (IDLivro) REFERENCES Livros
)



INSERT INTO Usuarios VALUES ('Roberta Silva', '098786', 'F', 'Docente')
INSERT INTO Usuarios VALUES ('Mariana Torres', '123672', 'F', 'Discente')
INSERT INTO Usuarios VALUES ('Anderson Junqueira', '827460', 'M', default)
INSERT INTO Usuarios VALUES ('Daniela Amorim', '762548', 'F', 'Docente')
INSERT INTO Usuarios VALUES ('Pedro Henrique', '092637', 'M', 'Funcionário')
INSERT INTO Usuarios VALUES ('Ivo Marques', '937586', 'M', 'Docente')
INSERT INTO Usuarios VALUES ('Verônica Sales', '182710', 'F', default)
INSERT INTO Usuarios VALUES ('Marcos Andrade', '174593', 'M', 'Funcionário')

INSERT INTO Livros VALUES ('Dom Casmurro', 'Romance', 1900, 'Disponível', 56.50)
INSERT INTO Livros VALUES ('Harry Potter', 'Ficção', 1997, 'Emprestado', 61.38)
INSERT INTO Livros VALUES ('O Pequeno Príncipe', 'Ficção', 1943, 'Emprestado', 24.79)
INSERT INTO Livros VALUES ('Sistema de Banco de Dados', 'Informática', 1999, 'Disponível', 84.00)
INSERT INTO Livros VALUES ('Cálculo Diferencial', 'Matemática', 1992, 'Emprestado', 75.10)
INSERT INTO Livros VALUES ('Jogos Vorazes', 'Ficção', 2008, default, 37.08)
INSERT INTO Livros VALUES ('Use a Cabeça: SQL', 'Informática', 2003, 'Disponível', 79.00)
INSERT INTO Livros VALUES ('O Mundo de Sofia', 'Romance', 1990, 'Emprestado', 44.22)
INSERT INTO Livros VALUES ('Programando em SQL', 'Informática', 1990, default, 52.90)

INSERT INTO Emprestimos VALUES (5, 8, '02-10-2022', '17-10-2022')
INSERT INTO Emprestimos VALUES (5, 3, '02-11-2022', '22-11-2022')
INSERT INTO Emprestimos VALUES (7, 2, '12-07-2022', '27-07-2022')
INSERT INTO Emprestimos VALUES (2, 8, '06-12-2022', '21-12-2022')
INSERT INTO Emprestimos VALUES (2, 4, '06-12-2022', '21-12-2022')
INSERT INTO Emprestimos VALUES (3, 4, '23-11-2022', '05-12-2022')
INSERT INTO Emprestimos VALUES (8, 7, '20-01-2022', '05-02-2022')
INSERT INTO Emprestimos VALUES (8, 3, '06-11-2022', '21-11-2022')
INSERT INTO Emprestimos VALUES (4, 6, '02-10-2022', '22-10-2022')
INSERT INTO Emprestimos VALUES (4, 7, '01-11-2022', '16-11-2022')
INSERT INTO Emprestimos VALUES (1, 2, '18-03-2022', '03-04-2022')
INSERT INTO Emprestimos VALUES (1, 6, '22-10-2022', '02-11-2022')
INSERT INTO Emprestimos VALUES (1, 2, '22-10-2022', '02-11-2022')
INSERT INTO Emprestimos VALUES (7, 1, '30-08-2022', '15-09-2022')
INSERT INTO Emprestimos VALUES (5, 4, '02-09-2022', '17-09-2022')
INSERT INTO Emprestimos VALUES (8, 1, '15-10-2022', '30-10-2022')
INSERT INTO Emprestimos VALUES (2, 7, '12-06-2022', '22-06-2022')
INSERT INTO Emprestimos VALUES (1, 5, '12-06-2022', '27-06-2022')
INSERT INTO Emprestimos VALUES (7, 5, '10-08-2022', '30-08-2022')

SELECT * FROM Usuarios
SELECT * FROM Livros
SELECT * FROM Emprestimos

SELECT * FROM Emprestimos
WHERE dataSaida BETWEEN '01-11-2022' AND '30-11-2022'

SELECT nome, tipo FROM Usuarios 
ORDER BY nome

SELECT titulo, ano FROM Livros
WHERE situacao = 'Dispon�vel'

SELECT COUNT(*) AS 'Livros com custo � partir de 70' FROM Livros
WHERE precoCusto >= 70

SELECT idEmprestimo FROM Emprestimos
WHERE dataSaida BETWEEN '01-01-2022' AND '31-12-2022'

SELECT AVG(precoCusto) FROM Livros
WHERE ano >= 1970

SELECT * FROM Livros 
ORDER BY titulo

SELECT MAX (precoCusto) AS 'Livro mais caro ', MIN(precoCusto) AS 'Livro mais barato' FROM Livros

SELECT titulo, ano FROM Livros
WHERE genero = 'fic��o' OR genero = 'Romance'

SELECT * FROM Usuarios
WHERE IDUsuario = 4

SELECT DISTINCT genero FROM Livros

SELECT DISTINCT idUsuario FROM Emprestimos
WHERE dataSaida BETWEEN '01-10-2022' AND '31-12-2022'

SELECT titulo, precoCusto FROM Livros
WHERE genero = 'Inform�tica'

SELECT idUsuario, RG FROM Usuarios
WHERE nome = 'Pedro Henrique'

SELECT COUNT (*) AS 'Livros Fic��o' FROM Livros
WHERE genero = 'Fic��o'

SELECT ano, situacao FROM Livros
WHERE titulo = 'Harry Potter'

SELECT AVG (precoCusto) AS 'M�dia de pre�o dos livros lan�ados � partir de 2000' FROM Livros
WHERE ano >= 2000

SELECT titulo, genero FROM Livros
WHERE precoCusto >= 60

SELECT nome, RG FROM Usuarios
WHERE nome LIKE 'M%'

SELECT genero, COUNT (*) AS 'Quantidade' FROM Livros
GROUP BY genero

SELECT idUsuario, COUNT (*) AS 'Quantidade de emprestimos' FROM Emprestimos
GROUP BY IDUsuario

SELECT idLivro, COUNT (DISTINCT IdUsuario) AS ' Quantidade Usu�rios' FROM Emprestimos
GROUP BY IDLivro


-- Usuarios que fizeram emprestimo
SELECT DISTINCT nome FROM Usuarios, Emprestimos
WHERE Usuarios.IDUsuario = Emprestimos.IDUsuario

SELECT nome FROM Usuarios
WHERE IDUsuario IN
	(SELECT IDUsuario FROM Emprestimos)

-- Nome e tipo de usu�rios que fizeram emprestimo em outubro
SELECT nome, tipo FROM Usuarios WHERE IDUsuario
	IN(SELECT IDUsuario FROM Emprestimos WHERE dataSaida BETWEEN '01-10-2022' AND '30-10-2022')

-- Titulo e genero de livros emprestados de Mar�o a junho
SELECT titulo, genero FROM Livros WHERE IDLivro
	IN(SELECT IDLivro FROM Emprestimos WHERE dataSaida BETWEEN '01-03-2022' AND '30-06-2022')

-- Usuarios e sexo que fizeram emprestimo de livro de fic��o
SELECT DISTINCT RG, sexo FROM Livros, Emprestimos, Usuarios
WHERE Livros.IDLivro = Emprestimos.IDLivro AND Usuarios.IDUsuario = Emprestimos.IDUsuario 
AND genero = 'Fic��o'

SELECT RG, sexo FROM Usuarios
WHERE IDUsuario IN
	(SELECT IDUsuario FROM Emprestimos WHERE IDLivro IN
		(SELECT IDLivro FROM Livros WHERE genero = 'Fic��o'))

-- Generos emprestados a professores
SELECT DISTINCT genero FROM Usuarios, Livros, Emprestimos
WHERE Livros.IDLivro = Emprestimos.IDLivro AND Usuarios.IDUsuario = Emprestimos.IDUsuario 
AND tipo = 'Docente'

SELECT DISTINCT genero FROM Livros
WHERE IDLivro IN
	(SELECT IDLivro FROM Emprestimos WHERE IDUsuario IN
		(SELECT IDUsuario FROM Usuarios WHERE tipo = 'Docente'))

-- Qual a quantidade de usu�rios de cada sexo que fizeram empr�stimo de livros de inform�tica?
SELECT sexo, COUNT (*) AS 'Quantidade de usu�rios que fizeram empr�stimo de livro de inform�tica' FROM Emprestimos, Usuarios, Livros
WHERE Usuarios.IDUsuario = Emprestimos.IDUsuario AND Livros.IDLivro = Emprestimos.IDLivro
AND genero = 'Inform�tica'
GROUP BY sexo

--Qual o custo m�dio dos livros de fic��o emprestados a discentes?

SELECT AVG (precoCusto) AS 'Pre�o m�dio' FROM Livros
WHERE genero = 'Fic��o' AND IDLivro IN
	(SELECT IDLivro FROM Emprestimos WHERE IDUsuario IN
		(SELECT IDUsuario FROM Usuarios WHERE tipo = 'Discente'))

-- Qual o nome de todos os usu�rios que n�o fizeram empr�stimos de livros?
SELECT nome FROM Usuarios
WHERE IDUsuario NOT IN
	(SELECT IDUsuario FROM Emprestimos)

-- Nome de usu�rios que pegaram o livro mais caro
SELECT nome FROM Usuarios U, Livros L, Emprestimos E
WHERE U.IDUsuario = E.IDUsuario AND L.IDLivro = E.IDLivro 
AND precoCusto = (SELECT MAX (precoCusto) FROM Livros)
ORDER BY nome

-- Titulos dos livros com pre�o maior que o pre�o m�dio 
SELECT titulo, precoCusto FROM Livros
WHERE precoCusto > (SELECT AVG(PrecoCusto) FROM Livros)
ORDER BY precoCusto

-- Para cada empr�stimo do livro Use a Cabe�a: SQL, listar o nome do usu�rio e a data de devolu��o.
SELECT Usuarios.nome, Emprestimos.dataDevolucao FROM Usuarios, Livros, Emprestimos
WHERE Usuarios.IDUsuario = Emprestimos.IDEmprestimo AND Livros.IDLivro = Emprestimos.IDLivro
AND Livros.titulo = 'Use a cabe�a: SQL'

-- Para cada empr�stimo, exibir o nome e o RG do usu�rio, o t�tulo e o g�nero do livro, e a data de sa�da. 
SELECT U.nome, U.RG, L.titulo, L.genero, E.dataSaida FROM Usuarios U, Livros L, Emprestimos E
WHERE U.IDUsuario = E.IDUsuario AND L.IDLivro = E.IDLivro

-- Para cada empr�stimo, exibir o nome do usu�rio, a data de sa�da do empr�stimo, a quantidade de livros emprestados e o pre�o de custo total.
SELECT U.nome, E.dataSaida, COUNT(L.idlivro) AS 'Quantidade livros', SUM (L.precoCusto) FROM Usuarios U, Livros L, Emprestimos E
WHERE U.IDUsuario = E.IDUsuario AND L.IDLivro = E.IDLivro
GROUP BY nome, dataSaida


-- Fun��es

-- Crie uma fun��o chamada QuantLivrosGenero que receba por par�metro o nome de um
--g�nero e retorne a quantidade de livros daquele g�nero existentes na biblioteca. (Obs:
--Nesse caso, o g�nero do livro tem que ser exato para garantir que haja apenas um
-- resultado)
CREATE FUNCTION QuantLivrosGenero (@genero VARCHAR(20))
RETURNS INT AS
BEGIN 
	DECLARE @quant INT 
	SET @quant = (SELECT COUNT(*) FROM Livros
	WHERE genero = @genero)
	RETURN @quant
END

SELECT dbo.QuantLivrosGenero('Fic��o')

-- Crie uma fun��o chamada QuantEmprestimosLivro que receba por par�metro o t�tulo
--de um livro e retorne a quantidade de vezes que ele j� foi emprestado. (Obs: Nesse caso,
-- o t�tulo do livro tem que ser exato para garantir que haja apenas um resultado)

CREATE FUNCTION QuantEmprestimosLivro (@titulo VARCHAR(50))
RETURNS INT AS
BEGIN
	DECLARE @quantEmprestimos INT, @codigo INT
	SET @codigo = (SELECT idLivro FROM Livros WHERE titulo = @titulo)
	SET @quantEmprestimos = (SELECT COUNT(*) FROM Emprestimos WHERE IDLivro = @codigo)
	RETURN @quantEmprestimos
END

SELECT dbo.QuantEmprestimosLivro ('Harry Potter')

-- Crie uma fun��o chamada EmprestimosMesAno que receba por par�metro o nome de
--um m�s e um ano e retorne os dados (nome do usu�rio, t�tulo do livro, dataSa�da) de
--todos os empr�stimos realizados naquele m�s e ano. (Dica: a fun��o DATENAME pode
--ser usada para descobrir o nome do m�s de uma determinada data, e a fun��o YEAR
--pode ser usada para descobrir o ano de uma determinada data.)

CREATE FUNCTION EmprestimosMesAno (@mes VARCHAR (15), @ano INT)
RETURNS TABLE AS
RETURN (SELECT U.nome, L.titulo, E.datasaida FROM Usuarios U 
INNER JOIN Emprestimos E ON U.IDUsuario = E.IDUsuario 
INNER JOIN Livros L ON E.IDLivro = L.IDLivro WHERE DATENAME (MONTH, dataSaida) = @mes AND YEAR (dataSaida) = @ano)

SELECT * FROM EmprestimosMesAno ('Novembro',2022)

--Crie uma fun��o chamada GeneroPreferido que receba por par�metro o nome de um
--usu�rio e retorne o g�nero de livros que o usu�rio mais pegou emprestado, com a
--respectiva quantidade de empr�stimos feitos. (Dica: Calcule a quantidade de
--empr�stimos por g�nero, depois ordene os resultados e utilize a fun��o TOP para obter
--apenas o dado que interessa)

CREATE FUNCTION GeneroPreferido (@usuario VARCHAR(50))
RETURNS TABLE AS
RETURN 
	SELECT TOP 1 L.genero, COUNT(idEmprestimo) FROM Usuarios U 
	INNER JOIN Emprestimos E ON U.IDUsuario = E.IDUsuario 
	INNER JOIN Livros L ON E.IDLivro = L.IDLivro 
	WHERE U.nome = @usuario
	GROUP BY L.genero
	ORDER BY COUNT (idEmprestimo) DESC

SELECT genero FROM GeneroPreferido ('Roberta Silva')

-- PROCEDIMENTOS

SELECT * FROM Usuarios
SELECT * FROM Emprestimos
SELECT * FROM Livros

-- Criar procedimento para consultar os dados dos livros que est�o emprestados (com par�metro)
CREATE PROCEDURE LivrosStatus (@status VARCHAR(12)) AS
	SELECT * FROM Livros WHERE situacao = @status

EXEC LivrosStatus 'Emprestado'

-- Criar procedimento para consultar os dados dos livros que est�o emprestados (sem par�metros)
CREATE PROCEDURE LivrosEmprestados AS
	SELECT * FROM Livros WHERE situacao = 'Emprestado'

EXEC LivrosEmprestados

-- Criar procedimento para consultar os dados dos livros que est�o dispon�veis (sem par�metros)
CREATE PROCEDURE LivrosDisponiveis AS
	SELECT * FROM Livros WHERE situacao = 'Dispon�vel'

EXEC LivrosDisponiveis

-- Criar procedimento para atualizar o pre�o de um livro a partir de seu t�tulo
CREATE PROCEDURE AtualizaPreco (@livro VARCHAR(50), @novoValor NUMERIC(10,2)) AS
BEGIN
	DECLARE	@codigo INT

	SET @codigo = (SELECT IDLivro FROM Livros WHERE Titulo = @livro)

	UPDATE Livros
	SET precoCusto = @novoValor
	WHERE IDLivro = @codigo
END

EXEC AtualizaPreco 'Dom Casmurro', 80.32
EXEC AtualizaPreco 'Jogos Vorazes', 50

-- Criar procedimento para excluir um usu�rio e seus respectivos empr�stimos a partir de seu nome
CREATE PROCEDURE ExcluiUsuario (@usuario VARCHAR(50)) AS
BEGIN
	DECLARE @codigo INT

	SET @codigo = (SELECT IDUsuario FROM Usuarios WHERE Nome = @usuario)

	DELETE FROM Emprestimos 
	WHERE IDUsuario = @codigo

	DELETE FROM Usuarios
	WHERE IDUsuario = @codigo
END

EXEC ExcluiUsuario 'Marcos Andrade'

-- Criar procedimento para excluir um livro e indicar num par�metro de sa�da quantos empr�stimos foram exclu�dos
CREATE OR ALTER PROCEDURE ExcluiLivro (@livro VARCHAR (50), @quantExclusoes INT OUTPUT) AS
BEGIN
	DECLARE @codigo INT

	SET @codigo = (SELECT IDLivro FROM Livros WHERE titulo = @livro)

	SET @quantExclusoes = (SELECT COUNT(IDEmprestimo) FROM Emprestimos WHERE IDLivro = @codigo)

	DELETE FROM Emprestimos WHERE IDLivro = @codigo

	DELETE FROM Livros WHERE IDLivro = @codigo
END

-- Para que o valor seja guardado em uma vari�vel enviada como par�metro, � necess�rio
-- criar um bloco de c�digo
BEGIN
	DECLARE @exclusoes INT
	EXEC ExcluiLivro 'Harry Potter', @exclusoes OUTPUT
	PRINT CAST(@exclusoes AS VARCHAR(4)) + ' empr�stimos foram exclu�dos'
END

-- Criar procedimento para povoar uma tabela com dados gen�ricos (Dica: fun��es CAST e ROUND podem ajudar)

CREATE TABLE Cursos(
	ID int NOT NULL,
	nome VARCHAR(20) NOT NULL,
	quantVagas INT NOT NULL
)

CREATE PROCEDURE InsereCursos (@quant INT) AS
BEGIN
	DECLARE @codigo INT, @curso VARCHAR(10), @vagas INT, @quantLinhas INT

	-- Cada registro ser� inserido no padr�o (x, 'Cursox', y), sendo x um n�mero incremental e y um n�mero aleat�rio

	-- � necess�rio descobrir quantas linhas a tabela j� tem para calcular qual ser� o pr�ximo ID.
	-- Caso esteja vazia, o c�digo mais recente ser� zero. Caso contr�rio, ser� o maior valor da tabela.
	SET @quantLinhas = (SELECT COUNT(*) FROM Cursos)

	IF(@quantLinhas = 0)
		SET @codigo = 0
	ELSE
		SET @codigo = (SELECT MAX(ID) FROM Cursos)

	WHILE (@quant > 0) -- Controle de quantos registros ser�o inseridos
	BEGIN
		SET @codigo = @codigo + 1
		SET @curso = 'Curso' + CAST(@codigo AS VARCHAR(3)) -- A fun��o CAST transforma um tipo em outro
		SET @vagas = CAST(Rand() * 100 AS INT)	-- A fun��o RAND retorna um n�mero decimal aletar�rio entre 0 e 1

		INSERT INTO Cursos VALUES (@codigo, @curso, @vagas)
	
		SET @quant = @quant - 1
	END
END

EXEC InsereCursos 5
SELECT * FROM Cursos

-- GATILHOS

-- Regra de Neg�cio: Sempre que um empr�stimo � feito, a situa��o do livro deve mudar
-- para emprestado. Crie um gatilho chamado RealizaEmprestimo para atualizar a situa��o
-- de um livro a cada empr�stimo cadastrado.

CREATE TRIGGER RealizaEmprestimo ON Emprestimos FOR INSERT AS
BEGIN
	DECLARE @livro INT

	SET @livro = (SELECT idLivro FROM INSERTED)

	UPDATE Livros
	SET situacao = 'Emprestado' WHERE idLivro = @livro
END

-- Um livro n�o pode ser emprestado caso n�o esteja dispon�vel. Altere
-- o gatilho RealizaEmprestimo para verificar a situa��o de um livro a cada empr�stimo
-- cadastrado. Caso o empr�stimo seja poss�vel, as a��es anteriores devem ser mantidas.
-- Caso contr�rio, deve ser exibida uma mensagem de erro adequada e a transa��o deve ser desfeita.

ALTER TRIGGER RealizaEmprestimo ON Emprestimos FOR INSERT AS 
BEGIN 
	DECLARE @livro INT, @situacao VARCHAR(15)

	SET @livro = (SELECT idLivro FROM INSERTED)
	SET @situacao = (SELECT situacao FROM Livros WHERE IDLivro = @livro)

	IF (@situacao = 'Dispon�vel')
	BEGIN
		UPDATE Livros
		SET situacao = 'Emprestado' WHERE IDLivro = @livro
	END
	ELSE 
	BEGIN
		PRINT 'O livro n�o est� dispon�vel para emprestimo !'
		ROLLBACK
	END
END

-- O prazo de devolu��o para discentes � de 20 dias, e para docentes e
-- funcion�rios � de 30 dias. Crie um gatilho chamado DefinePrazo para atualizar a data de
-- devolu��o, de acordo com o tipo de usu�rio, a cada empr�stimo cadastrado. (Dica: a
-- fun��o DateAdd ( ) pode ser usada para adicionar dias, meses ou anos a uma
-- determinada data)

CREATE TRIGGER DefinePrazo ON Emprestimos FOR INSERT AS
BEGIN
	DECLARE 
	@usuario INT,
	@livro INT,
	@tipoU VARCHAR(15),
	@dias INT,
	@dataEmprestimo DATETIME

	SET @dataEmprestimo = (SELECT dataSaida FROM INSERTED)
	SET @livro = (SELECT idlivro FROM INSERTED)
	SET @usuario = (SELECT idUsuario FROM INSERTED)
	SET @tipoU = (SELECT tipo FROM Usuarios WHERE IDUsuario = @usuario)

	IF (@tipoU = 'Discente')
	BEGIN
		SET @dias = 20
	END
	ELSE
	BEGIN
		SET @dias = 30
	END

	UPDATE Emprestimos
	SET dataDevolucao = DATEADD(day, @dias, @dataEmprestimo) 
	WHERE IDLivro = @livro AND IDUsuario = @usuario AND dataSaida = @dataEmprestimo

END


