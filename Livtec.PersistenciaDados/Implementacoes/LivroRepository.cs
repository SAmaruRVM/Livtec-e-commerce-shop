using Livtec.Entidades;
using Livtec.PersistenciaDados.Extensions;
using Livtec.PersistenciaDados.Interfaces;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace Livtec.PersistenciaDados.Implementacoes
{
    public class LivroRepository : IRepository<int, Livro>
    {
        public Livro Atualizar(Livro entidade)
        {
            throw new NotImplementedException();
        }

        public Livro EliminarPorId(int Id)
        {
            throw new NotImplementedException();
        }

        public Livro EncontrarPorId(int Id)
        {
            throw new NotImplementedException();
        }

        public Livro EncontrarPorISBN(string isbn)
        {
            using (SqlDataReader sqlDataReader = new SqlCommand().ExecutarSpComRetorno(StoredProcedure.UspProcurarLivroPorISBN, new Dictionary<string, object>
            {
                ["@isbn"] = isbn
            }))
            {
                if (sqlDataReader.Read())
                {
                    return new Livro
                    {
                        Id = int.Parse(sqlDataReader["Id"].ToString()),
                        Titulo = sqlDataReader["Titulo"].ToString(),
                        Preco = decimal.Parse(sqlDataReader["Preco"].ToString()),
                        NumeroPaginas = int.Parse(sqlDataReader["NumeroPaginas"].ToString()),
                        Sinopse = sqlDataReader["Sinopse"].ToString(),
                        ISBN = sqlDataReader["ISBN"].ToString(),
                        Idioma = sqlDataReader["Idioma"].ToString(),
                        AnoEdicao = int.Parse(sqlDataReader["AnoEdicao"].ToString()),
                        Imagem = sqlDataReader.IsDBNull(8) ? null : (byte[])sqlDataReader["ImagemCapa"],
                        DataCriacao = DateTime.Parse(sqlDataReader["DataCriacao"].ToString()),
                        Editora = new Editora { Id = int.Parse(sqlDataReader["IdEditora"].ToString()), Nome = sqlDataReader["NomeEditora"].ToString() },
                        TipoLivro = (TipoLivro)Enum.Parse(typeof(TipoLivro), sqlDataReader["TipoLivro"].ToString())
                    };
                }
                return null;
            }
        }



        public IEnumerable<Livro> EncontrarPorTituloOuISBN(string valorPesquisa)
        {
            using (SqlDataReader sqlDataReader = new SqlCommand().ExecutarSpComRetorno(StoredProcedure.UspProcurarLivroPorTituloOuISBN, new Dictionary<string, object>
            {
                ["@valorPesquisa"] = valorPesquisa
            }))
            {
                if (sqlDataReader.Read())
                {
                    yield return new Livro
                    {
                        Id = int.Parse(sqlDataReader["Id"].ToString()),
                        Titulo = sqlDataReader["Titulo"].ToString(),
                        Preco = decimal.Parse(sqlDataReader["Preco"].ToString()),
                        NumeroPaginas = int.Parse(sqlDataReader["NumeroPaginas"].ToString()),
                        Sinopse = sqlDataReader["Sinopse"].ToString(),
                        ISBN = sqlDataReader["ISBN"].ToString(),
                        Idioma = sqlDataReader["Idioma"].ToString(),
                        AnoEdicao = int.Parse(sqlDataReader["AnoEdicao"].ToString()),
                        Imagem = sqlDataReader.IsDBNull(8) ? null : (byte[])sqlDataReader["ImagemCapa"],
                        DataCriacao = DateTime.Parse(sqlDataReader["DataCriacao"].ToString()),
                        Editora = new Editora { Id = int.Parse(sqlDataReader["IdEditora"].ToString()), Nome = sqlDataReader["NomeEditora"].ToString() },
                        TipoLivro = (TipoLivro)Enum.Parse(typeof(TipoLivro), sqlDataReader["TipoLivro"].ToString())
                    };
                }
            }
        }

        public void AssociarAutorAoLivro(int idAutor, int idLivro) =>
                                                                new SqlCommand().ExecutarSPSemRetorno(StoredProcedure.UspAssociarAutorAoLivro, 
                                                                    new Dictionary<string, object>
                                                                {
                                                                    ["@idLivro"] = idLivro,
                                                                    ["@idAutor"] = idAutor
                                                                });
    



        public Livro Inserir(Livro entidade)
        {
            using (SqlDataReader sqlDataReader = new SqlCommand().ExecutarSpComRetorno(StoredProcedure.UspInserirLivro, new Dictionary<string, object>
            {
                ["@titulo"] = entidade.Titulo,
                ["@preco"] = entidade.Preco,
                ["@numeroPaginas"] = entidade.NumeroPaginas,
                ["@sinopse"] = entidade.Sinopse,
                ["@ISBN"] = entidade.ISBN,
                ["@idioma"] = entidade.Idioma,
                ["@anoEdicao"] = entidade.AnoEdicao,
                ["@idTipoLivro"] = (int)entidade.TipoLivro,
                ["@idEditora"] = entidade.Editora.Id,
                ["@imagemCapa"] = entidade.Imagem,
                ["@dataCriacao"] = entidade.DataCriacao
            }))
            {
                if (sqlDataReader.Read())
                {
                    entidade.Id = int.Parse(sqlDataReader["IdLivroInserido"].ToString());
                }
            }
            return entidade;
        }

        public IEnumerable<Livro> Paginacao(int numeroPagina = 1, int numeroLivros = 10)
        {
            using (SqlDataReader sqlDataReader = new SqlCommand().ExecutarSpComRetorno(StoredProcedure.UspLivrosPaginacao, new Dictionary<string, object>
            {
                ["@pagina"] = numeroPagina,
                ["@numeroLivros"] = numeroLivros
            }))
            {
                while (sqlDataReader.Read())
                {
                    yield return new Livro
                    {
                        Id = int.Parse(sqlDataReader["Id"].ToString()),
                        Titulo = sqlDataReader["Titulo"].ToString(),
                        Preco = decimal.Parse(sqlDataReader["Preco"].ToString()),
                        NumeroPaginas = int.Parse(sqlDataReader["NumeroPaginas"].ToString()),
                        Sinopse = sqlDataReader["Sinopse"].ToString(),
                        ISBN = sqlDataReader["ISBN"].ToString(),
                        Idioma = sqlDataReader["Idioma"].ToString(),
                        AnoEdicao = int.Parse(sqlDataReader["AnoEdicao"].ToString()),
                        Imagem = sqlDataReader.IsDBNull(8) ? null : (byte[])sqlDataReader["ImagemCapa"],
                        DataCriacao = DateTime.Parse(sqlDataReader["DataCriacao"].ToString()),
                        Editora = new Editora { Id = int.Parse(sqlDataReader["IdEditora"].ToString()), Nome = sqlDataReader["NomeEditora"].ToString() },
                        TipoLivro = (TipoLivro)Enum.Parse(typeof(TipoLivro), sqlDataReader["TipoLivro"].ToString())
                    };
                }
            }
        }

        public IEnumerable<Livro> SemPaginacao()
        {
            using (SqlDataReader sqlDataReader = new SqlCommand().ExecutarSpComRetorno(StoredProcedure.UspTodosLivros))
            {
                while (sqlDataReader.Read())
                {
                    yield return new Livro
                    {
                        Id = int.Parse(sqlDataReader["Id"].ToString()),
                        Titulo = sqlDataReader["Titulo"].ToString(),
                        Preco = decimal.Parse(sqlDataReader["Preco"].ToString()),
                        NumeroPaginas = int.Parse(sqlDataReader["NumeroPaginas"].ToString()),
                        Sinopse = sqlDataReader["Sinopse"].ToString(),
                        ISBN = sqlDataReader["ISBN"].ToString(),
                        Idioma = sqlDataReader["Idioma"].ToString(),
                        AnoEdicao = int.Parse(sqlDataReader["AnoEdicao"].ToString()),
                        Imagem = sqlDataReader.IsDBNull(8) ? null : (byte[])sqlDataReader["ImagemCapa"],
                        DataCriacao = DateTime.Parse(sqlDataReader["DataCriacao"].ToString()),
                        Editora = new Editora { Id = int.Parse(sqlDataReader["IdEditora"].ToString()), Nome = sqlDataReader["NomeEditora"].ToString() },
                        TipoLivro = (TipoLivro)Enum.Parse(typeof(TipoLivro), sqlDataReader["TipoLivro"].ToString())
                    };
                }
            }
        }
    }

}