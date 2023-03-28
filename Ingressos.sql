CREATE DATABASE VendaIngressos

USE vendaIngressos

SET DATEFORMAT dmy

CREATE TABLE Eventos(
	idEvento int NOT NULL IDENTITY,
	titulo varchar(40) NOT NULL,
	local varchar(50) NOT NULL,
	cidade varchar(50) NOT NULL,
	dataHora datetime NOT NULL,
	tipo char(4) NOT NULL,
	PRIMARY KEY(idEvento),
	CHECK(tipo IN ('Show','Jogo'))
)


CREATE TABLE Shows(
	idShow int NOT NULL,
	artista varchar(50) NOT NULL,
	genero varchar(30),
	censura char(8) NOT NULL DEFAULT 'Livre',
	PRIMARY KEY(idShow),
	FOREIGN KEY(idShow) REFERENCES Eventos,
	CHECK (censura IN ('Livre', '14 anos', '18 anos'))	
)

CREATE TABLE Jogos(
	idJogo int NOT NULL,
	esporte varchar(40) NOT NULL,
	time1 varchar(30) NOT NULL,
	time2 varchar(30) NOT NULL,
	PRIMARY KEY(idJogo),
	FOREIGN KEY(idJogo) REFERENCES Eventos,
	CHECK (time1 <> time2)
)

CREATE TABLE Ingressos(
	idIngresso int NOT NULL IDENTITY,
	idEvento int NOT NULL,	
	valor numeric(9,2) NOT NULL,
	setor varchar(20) NOT NULL,
	situacao char(10) NOT NULL DEFAULT 'Disponível',
	PRIMARY KEY (idIngresso),
	FOREIGN KEY (idEvento) REFERENCES Eventos,
	CHECK (valor > 0),
	CHECK (setor IN ('Pista', 'Mesa', 'Camarote','Arquibancada', 'Arquibancada coberta','Cadeira')),
	CHECK (situacao IN ('Disponível', 'Vendido', 'Reservado'))
)

CREATE TABLE Clientes(
	idCliente int NOT NULL IDENTITY,
	nome varchar(50) NOT NULL,
	CPF char(7) NOT NULL,
	sexo char(1) NOT NULL,
	dataNascim datetime NOT NULL,
	PRIMARY KEY (idCliente),
	UNIQUE (CPF),
	CHECK (sexo in ('M','F')),
)

CREATE TABLE Vendas (
	idVenda int NOT NULL IDENTITY,
	idCliente int NOT NULL,
	idIngresso int NOT NULL,
	data datetime NOT NULL,
	tipo char(7) NOT NULL DEFAULT 'Inteira',
	desconto int NOT NULL DEFAULT 0,
	valor numeric(9,2) DEFAULT 0,
	formaPagam char(7) NOT NULL DEFAULT 'À vista',
	PRIMARY KEY (idVenda),
	FOREIGN KEY (idCliente) REFERENCES Clientes,
	FOREIGN KEY (idIngresso) REFERENCES Ingressos,
	CHECK (tipo IN ('Inteira','Meia')),
	CHECK (valor >= 0),
	CHECK (formaPagam IN ('À vista', 'Cheque', 'Cartão'))
)


INSERT INTO Eventos VALUES ('Final Campeonato Paulista', 'Morumbi', 'São Paulo','31-05-2019 17:00:00', 'Jogo')
INSERT INTO Eventos VALUES ('Farewell Tour', 'Chevrolet Hall', 'Recife','18-03-2020 21:00:00', 'Show')
INSERT INTO Eventos VALUES ('Paraíba Beer', 'Forrock', 'João Pessoa','21-04-2020 16:00:00', 'Show')
INSERT INTO Eventos VALUES ('Jogos Escolares Municipais', 'Almeidão', 'João Pessoa','18-12-2019 08:00:00', 'Jogo')
INSERT INTO Eventos VALUES ('Festival de Jazz', 'Teatro Paulo Pontes', 'João Pessoa','22-07-2020 19:00:00', 'Show')
INSERT INTO Eventos VALUES ('Final Copa Mercosul', 'Maracanã', 'Rio de Janeiro','02-06-2020 16:30:00', 'Jogo')
INSERT INTO Eventos VALUES ('Eliminatória Torneio Copacabana', 'Posto 6', 'Rio de Janeiro','07-08-2019 10:30:00', 'Jogo')
INSERT INTO Eventos VALUES ('Viva La Vida', 'Morumbi', 'São Paulo','28-02-2020 21:20:00', 'Show')
INSERT INTO Eventos VALUES ('Trivela', 'Vila Folia', 'Natal','21-08-2020 22:00:00', 'Show')
INSERT INTO Eventos VALUES ('Volta às Aulas', 'Teatro Paulo Pontes', 'João Pessoa','31-01-2019 10:00:00', 'Show')

