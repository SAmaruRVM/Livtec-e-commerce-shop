using Livtec.Entidades;
using Livtec.PersistenciaDados.Extensions;
using Livtec.PersistenciaDados.Interfaces;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;

namespace Livtec.PersistenciaDados.Implementacoes
{
    public sealed class OpiniaoRepository : IRepository<int, Opiniao>
    {

        public IEnumerable<Opiniao> OpinioesDeUmDeterminadoLivro(int idLivro)
        {
            return Enumerable.Empty<Opiniao>();
        }


        public Opiniao Atualizar(Opiniao entidade)
        {
            throw new NotImplementedException();
        }

        public Opiniao EliminarPorId(int Id)
        {
            throw new NotImplementedException();
        }


        public IEnumerable<Opiniao> EncontrarPorIdLivro(int idLivro)
        {
            using (SqlDataReader sqlDataReader = new SqlCommand().ExecutarSpComRetorno(StoredProcedure.UspOpinioesDeUmDeterminadoLivro, new Dictionary<string, object>
            {
                ["@idLivro"] = idLivro
            }))
            {
                while (sqlDataReader.Read())
                {
                    yield return new Opiniao
                    {
                        OpiniaoTexto = sqlDataReader["Opiniao"].ToString(),
                        DataCriacao = DateTime.Parse(sqlDataReader["DataCriacao"].ToString()),
                        Utilizador = new Utilizador
                        {
                            Email = sqlDataReader["Email"].ToString()
                        }
                    };
                }

            }
        }

        public Opiniao EncontrarPorId(int Id)
        {
            throw new NotImplementedException();
        }

        public Opiniao Inserir(Opiniao entidade)
        {
            new SqlCommand().ExecutarSPSemRetorno(StoredProcedure.UspInserirOpiniao, new Dictionary<string, object>
            {
                ["@opiniao"] = entidade.OpiniaoTexto,
                ["@idUtilizador"] = entidade.Utilizador.Id,
                ["@idLivro"] = entidade.Livro.Id,
                ["@dataCriacao"] = entidade.DataCriacao
            });
            return entidade;
        }

        public IEnumerable<Opiniao> Paginacao(int numeroPagina, int numeroItems)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Opiniao> SemPaginacao()
        {
            throw new NotImplementedException();
        }
    }
}
