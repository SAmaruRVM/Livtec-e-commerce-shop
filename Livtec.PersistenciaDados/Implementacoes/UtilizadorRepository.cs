using Livtec.Entidades;
using Livtec.PersistenciaDados.Interfaces;
using Livtec.PersistenciaDados.Extensions;
using System.Collections.Generic;
using System.Data.SqlClient;
using System;

namespace Livtec.PersistenciaDados.Implementacoes
{
    public class UtilizadorRepository : IRepository<int, Utilizador>
    {
        public Utilizador Atualizar(Utilizador entidade)
        {
            throw new System.NotImplementedException();
        }

        public Utilizador EliminarPorId(int Id)
        {
            throw new System.NotImplementedException();
        }

        public Utilizador EncontrarPorId(int id)
        {
            using (SqlDataReader sqlDataReader = new SqlCommand().ExecutarSpComRetorno(StoredProcedure.UspUtilizadorPorId, new Dictionary<string, object>
            {
                ["@id"] = id
            }))
            {
                return new Utilizador
                {
                    Id = int.Parse(sqlDataReader["Id"].ToString()),
                    DataCriacao = DateTime.Parse(sqlDataReader["DataCriacao"].ToString()),
                    Email = sqlDataReader["Email"].ToString(),
                    EstaAtivo = bool.Parse(sqlDataReader["EstaAtivo"].ToString()),
                    Password = sqlDataReader["Password"].ToString(),
                    TipoUtilizador = (TipoUtilizador)Enum.Parse(typeof(TipoUtilizador), sqlDataReader["TipoUtilizador"].ToString())
                };
            }
        }

        public Utilizador Inserir(Utilizador entidade)
        {
            new SqlCommand().ExecutarSPSemRetorno(StoredProcedure.UspInserirUtilizador, new Dictionary<string, object>
            {
                ["@email"] = entidade.Email,
                ["@passwordHash"] = BCrypt.Net.BCrypt.HashPassword(entidade.Password)
            });

            entidade.DataCriacao = DateTime.Now;
            entidade.TipoUtilizador = TipoUtilizador.Normal;
            return entidade;
        }

        public IEnumerable<Utilizador> Paginacao(int numeroPagina, int numeroItems)
        {
            throw new System.NotImplementedException();
        }

        public IEnumerable<Utilizador> SemPaginacao()
        {
            throw new NotImplementedException();
        }
    }
}