INSERT INTO Shows VALUES (2,'A-ha', 'Pop', 'Livre')
INSERT INTO Shows VALUES (3,'Belo, Revelação, Saia Rodada', 'Pagode', '14 anos')
INSERT INTO Shows VALUES (5,'Vários', 'Jazz', 'Livre')
INSERT INTO Shows VALUES (8,'Coldplay', 'Pop', 'Livre')
INSERT INTO Shows VALUES (9,'Asa de Águia', 'Axé', '14 anos')
INSERT INTO Shows VALUES (10,'Cover Backyardigans', 'Infantil', 'Livre')

INSERT INTO Jogos VALUES (1,'Futebol', 'São Paulo', 'Santos')
INSERT INTO Jogos VALUES (4,'Basquete', 'Geo Sul', 'Liceu')
INSERT INTO Jogos VALUES (6,'Futebol', 'Flamengo', 'São Paulo')
INSERT INTO Jogos VALUES (7,'Futvolei', 'Ipanema', 'Leblon')

INSERT INTO Ingressos VALUES (1,35.22,'Arquibancada','Vendido')
INSERT INTO Ingressos VALUES (1,35.22,'Arquibancada',default)
INSERT INTO Ingressos VALUES (1,35.22,'Arquibancada','Reservado')
INSERT INTO Ingressos VALUES (1,55.44,'Arquibancada coberta',default)
INSERT INTO Ingressos VALUES (1,55.44,'Arquibancada coberta',default)
INSERT INTO Ingressos VALUES (1,35.22,'Arquibancada','Vendido')
INSERT INTO Ingressos VALUES (2,100,'Pista','Vendido')
INSERT INTO Ingressos VALUES (2,100,'Pista','Vendido')
INSERT INTO Ingressos VALUES (2,100,'Pista','Vendido')
INSERT INTO Ingressos VALUES (3,30,'Pista','Vendido')
INSERT INTO Ingressos VALUES (3,50,'Camarote',default)
INSERT INTO Ingressos VALUES (3,70,'Mesa','Vendido')
INSERT INTO Ingressos VALUES (3,70,'Mesa','Vendido')
INSERT INTO Ingressos VALUES (3,50,'Camarote','Vendido')
INSERT INTO Ingressos VALUES (4,15,'Arquibancada','Vendido')
INSERT INTO Ingressos VALUES (4,22,'Arquibancada coberta',default)
INSERT INTO Ingressos VALUES (4,38,'Cadeira','Reservado')
INSERT INTO Ingressos VALUES (4,38,'Cadeira',default)
INSERT INTO Ingressos VALUES (6,50,'Cadeira','Vendido')
INSERT INTO Ingressos VALUES (6,22,'Arquibancada',default)
INSERT INTO Ingressos VALUES (7,10,'Arquibancada',default)
INSERT INTO Ingressos VALUES (7,10,'Arquibancada',default)
INSERT INTO Ingressos VALUES (7,10,'Arquibancada',default)
INSERT INTO Ingressos VALUES (8,300,'Pista','Vendido')
INSERT INTO Ingressos VALUES (8,450,'Camarote','Vendido')
INSERT INTO Ingressos VALUES (8,300,'Pista','Vendido')
INSERT INTO Ingressos VALUES (8,450,'Camarote','Vendido')
INSERT INTO Ingressos VALUES (10,12,'Arquibancada','Vendido')
INSERT INTO Ingressos VALUES (10,12,'Arquibancada',default)

INSERT INTO Clientes VALUES ('Marli Saldanha','3252541','F','03-10-1980')
INSERT INTO Clientes VALUES ('Ludmila Borba','4812072','F','30-04-1972')
INSERT INTO Clientes VALUES ('Armando Guimarães','6971238','M','10-08-1990')
INSERT INTO Clientes VALUES ('Diego Moraes','9068131','M','06-06-1982')
INSERT INTO Clientes VALUES ('Iago Martins','0258136','M','02-07-1994')
INSERT INTO Clientes VALUES ('Adriano Roque','3254170','M','14-06-1998')
INSERT INTO Clientes VALUES ('Tadeu Machado','7865325','M','23-11-1981')
INSERT INTO Clientes VALUES ('Ellen Tavares','9080482','F','10-04-1982')
INSERT INTO Clientes VALUES ('Miguel Silveira','6998768','M','10-08-1990')
INSERT INTO Clientes VALUES ('Horácio Lopes','1239068','M','06-06-1982')
INSERT INTO Clientes VALUES ('Morgana Siqueira','8836216','F','22-04-1998')
INSERT INTO Clientes VALUES ('Talita Delgado','0027170','F','03-11-1986')

