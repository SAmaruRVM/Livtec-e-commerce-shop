USE master;

DROP DATABASE IF EXISTS Livtec;

CREATE DATABASE Livtec;

GO

USE Livtec;



CREATE TABLE TiposUtilizadores
(
	Id TINYINT PRIMARY KEY IDENTITY,
	Designacao VARCHAR(50) UNIQUE NOT NULL 
);

INSERT INTO TiposUtilizadores VALUES ('Normal'), ('Admin');


CREATE TABLE Utilizadores
(
	Id INT PRIMARY KEY IDENTITY,
	Email VARCHAR(50) UNIQUE NOT NULL,
	Password VARCHAR(MAX) NOT NULL,
	EstaAtivo BIT DEFAULT 0 NULL,
	DataCriacao DATE DEFAULT GETDATE() NULL,
	DataUltimoLogin DATE NULL,
	CookieAutenticacao UNIQUEIDENTIFIER NULL,
	IdTipoUtilizador TINYINT REFERENCES TiposUtilizadores(Id)
);

CREATE TABLE Moradas
(
	Id INT PRIMARY KEY IDENTITY,
	Rua VARCHAR(100) NOT NULL,
	CodigoPostal CHAR(8) NOT NULL,
	Cidade VARCHAR(50) NOT NULL,
	Fracao VARCHAR(10) NULL,
	OutrosDetalhes VARCHAR(100) NULL,
	IdUtilizador INT REFERENCES Utilizadores(Id) ON DELETE CASCADE NOT NULL
);


CREATE TABLE TiposLivros
(
	Id TINYINT PRIMARY KEY IDENTITY,
	Designacao VARCHAR(50) UNIQUE NOT NULL
);

INSERT INTO TiposLivros VALUES ('Físico'), ('Digital');

CREATE TABLE Editoras
(
	Id INT PRIMARY KEY IDENTITY,
	Nome VARCHAR(50) UNIQUE NOT NULL,
	-- adicionar contactos?	
);

CREATE TABLE Livros
(
	Id INT PRIMARY KEY IDENTITY,
	Titulo VARCHAR(100) NOT NULL,
	Preco DECIMAL(5, 2) CHECK(Preco > 0) NOT NULL,
	NumeroPaginas INT CHECK(NumeroPaginas > 0) NOT NULL,
	Sinopse VARCHAR(MAX) NULL,
	ISBN VARCHAR(13) UNIQUE NOT NULL,
	Idioma VARCHAR(50) NOT NULL,
	AnoEdicao INT NOT NULL,
	IdTipoLivro TINYINT REFERENCES TiposLivros(Id) NOT NULL,
	IdEditora INT REFERENCES Editoras(Id) ON DELETE CASCADE NOT NULL,
	ImagemCapa VARBINARY(MAX) NULL,
	DataCriacao DATETIME DEFAULT GETDATE() NULL
);

