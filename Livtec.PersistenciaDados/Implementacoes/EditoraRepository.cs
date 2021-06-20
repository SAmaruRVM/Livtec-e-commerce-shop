
using Livtec.Entidades;
using Livtec.PersistenciaDados.Extensions;
using Livtec.PersistenciaDados.Interfaces;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace Livtec.PersistenciaDados.Implementacoes
{
    public class EditoraRepository : IRepository<int, Editora>
    {
        public IEnumerable<Editora> TodasEditoras() 
        {
            using(SqlDataReader sqlDataReader = new SqlCommand().ExecutarSpComRetorno(StoredProcedure.UspTodasEditoras))
            {
                while(sqlDataReader.Read()) 
                {
                    yield return new Editora
                    {
                        Id = int.Parse(sqlDataReader["Id"].ToString()),
                        Nome = sqlDataReader["Nome"].ToString()
                    };
                }
            }
        }

        public Editora Atualizar(Editora entidade)
        {
            throw new System.NotImplementedException();
        }

        public Editora EliminarPorId(int id)
        {
            using (SqlDataReader sqlDataReader = new SqlCommand().ExecutarSpComRetorno(StoredProcedure.UspTodasEditoras, new Dictionary<string, object> 
            {
                ["@id"] = id
            }))
            {
                if(sqlDataReader.Read())
                {
                     return new Editora
                    {
                        Id = int.Parse(sqlDataReader["Id"].ToString()),
                        Nome = sqlDataReader["Nome"].ToString()
                    };
                }
            }
            return null;
        }

        public Editora EncontrarPorId(int Id)
        {
            throw new System.NotImplementedException();
        }

        public Editora Inserir(Editora entidade)
        {
            new SqlCommand().ExecutarSPSemRetorno(StoredProcedure.UspInserirEditora, new Dictionary<string, object>
            {
                ["@nome"] = entidade.Nome
            });

            return entidade;
        }

        public IEnumerable<Editora> Paginacao(int numeroPagina, int numeroItems)
        {
            throw new System.NotImplementedException();
        }
    }
}