INSERT INTO Vendas VALUES (1,1,'11-02-2019',default,default,default,'Cheque')
INSERT INTO Vendas VALUES (3,27,'21-01-2020',default,default,default,default)
INSERT INTO Vendas VALUES (7,6,'18-03-2019','Meia',default,default,'Cartão')
INSERT INTO Vendas VALUES (9,12,'29-01-2020',default,default,default,'Cheque')
INSERT INTO Vendas VALUES (2,26,'06-12-2019',default,default,default,default)
INSERT INTO Vendas VALUES (11,25,'29-12-2019','Meia',default,default,default)
INSERT INTO Vendas VALUES (12,7,'13-02-2020','Meia',default,default,'Cartão')
INSERT INTO Vendas VALUES (1,8,'02-01-2020',default,default,default,default)
INSERT INTO Vendas VALUES (4,10,'15-03-2020',default,default,default,default)
INSERT INTO Vendas VALUES (8,9,'19-02-2020','Meia',default,default,'Cartão')
INSERT INTO Vendas VALUES (9,24,'30-11-2019',default,default,default,'Cartão')
INSERT INTO Vendas VALUES (10,19,'22-04-2020','Meia',default,default,default)
INSERT INTO Vendas VALUES (6,15,'07-09-2019',default,default,default,'Cartão')
INSERT INTO Vendas VALUES (5,13,'05-03-2020','Meia',default,default,default)
INSERT INTO Vendas VALUES (4,14,'02-04-2020',default,default,default,'Cheque')

-- Criar uma visão IngressosVendidos para exibir o nome do cliente, o título, a data e o tipo do evento, e o valor e a forma de pagamento de cada venda realizada.
CREATE VIEW IngressosVendidos AS
SELECT C.nome 'Cliente', E.titulo 'Evento', E.dataHora 'Data', E.tipo 'TipoEvento', V.valor 'Valor', V.formapagam 'FormaPagamento'
FROM Clientes C INNER JOIN Vendas V ON c.idCliente = v.idCliente
INNER JOIN Ingressos i ON V.idIngresso = i.idIngresso
INNER JOIN Eventos E ON i.idEvento = e.idEvento

-- Considerando a visão IngressosVendidos, exibir a quantidade de ingressos vendidos para cada evento, indicando quantos foram vendidos com cada forma de pagamento. (Obs: o ORDER BY foi usado apenas para melhorar a visualização)
SELECT evento, formaPagamento, COUNT(*) 'Quantidade Vendida'
FROM IngressosVendidos
GROUP BY Evento, FormaPagamento
ORDER BY Evento

-- Considerando a visão IngressosVendidos, exibir o nome dos quatro primeiros clientes a comprarem ingressos por mais de R$ 100 para shows.
SELECT TOP 4 Cliente FROM IngressosVendidos
WHERE TipoEvento = 'Show' AND valor > 100

-- Criar uma visão DadosJogos2019 para exibir o título, a cidade e o esporte dos jogos marcados para 2019.
CREATE VIEW DadosJogos2019 AS
SELECT E.titulo 'Evento', cidade, esporte FROM Eventos E
INNER JOIN Jogos J ON E.idEvento = J.idJogo
WHERE YEAR (dataHora) = 2019

-- Usando as visões IngressosVendidos e DadosJogos2019, exibir o valor médio pago por um ingresso.
SELECT AVG (valor) 'PrecoMedio' FROM DadosJogos2019 DJ
INNER JOIN IngressosVendidos IV ON DJ.Evento = IV.Evento

-- A partir da visão IngressosVendidos, criar uma visão ArrecadacaoTotal para exibir, para cada evento, o nome, a quantidade de ingressos vendidos e o valor total arrecadado.
CREATE VIEW ArrecadacaoTotal AS
SELECT Evento, COUNT(*) 'QuantidadeVendida', SUM (valor) 'ValorTotal' FROM IngressosVendidos
GROUP BY Evento

-- Considerando a visão ArrecadacaoTotal, exibir o nome dos eventos que tiveram mais de 2 ingressos vendidos ou que arrecadaram mais de R$ 50.
SELECT Evento FROM ArrecadacaoTotal
WHERE QuantidadeVendida > 2 OR ValorTotal > 50

-- Criar uma visão IngressosPorCliente para exibir o nome e a quantidade de ingressos comprados por cada cliente (inclusive os que ainda não fizeram compras).
CREATE VIEW IngressosPorCliente AS
SELECT Cliente, COUNT(*) 'IngressosComprados' FROM Clientes C
LEFT JOIN IngressosVendidos I ON C.nome = I.Cliente
GROUP BY Cliente

-- Usando a visão IngressosPorCliente, exibir a quantidade de clientes de cada sexo que compraram mais de um ingresso.

SELECT C.sexo, COUNT(*) 'QuantidadeClientes' FROM Clientes C
INNER JOIN IngressosPorCliente I ON c.nome = I.Cliente
WHERE IngressosComprados > 1
GROUP BY c.sexo