CREATE TABLE Temas
(
	Id INT PRIMARY KEY IDENTITY,
	Designacao VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE TemasLivros
(
	Id INT PRIMARY KEY IDENTITY,
	IdLivro INT REFERENCES Livros(Id) ON DELETE CASCADE NOT NULL,
	IdTema INT REFERENCES Temas(Id) ON DELETE CASCADE NOT NULL
);

CREATE TABLE Autores
(
	Id INT PRIMARY KEY IDENTITY,
	Nome VARCHAR(50) NOT NULL,
	Biografia VARCHAR(MAX) NULL,
	Imagem VARBINARY(MAX) NULL
);


CREATE TABLE EstadosEncomendas
(
	Id TINYINT PRIMARY KEY IDENTITY,
	Designacao VARCHAR(50) UNIQUE NOT NULL
);


INSERT INTO EstadosEncomendas VALUES ('Por finalizar'), ('Enviada mas pendente de confirmação'), ('Entregue');

CREATE TABLE LivrosAutores
(
	Id INT PRIMARY KEY IDENTITY,
	IdLivro INT REFERENCES Livros(Id) ON DELETE CASCADE NOT NULL,
	IdAutor INT REFERENCES Autores(Id) ON DELETE CASCADE NOT NULL
);

CREATE TABLE TiposClientes
(
	Id TINYINT PRIMARY KEY IDENTITY,
	Designacao VARCHAR(50) UNIQUE NOT NULL
);

INSERT INTO TiposClientes VALUES ('Normal'), ('Revenda');

CREATE TABLE Clientes
(
	Id INT PRIMARY KEY IDENTITY,
	PrimeiroNome VARCHAR(30) NULL,
	Apelido VARCHAR(30) NULL,
	NIF CHAR(9) CHECK(LEN(NIF) = 9) NULL,
	ContactoTelefonico CHAR(9) CHECK(LEN(ContactoTelefonico) = 9) NULL,
	IdTipoCliente TINYINT REFERENCES TiposClientes(Id) DEFAULT 1 NOT NULL,
	IdUtilizador INT REFERENCES Utilizadores(Id) ON DELETE CASCADE UNIQUE NOT NULL
);


CREATE TABLE Carrinhos
(
	Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
	IdCliente INT REFERENCES Clientes(Id) ON DELETE CASCADE UNIQUE NOT NULL,
	DataCriacao DATE DEFAULT GETDATE() NULL
);

CREATE TABLE LivrosCarrinhos
(
	Id INT PRIMARY KEY IDENTITY,
	IdCarrinho UNIQUEIDENTIFIER REFERENCES Carrinhos(Id) ON DELETE CASCADE NOT NULL,
	IdLivro INT REFERENCES Livros(Id) ON DELETE CASCADE NOT NULL,
	Quantidade TINYINT CHECK(Quantidade > 0) DEFAULT 1 NULL
);


CREATE TABLE Opinioes
(
	Id INT PRIMARY KEY IDENTITY,
	Opiniao VARCHAR(MAX) NOT NULL,
	IdUtilizador INT REFERENCES Utilizadores(Id) ON DELETE CASCADE NOT NULL,
	IdLivro INT REFERENCES Livros(Id) ON DELETE CASCADE NOT NULL,
	DataCriacao DATE DEFAULT GETDATE() NULL
);

CREATE TABLE Encomendas
(
	Id INT PRIMARY KEY IDENTITY,
	DataCriacao DATE DEFAULT GETDATE() NULL,
	IdEstadoEncomenda TINYINT REFERENCES EstadosEncomendas(Id) DEFAULT 1 NOT NULL,
	IdCliente INT REFERENCES Clientes(Id) ON DELETE CASCADE NOT NULL,
	IdMorada INT REFERENCES Moradas(Id) ON DELETE SET NULL NULL
);

CREATE TABLE LivrosEncomendas
(
	Id INT PRIMARY KEY IDENTITY,
	IdEncomenda INT REFERENCES Encomendas(Id) ON DELETE CASCADE NOT NULL,
	IdLivro INT REFERENCES Livros(Id) ON DELETE CASCADE NOT NULL,
	Quantidade TINYINT CHECK(Quantidade > 0) DEFAULT 1 NULL
);


CREATE OR ALTER PROCEDURE UspTodosLivros
AS 
	BEGIN 
		BEGIN TRY 

				SELECT l.Id, l.Titulo, l.Preco, l.NumeroPaginas,
				       l.Sinopse,
					   l.ISBN, l.Idioma, l.AnoEdicao,
					   l.ImagemCapa,
					   l.DataCriacao,
					   e.Nome AS NomeEditora,
					   tl.Designacao AS TipoLivro,
					   e.Id AS IdEditora
				FROM Livros AS l INNER JOIN Editoras AS e ON l.IdEditora = e.Id
				INNER JOIN TiposLivros AS tl ON l.IdTipoLivro = tl.Id
				ORDER BY 
					DataCriacao DESC

		
		END TRY
		BEGIN CATCH
			THROW;
		END CATCH
	
	END 

CREATE OR ALTER PROCEDURE UspLivrosPaginacao
	@pagina INT = 1,
	@numeroLivros INT = 10
AS 
	BEGIN 
		BEGIN TRY 

				SELECT l.Id, l.Titulo, l.Preco, l.NumeroPaginas,
				       l.Sinopse,
					   l.ISBN, l.Idioma, l.AnoEdicao,
					   l.ImagemCapa,
					   l.DataCriacao,
					   e.Nome AS NomeEditora,
					   tl.Designacao AS TipoLivro,
					   e.Id AS IdEditora
				FROM Livros AS l INNER JOIN Editoras AS e ON l.IdEditora = e.Id
				INNER JOIN TiposLivros AS tl ON l.IdTipoLivro = tl.Id
				ORDER BY 
					DataCriacao DESC
				OFFSET (@pagina - 1) * @numeroLivros ROWS
				FETCH NEXT @numeroLivros ROWS ONLY
		
		END TRY
		BEGIN CATCH
			THROW;
		END CATCH
	
	END 


CREATE OR ALTER PROCEDURE UspInserirUtilizador
	@email VARCHAR(50),
	@passwordHash VARCHAR(MAX),
	@idTipoCliente TINYINT = NULL
AS 
	BEGIN 
		BEGIN TRY 
				BEGIN TRANSACTION

					IF EXISTS(SELECT 1 FROM Utilizadores WHERE Email = @email)
							THROW 50000, 'Já existe uma conta com o email indicado!', 0

					INSERT INTO Utilizadores (Email, Password, IdTipoUtilizador) 
							VALUES (TRIM(LOWER(@email)), @passwordHash, 1);
					
					INSERT INTO Clientes (IdTipoCliente, IdUtilizador) VALUES (ISNULL(@idTipoCliente, 1), SCOPE_IDENTITY());

				COMMIT TRANSACTION;
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION;
			THROW;
		END CATCH
	END 

CREATE OR ALTER PROCEDURE UspUtilizadorPorId
	@id INT 
AS 
	BEGIN 
		BEGIN TRY 

				SELECT 
					   u.Id, 
					   u.Email,
					   u.Password,
					   u.EstaAtivo,
					   u.DataCriacao,
					   tu.Designacao AS TipoUtilizador
				FROM 
					   Utilizadores AS u
				INNER JOIN 
						TiposUtilizadores AS tu
				ON 
						u.IdTipoUtilizador = tu.Id;

		END TRY 
		BEGIN CATCH 
			THROW;
		END CATCH 
	END



CREATE OR ALTER PROCEDURE UspAutenticarUtilizador
	@email VARCHAR(50)
AS
	BEGIN 
		BEGIN TRY

			SET @email = TRIM(LOWER(@email));

			IF NOT EXISTS(SELECT 1 FROM Utilizadores WHERE Email = @email)
					THROW 50000, 'Email ou password incorreta.', 0

			IF EXISTS (SELECT 1 FROM Utilizadores WHERE Email = @email AND EstaAtivo = 0)
					THROW 50000, 'Terá que ativar a sua conta para se autenticar. Verifique o seu e-mail!', 0

			SELECT 
					   u.Id, 
					   u.Email,
					   u.Password,
					   u.EstaAtivo,
					   u.DataCriacao,
					   u.DataUltimoLogin,
					   u.CookieAutenticacao,
					   tu.Designacao AS TipoUtilizador
				FROM 
					   Utilizadores AS u
				INNER JOIN 
						TiposUtilizadores AS tu
				ON 
						u.IdTipoUtilizador = tu.Id
				WHERE u.Email = @email;

		END TRY
		BEGIN CATCH
			THROW;
		END CATCH 
	END





		CREATE OR ALTER PROCEDURE UspAtivarContaUtilizador
	@email VARCHAR(50)
AS
	BEGIN 
		BEGIN TRY
			
			SET @email = LOWER(TRIM(@email));

			IF NOT EXISTS(SELECT 1 FROM Utilizadores WHERE Email = @email)
				THROW 50000, 'Não existe nenhuma conta para ser ativada com o email indicado!', 0;

			IF EXISTS(SELECT 1 FROM Utilizadores WHERE Email = @email AND EstaAtivo = 1)
				THROW 50000, 'A conta com o email indicado já se encontra ativa!', 0;


			UPDATE Utilizadores SET EstaAtivo = 1 WHERE Email = @email;

		END TRY
		BEGIN CATCH
			THROW;
		END CATCH 
	END





	CREATE OR ALTER PROCEDURE UspUtilizadorPorCookieAutenticacaoGuid
	 @cookieAutenticacao UNIQUEIDENTIFIER
AS 
	BEGIN 
		BEGIN TRY 



					--IF NOT EXISTS(SELECT 1 FROM Utilizadores WHERE CookieAutenticacao = @cookieAutenticacao)
			--	THROW 50000, 'User não está logado', 0;


				SELECT 
					   u.Id, 
					   u.Email,
					   u.Password,
					   u.EstaAtivo,
					   u.DataCriacao,
					   u.CookieAutenticacao,
					   tu.Designacao AS TipoUtilizador
				FROM 
					   Utilizadores AS u
				INNER JOIN 
						TiposUtilizadores AS tu
				ON 
						u.IdTipoUtilizador = tu.Id
				WHERE CookieAutenticacao = @cookieAutenticacao;

		END TRY 
		BEGIN CATCH 
			THROW;
		END CATCH 
	END




	CREATE OR ALTER PROCEDURE UspInserirEditora	
	@nome VARCHAR(50)
AS
	BEGIN 
		
		BEGIN TRY

			SET @nome = TRIM(@nome);

			IF EXISTS(SELECT 1 FROM Editoras WHERE Nome = @nome)
				THROW 50000, 'A editora com o nome indicado já se encontrada inserida na base de dados!', 0;


			INSERT INTO Editoras VALUES (@nome);
	
		
		END TRY
		BEGIN CATCH
			THROW;
		END CATCH
	END


	CREATE OR ALTER PROCEDURE UspTodasEditoras

AS
	BEGIN 
		
		BEGIN TRY

			SELECT * FROM Editoras ORDER BY Nome ASC
	
		
		END TRY
		BEGIN CATCH
			THROW;
		END CATCH
	END


		CREATE OR ALTER PROCEDURE UspEliminarEditoraPorId
			@id INT
AS
	BEGIN 
		
		BEGIN TRY

			IF NOT EXISTS(SELECT 1 FROM Editoras Where Id = @id)
				THROW 50000, 'Não foi possível eliminar a editora com o id especificado porque não existe!', 0;


			SELECT * FROM Editoras WHERE Id = @id;

			DELETE FROM Editoras WHERE Id = @id;
	
		
		END TRY
		BEGIN CATCH
			THROW;
		END CATCH
	END

	


CREATE OR ALTER PROCEDURE UspInserirUtilizador
	@email VARCHAR(50),
	@passwordHash VARCHAR(MAX)
AS 
	BEGIN 
		BEGIN TRY 

			BEGIN TRANSACTION

					IF EXISTS(SELECT 1 FROM Utilizadores WHERE Email = @email)
							THROW 50000, 'Já existe uma conta com o email indicado!', 0

					INSERT INTO Utilizadores (Email, Password, IdTipoUtilizador) 
							VALUES (TRIM(LOWER(@email)), @passwordHash, 1);
					

					INSERT INTO Clientes(IdTipoCliente, idUtilizador) VALUES (1, SCOPE_IDENTITY());


			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
			THROW;
		END CATCH
	
	END 

CREATE OR ALTER PROCEDURE UspUtilizadorPorId
	@id INT 
AS 
	BEGIN 
		BEGIN TRY 

				SELECT 
					   u.Id, 
					   u.Email,
					   u.Password,
					   u.EstaAtivo,
					   u.DataCriacao,
					   tu.Designacao AS TipoUtilizador
				FROM 
					   Utilizadores AS u
				INNER JOIN 
						TiposUtilizadores AS tu
				ON 
						u.IdTipoUtilizador = tu.Id;

		END TRY 
		BEGIN CATCH 
			THROW;
		END CATCH 
	END



CREATE OR ALTER PROCEDURE UspAutenticarUtilizador
	@email VARCHAR(50)
AS
	BEGIN 
		BEGIN TRY

			SET @email = TRIM(LOWER(@email));

			IF NOT EXISTS(SELECT 1 FROM Utilizadores WHERE Email = @email)
					THROW 50000, 'Email ou password incorreta.', 0

			IF EXISTS (SELECT 1 FROM Utilizadores WHERE Email = @email AND EstaAtivo = 0)
					THROW 50000, 'Terá que ativar a sua conta para se autenticar. Verifique o seu e-mail!', 0

			SELECT 
					   u.Id, 
					   u.Email,
					   u.Password,
					   u.EstaAtivo,
					   u.DataCriacao,
					   u.DataUltimoLogin,
					   u.CookieAutenticacao,
					   tu.Designacao AS TipoUtilizador
				FROM 
					   Utilizadores AS u
				INNER JOIN 
						TiposUtilizadores AS tu
				ON 
						u.IdTipoUtilizador = tu.Id
				WHERE u.Email = @email;

		END TRY
		BEGIN CATCH
			THROW;
		END CATCH 
	END


	CREATE OR ALTER PROCEDURE UspAtualizarCookieAutenticacao
	@cookieGuid UNIQUEIDENTIFIER,
	@email VARCHAR(50)
AS
	BEGIN 
		BEGIN TRY
			SET @email = TRIM(LOWER(@email));

			UPDATE Utilizadores SET CookieAutenticacao = @cookieGuid, DataUltimoLogin = GETDATE() WHERE Email = @email

		END TRY
		BEGIN CATCH
			THROW;
		END CATCH 
	END


		CREATE OR ALTER PROCEDURE UspAtivarContaUtilizador
	@email VARCHAR(50)
AS
	BEGIN 
		BEGIN TRY
			
			SET @email = LOWER(TRIM(@email));

			IF NOT EXISTS(SELECT 1 FROM Utilizadores WHERE Email = @email)
				THROW 50000, 'Não existe nenhuma conta para ser ativada com o email indicado!', 0;

			IF EXISTS(SELECT 1 FROM Utilizadores WHERE Email = @email AND EstaAtivo = 1)
				THROW 50000, 'A conta com o email indicado já se encontra ativa!', 0;


			UPDATE Utilizadores SET EstaAtivo = 1 WHERE Email = @email;

		END TRY
		BEGIN CATCH
			THROW;
		END CATCH 
	END





	CREATE OR ALTER PROCEDURE UspUtilizadorPorCookieAutenticacaoGuid
	 @cookieAutenticacao UNIQUEIDENTIFIER
AS 
	BEGIN 
		BEGIN TRY 


			--IF NOT EXISTS(SELECT 1 FROM Utilizadores WHERE CookieAutenticacao = @cookieAutenticacao)
			--	THROW 50000, 'User não está logado', 0;



				SELECT 
					   u.Id, 
					   u.Email,
					   u.Password,
					   u.EstaAtivo,
					   u.DataCriacao,
					   u.CookieAutenticacao,
					   tu.Designacao AS TipoUtilizador
				FROM 
					   Utilizadores AS u
				INNER JOIN 
						TiposUtilizadores AS tu
				ON 
						u.IdTipoUtilizador = tu.Id
				WHERE CookieAutenticacao = @cookieAutenticacao;

		END TRY 
		BEGIN CATCH 
			THROW;
		END CATCH 
	END



CREATE OR ALTER PROCEDURE UspInserirEditora	
	@nome VARCHAR(50)
AS
	BEGIN 
		
		BEGIN TRY

			SET @nome = TRIM(@nome);

			IF EXISTS(SELECT 1 FROM Editoras WHERE Nome = @nome)
				THROW 50000, 'A editora com o nome indicado já se encontrada inserida na base de dados!', 0;


			INSERT INTO Editoras VALUES (@nome);
	
		
		END TRY
		BEGIN CATCH
			THROW;
		END CATCH
	END





CREATE OR ALTER PROCEDURE UspInserirLivro
		@titulo VARCHAR(100),
		@preco DECIMAL(5,2),
		@numeroPaginas INT,
		@sinopse VARCHAR(MAX) = NULL,
		@ISBN VARCHAR(13),
		@idioma VARCHAR(50),
		@anoEdicao INT,
		@idTipoLivro TINYINT,
		@idEditora INT,
		@imagemCapa VARBINARY(MAX) = NULL,
		@dataCriacao DATETIME = NULL
AS
	BEGIN
		BEGIN TRY
			
			SET @ISBN = TRIM(@ISBN);

			IF EXISTS(SELECT 1 FROM Livros WHERE ISBN = @ISBN)
				THROW 50000, 'Já existe um livro com o ISBN indicado.', 0;
			


			INSERT INTO Livros VALUES (TRIM(@titulo), @preco, @numeroPaginas, TRIM(@sinopse),
								       @ISBN, TRIM(@idioma), @anoEdicao, @idTipoLivro, 
									   @idEditora, @imagemCapa, ISNULL(@dataCriacao, GETDATE()));

			SELECT SCOPE_IDENTITY() AS 'IdLivroInserido';
			
		END TRY
		BEGIN CATCH
			THROW;
		END CATCH
	
	END



CREATE OR ALTER PROCEDURE UspNumeroTotalLivrosCarrinhoValorTotal
	@idUtilizador INT
	AS
BEGIN
	BEGIN TRY

		SELECT SUM(LivrosCarrinhos.Quantidade) AS QuantidadeProdutos, SUM(Livros.Preco * LivrosCarrinhos.Quantidade) AS ValorTotalCarrinho FROM LivrosCarrinhos 
				INNER JOIN Livros ON Livros.Id = LivrosCarrinhos.IdLivro
				INNER JOIN Carrinhos ON Carrinhos.Id = LivrosCarrinhos.IdCarrinho
				WHERE Carrinhos.IdCliente = @idUtilizador;

	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END

CREATE OR ALTER PROCEDURE UspAdicionaLivroAoCarrinho
	@idUtilizador INT,
	@idLivro INT
AS
	BEGIN
		BEGIN TRY
				BEGIN TRANSACTION

					DECLARE @guidGerado UNIQUEIDENTIFIER = NULL;

					SET @idUtilizador = (SELECT Id FROM Clientes WHERE IdUtilizador = @idUtilizador);

				
					IF NOT EXISTS(SELECT 1 FROM Carrinhos WHERE IdCliente = @idUtilizador) 
						BEGIN
							SET @guidGerado = NEWID();
							INSERT INTO Carrinhos VALUES (@guidGerado, @idUtilizador, default);
						END
						 

					IF(@guidGerado IS NOT NULL)
							INSERT INTO LivrosCarrinhos VALUES (@guidGerado, @idLivro, default); 	
					ELSE
						BEGIN
							DECLARE @idCarrinho UNIQUEIDENTIFIER = (SELECT Id FROM Carrinhos WHERE IdCliente = @idUtilizador);
							IF EXISTS(SELECT 1 FROM LivrosCarrinhos WHERE IdLivro = @idLivro AND IdCarrinho = @idCarrinho)
									UPDATE LivrosCarrinhos SET Quantidade = Quantidade + 1 WHERE IdCarrinho = @idCarrinho AND IdLivro = @idLivro;
							ELSE
									INSERT INTO LivrosCarrinhos VALUES (@idCarrinho, @idLivro, default);
						END
	

				EXECUTE UspNumeroTotalLivrosCarrinhoValorTotal @idUtilizador
			
				COMMIT TRANSACTION;
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION;
			THROW; 
		END CATCH
	END

CREATE OR ALTER PROCEDURE UspAtualizarEditora
	@id INT,
	@nome VARCHAR(50)
AS
	BEGIN
		BEGIN TRY
			IF NOT EXISTS(SELECT 1 FROM Editoras WHERE Id = @id)
				THROW 50000, 'Não foi possível eliminar a editora selecionada porque a mesma não se encontra inserida na base de dados', 0;

				UPDATE Editoras SET Nome = @nome WHERE Id = @id;

		END TRY
		BEGIN CATCH
			THROW;
		END CATCH
	END


CREATE OR ALTER PROCEDURE UspLivrosCarrinho
	@idUtilizador INT
AS
	BEGIN
		BEGIN TRY

				SET @idUtilizador = (SELECT Id FROM Clientes WHERE IdUtilizador = @idUtilizador);
			
				SELECT Livros.Titulo AS TituloLivro, Livros.Preco AS PrecoLivro, Editoras.Nome AS NomeEditora, Livros.ImagemCapa, 
				TiposLivros.Designacao AS TipoLivro, 
				LivrosCarrinhos.Quantidade,
				SUM(LivrosCarrinhos.Quantidade * Livros.Preco) AS Total FROM LivrosCarrinhos 
				INNER JOIN Livros ON Livros.Id = LivrosCarrinhos.IdLivro
				INNER JOIN Carrinhos ON Carrinhos.Id = LivrosCarrinhos.IdCarrinho
				INNER JOIN Editoras ON Editoras.Id = Livros.IdEditora
				INNER JOIN TiposLivros ON TiposLivros.Id = Livros.IdTipoLivro
				WHERE Carrinhos.IdCliente = @idUtilizador
				GROUP BY Livros.Titulo, Livros.Preco, Editoras.Nome, Livros.ImagemCapa, TiposLivros.Designacao, LivrosCarrinhos.Quantidade
				

		END TRY
		BEGIN CATCH
			THROW;
		END CATCH
	END


CREATE OR ALTER PROCEDURE UspProcurarLivroPorISBN
	@isbn VARCHAR(13)
AS 
	BEGIN
		BEGIN TRY
			
			SET @isbn = TRIM(@isbn);

			SELECT l.Id, l.Titulo, l.Preco, l.NumeroPaginas,
				       l.Sinopse,
					   l.ISBN, l.Idioma, l.AnoEdicao,
					   l.ImagemCapa,
					   l.DataCriacao,
					   e.Nome AS NomeEditora,
					   tl.Designacao AS TipoLivro,
					    e.Id AS IdEditora
				FROM Livros AS l INNER JOIN Editoras AS e ON l.IdEditora = e.Id
				INNER JOIN TiposLivros AS tl ON l.IdTipoLivro = tl.Id
				WHERE l.ISBN = @isbn;

		END TRY
		BEGIN CATCH
			THROW;
		END CATCH

	END





CREATE OR ALTER PROCEDURE UspTodosAutores
AS
	BEGIN
		BEGIN TRY
			
			SELECT * FROM Autores ORDER BY Nome ASC;
				
		END TRY
		BEGIN CATCH
			THROW;
		END CATCH
	END





CREATE OR ALTER PROCEDURE UspInserirAutor
		@nome VARCHAR(50),
		@biografia VARCHAR(MAX) NULL,
		@imagem VARBINARY(MAX) = NULL
AS
	BEGIN
		BEGIN TRY


			INSERT INTO Autores VALUES (TRIM(@nome), TRIM(@biografia), @imagem);

				
		END TRY
		BEGIN CATCH
			THROW;
		END CATCH
	
	END


	
		CREATE OR ALTER PROCEDURE UspEliminarAutorPorId
			@id INT
AS
	BEGIN 
		
		BEGIN TRY

			IF NOT EXISTS(SELECT 1 FROM Autores Where Id = @id)
				THROW 50000, 'Não foi possível eliminar o/a autor/a com o id especificado porque não existe!', 0;


			SELECT * FROM Autores WHERE Id = @id;

			DELETE FROM Autores WHERE Id = @id;
	
		
		END TRY
		BEGIN CATCH
			THROW;
		END CATCH
	END


CREATE OR ALTER PROCEDURE UspProcurarLivroPorTituloOuISBN
	@valorPesquisa VARCHAR(50)
AS 
	BEGIN
		BEGIN TRY
			
			SET @valorPesquisa = TRIM(@valorPesquisa);

			SELECT l.Id, l.Titulo, l.Preco, l.NumeroPaginas,
				       l.Sinopse,
					   l.ISBN, l.Idioma, l.AnoEdicao,
					   l.ImagemCapa,
					   l.DataCriacao,
					   e.Nome AS NomeEditora,
					   tl.Designacao AS TipoLivro,
					   		 e.Id AS IdEditora  
				FROM Livros AS l INNER JOIN Editoras AS e ON l.IdEditora = e.Id
				INNER JOIN TiposLivros AS tl ON l.IdTipoLivro = tl.Id
				WHERE l.ISBN LIKE CONCAT('%', @valorPesquisa ,'%') 
				OR l.Titulo LIKE CONCAT('%', @valorPesquisa ,'%') 

		END TRY
		BEGIN CATCH
			THROW;
		END CATCH

	END


CREATE OR ALTER PROCEDURE UspTodosUtilizadores
AS
	BEGIN
		BEGIN TRY
			

					SELECT 
					   u.Id, 
					   u.Email,
					   u.Password,
					   u.EstaAtivo,
					   u.DataCriacao,
					   u.DataUltimoLogin,
					   tu.Designacao AS TipoUtilizador
				FROM 
					   Utilizadores AS u
				INNER JOIN 
						TiposUtilizadores AS tu
				ON 
						u.IdTipoUtilizador = tu.Id


		END TRY
		BEGIN CATCH
			THROW; 
		END CATCH


	END


CREATE OR ALTER PROCEDURE FuncoesAgregadoresLivros
AS
	BEGIN 
		BEGIN TRY
			
			SELECT COUNT(Livros.Id)
			FROM Livros

		END TRY
		BEGIN CATCH
			THROW;
		END CATCH
	END





		CREATE OR ALTER PROCEDURE UspEliminarUtilizadorPorId
			@id INT
AS
	BEGIN 
		
		BEGIN TRY

			IF NOT EXISTS(SELECT 1 FROM Utilizadores Where Id = @id)
				THROW 50000, 'Não foi possível eliminar o utilizador com o id especificado porque não existe!', 0;


			SELECT 
					   u.Id, 
					   u.Email,
					   u.Password,
					   u.EstaAtivo,
					   u.DataCriacao,
					   u.DataUltimoLogin,
					   tu.Designacao AS TipoUtilizador
				FROM 
					   Utilizadores AS u
				INNER JOIN 
						TiposUtilizadores AS tu
				ON 
						u.IdTipoUtilizador = tu.Id
				WHERE u.Id = @id;

			DELETE FROM Utilizadores WHERE Id = @id;
	
		
		END TRY
		BEGIN CATCH
			THROW;
		END CATCH
	END

	

CREATE OR ALTER PROCEDURE UspCheckOut
	@idUtilizador INT,
	@dataCriacao DATE = NULL
AS
	BEGIN 
		BEGIN TRY
			BEGIN TRANSACTION

				SET @idUtilizador = (SELECT Id FROM Clientes WHERE IdUtilizador = @idUtilizador);

				DECLARE @idCarrinho UNIQUEIDENTIFIER = (SELECT Id FROM Carrinhos WHERE IdCliente = @idUtilizador);


				IF((SELECT COUNT(LivrosCarrinhos.Id) FROM LivrosCarrinhos 
				INNER JOIN Carrinhos ON Carrinhos.Id = LivrosCarrinhos.IdCarrinho
				WHERE Carrinhos.IdCliente = @idUtilizador) <= 0)
					THROW 50000, 'Não poderá realizar o check out com o carrinho vazio!', 0;



				INSERT INTO Encomendas VALUES (default, default, @idUtilizador);

				INSERT INTO LivrosEncomendas
							SELECT SCOPE_IDENTITY(), IdLivro, Quantidade 
								FROM LivrosCarrinhos WHERE IdCarrinho = @idCarrinho;


				DELETE FROM Carrinhos WHERE Id = @idCarrinho;


			COMMIT TRANSACTION;

		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION;
			THROW;
		END CATCH
	END


CREATE OR ALTER PROCEDURE UspAssociarAutorAoLivro
	@idLivro INT,
	@idAutor INT
AS	
	BEGIN
		BEGIN TRY

			IF NOT EXISTS(SELECT 1 FROM Livros WHERE Id = @idLivro)	
					THROW 50000, 'Não foi possível associar este livro ao autor indicado porque o id providenciado não é válido!', 0;
			
			IF NOT EXISTS(SELECT 1 FROM Livros WHERE Id = @idLivro)	
				   THROW 50000, 'Não foi possível associar este autor ao livro indicado porque o id providenciado não é válido!', 0;

			INSERT INTO LivrosAutores VALUES (@idLivro, @idAutor);
			


		END TRY	
		BEGIN CATCH
			THROW;
		END CATCH


	END



	
CREATE OR ALTER PROCEDURE UspInserirOpiniao
		@opiniao VARCHAR(MAX),
		@idUtilizador INT,
		@idLivro INT,
		@dataCriacao DATE = NULL 
AS
	BEGIN
		BEGIN TRY


			INSERT INTO Opinioes VALUES (TRIM(@opiniao), @idUtilizador, @idLivro, ISNULL(@dataCriacao, GETDATE()));

				
		END TRY
		BEGIN CATCH
			THROW;
		END CATCH
	
	END



CREATE OR ALTER PROCEDURE UspOpinioesDeUmDeterminadoLivro 
	@idLivro INT 
AS	
	BEGIN
		BEGIN TRY

			IF NOT EXISTS(SELECT 1 FROM Livros WHERE Id = @idLivro)
					THROW 50000, 'O livro com o id especificado não existe.', 0;



			SELECT o.Opiniao,
				   o.DataCriacao,
				   u.Email
			FROM Opinioes AS o 
			INNER JOIN Utilizadores AS u ON u.Id = o.IdUtilizador
			WHERE o.IdLivro = @idLivro
			ORDER BY o.DataCriacao DESC;

		END TRY
		BEGIN CATCH
			THROW;
		END CATCH

	END

CREATE OR ALTER PROCEDURE UspTodasMoradas
AS
	BEGIN 

		BEGIN TRY

			SELECT Id, Rua, CodigoPostal, Cidade, Fracao, OutrosDetalhes
				FROM Moradas;

		END TRY
		BEGIN CATCH
			THROW;
		END CATCH
	END