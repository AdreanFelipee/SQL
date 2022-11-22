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
WHERE situacao = 'Disponível'

SELECT COUNT(*) AS 'Livros com custo à partir de 70' FROM Livros
WHERE precoCusto >= 70

SELECT idEmprestimo FROM Emprestimos
WHERE dataSaida BETWEEN '01-01-2022' AND '31-12-2022'

SELECT AVG(precoCusto) FROM Livros
WHERE ano >= 1970

SELECT * FROM Livros 
ORDER BY titulo

SELECT MAX (precoCusto), MIN(precoCusto) FROM Livros

SELECT titulo, ano FROM Livros
WHERE genero = 'ficção' OR genero = 'Romance'

SELECT * FROM Usuarios
WHERE IDUsuario = 4

SELECT DISTINCT genero FROM Livros

SELECT DISTINCT idUsuario FROM Emprestimos
WHERE dataSaida BETWEEN '01-10-2022' AND '31-12-2022'

SELECT titulo, precoCusto FROM Livros
WHERE genero = 'Informática'

SELECT idUsuario, RG FROM Usuarios
WHERE nome = 'Pedro Henrique'

SELECT COUNT (*) AS 'Livros Ficção' FROM Livros
WHERE genero = 'Ficção'

SELECT ano, situacao FROM Livros
WHERE titulo = 'Harry Potter'

SELECT AVG (precoCusto) AS 'Média de preço dos livros lançados à partir de 2000' FROM Livros
WHERE ano >= 2000

SELECT titulo, genero FROM Livros
WHERE precoCusto >= 60

SELECT nome, RG FROM Usuarios
WHERE nome LIKE 'M%'

SELECT genero, COUNT (*) AS 'Quantidade' FROM Livros
GROUP BY genero

SELECT idUsuario, COUNT (*) AS 'Quantidade de emprestimos' FROM Emprestimos
GROUP BY IDUsuario

SELECT idLivro, COUNT (DISTINCT IdUsuario) AS ' Quantidade Usuários' FROM Emprestimos
GROUP BY IDLivro


-- Usuarios que fizeram emprestimo
SELECT DISTINCT nome FROM Usuarios, Emprestimos
WHERE Usuarios.IDUsuario = Emprestimos.IDUsuario

SELECT nome FROM Usuarios
WHERE IDUsuario IN
	(SELECT IDUsuario FROM Emprestimos)

-- Nome e tipo de usuários que fizeram emprestimo em outubro
SELECT nome, tipo FROM Usuarios WHERE IDUsuario
	IN(SELECT IDUsuario FROM Emprestimos WHERE dataSaida BETWEEN '01-10-2022' AND '30-10-2022')

-- Titulo e genero de livros emprestados de Março a junho
SELECT titulo, genero FROM Livros WHERE IDLivro
	IN(SELECT IDLivro FROM Emprestimos WHERE dataSaida BETWEEN '01-03-2022' AND '30-06-2022')

-- Usuarios e sexo que fizeram emprestimo de livro de ficção
SELECT DISTINCT RG, sexo FROM Livros, Emprestimos, Usuarios
WHERE Livros.IDLivro = Emprestimos.IDLivro AND Usuarios.IDUsuario = Emprestimos.IDUsuario 
AND genero = 'Ficção'

SELECT RG, sexo FROM Usuarios
WHERE IDUsuario IN
	(SELECT IDUsuario FROM Emprestimos WHERE IDLivro IN
		(SELECT IDLivro FROM Livros WHERE genero = 'Ficção'))

-- Generos emprestados a professores
SELECT DISTINCT genero FROM Usuarios, Livros, Emprestimos
WHERE Livros.IDLivro = Emprestimos.IDLivro AND Usuarios.IDUsuario = Emprestimos.IDUsuario 
AND tipo = 'Docente'

SELECT DISTINCT genero FROM Livros
WHERE IDLivro IN
	(SELECT IDLivro FROM Emprestimos WHERE IDUsuario IN
		(SELECT IDUsuario FROM Usuarios WHERE tipo = 'Docente'))

-- Qual a quantidade de usuários de cada sexo que fizeram empréstimo de livros de informática?
SELECT sexo, COUNT (*) AS 'Quantidade de usuários que fizeram empréstimo de livro de informática' FROM Emprestimos, Usuarios, Livros
WHERE Usuarios.IDUsuario = Emprestimos.IDUsuario AND Livros.IDLivro = Emprestimos.IDLivro
AND genero = 'Informática'
GROUP BY sexo

--Qual o custo médio dos livros de ficção emprestados a discentes?

SELECT AVG (precoCusto) AS 'Preço médio' FROM Livros
WHERE genero = 'Ficção' AND IDLivro IN
	(SELECT IDLivro FROM Emprestimos WHERE IDUsuario IN
		(SELECT IDUsuario FROM Usuarios WHERE tipo = 'Discente'))

-- Qual o nome de todos os usuários que não fizeram empréstimos de livros?
SELECT nome FROM Usuarios
WHERE IDUsuario NOT IN
	(SELECT IDUsuario FROM Emprestimos)

-- Nome de usuários que pegaram o livro mais caro
SELECT nome FROM Usuarios U, Livros L, Emprestimos E
WHERE U.IDUsuario = E.IDUsuario AND L.IDLivro = E.IDLivro 
AND precoCusto = (SELECT MAX (precoCusto) FROM Livros)

-- Titulos dos livros com preço maior que o preço médio 
SELECT titulo, precoCusto FROM Livros
WHERE precoCusto > (SELECT AVG(PrecoCusto) FROM Livros)
ORDER BY precoCusto

-- Para cada empréstimo do livro Use a Cabeça: SQL, listar o nome do usuário e a data de devolução.
SELECT Usuarios.nome, Emprestimos.dataDevolucao FROM Usuarios, Livros, Emprestimos
WHERE Usuarios.IDUsuario = Emprestimos.IDEmprestimo AND Livros.IDLivro = Emprestimos.IDLivro
AND Livros.titulo = 'Use a cabeça: SQL'

-- Para cada empréstimo, exibir o nome e o RG do usuário, o título e o gênero do livro, e a data de saída. 
SELECT U.nome, U.RG, L.titulo, L.genero, E.dataSaida FROM Usuarios U, Livros L, Emprestimos E
WHERE U.IDUsuario = E.IDUsuario AND L.IDLivro = E.IDLivro

-- Para cada empréstimo, exibir o nome do usuário, a data de saída do empréstimo, a quantidade de livros emprestados e o preço de custo total.
SELECT U.nome, E.dataSaida, COUNT(L.idlivro) AS 'Quantidade livros', SUM (L.precoCusto) FROM Usuarios U, Livros L, Emprestimos E
WHERE U.IDUsuario = E.IDUsuario AND L.IDLivro = E.IDLivro
GROUP BY nome, dataSaida


