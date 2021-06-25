using Livtec.Entidades;
using Livtec.PersistenciaDados.Extensions;
using Livtec.PersistenciaDados.Interfaces;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace Livtec.PersistenciaDados.Implementacoes
{
    public class MoradaRepository : IRepository<int, Morada>
    {
        public Morada Atualizar(Morada entidade)
        {
            throw new NotImplementedException();
        }

        public Morada EliminarPorId(int Id)
        {
            throw new NotImplementedException();
        }

        public Morada EncontrarPorId(int Id)
        {
            throw new NotImplementedException();
        }

        public Morada Inserir(Morada entidade)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Morada> Paginacao(int numeroPagina, int numeroItems)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Morada> SemPaginacao()
        {
            using (SqlDataReader sqlDataReader = new SqlCommand().ExecutarSpComRetorno(StoredProcedure.UspTodasMoradas))
            {
                while (sqlDataReader.Read())
                {
                    yield return new Morada
                    {
                        Id = int.Parse(sqlDataReader["Id"].ToString()),
                        Rua = sqlDataReader["Rua"].ToString(),
                        CodigoPostal = sqlDataReader["CodigoPostal"].ToString(),
                        Cidade = sqlDataReader["Cidade"].ToString(),
                        Fracao = sqlDataReader["Fracao"].ToString(),
                        OutrosDetalhes = sqlDataReader["OutrosDetalhes"].ToString()
                    };
                }
            }
        }
    }

}