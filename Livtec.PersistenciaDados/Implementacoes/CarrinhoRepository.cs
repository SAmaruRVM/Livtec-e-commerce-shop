using Livtec.Entidades;
using Livtec.PersistenciaDados.Extensions;
using Livtec.PersistenciaDados.Interfaces;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace Livtec.PersistenciaDados.Implementacoes
{
    public class CarrinhoRepository : IRepository<Guid, Carrinho>
    {
        public Carrinho Atualizar(Carrinho entidade)
        {
            throw new NotImplementedException();
        }

        public Carrinho EliminarPorId(Guid Id)
        {
            throw new NotImplementedException();
        }

        public Carrinho EncontrarPorId(Guid Id)
        {
            throw new NotImplementedException();
        }

        public Carrinho Inserir(Carrinho entidade)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Carrinho> Paginacao(int numeroPagina, int numeroItems)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Carrinho> SemPaginacao()
        {
            throw new NotImplementedException();
        }


        public (int quantidadeProdutos, decimal valorTotalCarrinho) TotalProdutosValorTotal(int idUtilizador)
        {
            using (SqlDataReader sqlDataReader = new SqlCommand().ExecutarSpComRetorno(StoredProcedure.UspNumeroTotalLivrosCarrinhoValorTotal, new Dictionary<string, object>
            {
                ["@idUtilizador"] = idUtilizador
            }))
                if (sqlDataReader.Read() && !(sqlDataReader.IsDBNull(0)))
                {
                    return (quantidadeProdutos: int.Parse(sqlDataReader["QuantidadeProdutos"].ToString()), valorTotalCarrinho: decimal.Parse(sqlDataReader["ValorTotalCarrinho"].ToString()));
                }
            return (quantidadeProdutos: 0, valorTotalCarrinho: 0);
        }

        public (int quantidadeProdutos, decimal valorTotalCarrinho) AdicionarLivro(int idUtilizador, int idLivro)
        {
            using (SqlDataReader sqlDataReader = new SqlCommand().ExecutarSpComRetorno(StoredProcedure.UspAdicionaLivroAoCarrinho, new Dictionary<string, object>
            {
                ["@idUtilizador"] = idUtilizador,
                ["@idLivro"] = idLivro
            }))
            {
                if (sqlDataReader.Read())
                {
                    return (quantidadeProdutos: int.Parse(sqlDataReader["QuantidadeProdutos"].ToString()), valorTotalCarrinho: decimal.Parse(sqlDataReader["ValorTotalCarrinho"].ToString()));
                }
                return (quantidadeProdutos: 0, valorTotalCarrinho: 0);
            }
        }

        public IEnumerable<LivroCarrinho> VerLivrosPertencentesAUmCarrinho(int idUtilizador)
        {
            using (SqlDataReader sqlDataReader = new SqlCommand().ExecutarSpComRetorno(StoredProcedure.UspLivrosCarrinho, new Dictionary<string, object>
            {
                ["@idUtilizador"] = idUtilizador
            }))
            {
                while (sqlDataReader.Read())
                {
                    yield return new LivroCarrinho
                    {
                        Livro = new Livro
                        {
                            Titulo = sqlDataReader["TituloLivro"].ToString(),
                            Preco = decimal.Parse(sqlDataReader["PrecoLivro"].ToString()),
                            Editora = new Editora
                            {
                                Nome = sqlDataReader["NomeEditora"].ToString()
                            },
                            Imagem = sqlDataReader.IsDBNull(3) ? null : (byte[])sqlDataReader["ImagemCapa"],
                            TipoLivro = (TipoLivro)Enum.Parse(typeof(TipoLivro), sqlDataReader["TipoLivro"].ToString())
                        },
                        Quantidade = int.Parse(sqlDataReader["Quantidade"].ToString()),
                        Total = decimal.Parse(sqlDataReader["Total"].ToString())
                    };
                }
            }
        }


        public void CheckOut(int idUtilizador, DateTime? dataCriacao = null) 
        {
            new SqlCommand().ExecutarSPSemRetorno(StoredProcedure.UspCheckOut, new Dictionary<string, object>
            {
                ["@idUtilizador"] = idUtilizador,
                ["@dataCriacao"] = dataCriacao
            });
        }
    }
}
