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

        public (int quantidadeProdutos, decimal valorTotalCarrinho) AdicionarLivro(int idCliente, int idLivro)
        {
            using (SqlDataReader sqlDataReader = new SqlCommand().ExecutarSpComRetorno(StoredProcedure.UspAdicionaLivroAoCarrinho, new Dictionary<string, object>
            {
                ["@idUtilizador"] = idCliente,
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
    }
}
