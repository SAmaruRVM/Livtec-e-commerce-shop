using Livtec.Entidades;
using Livtec.PersistenciaDados.Extensions;
using Livtec.PersistenciaDados.Interfaces;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace Livtec.PersistenciaDados.Implementacoes
{
    public class AutorRepository : IRepository<int, Autor>
    {
        public Autor Atualizar(Autor entidade)
        {
            throw new System.NotImplementedException();
        }

        public Autor EliminarPorId(int Id)
        {
            throw new System.NotImplementedException();
        }

        public Autor EncontrarPorId(int Id)
        {
            throw new System.NotImplementedException();
        }

        public Autor Inserir(Autor entidade)
        {
            new SqlCommand().ExecutarSPSemRetorno(StoredProcedure.UspInserirAutor, new Dictionary<string, object>
            {
                ["@nome"] = entidade.Nome,
                ["@biografia"] = entidade.Biografia,
                ["@imagem"] = entidade.Imagem
            });

            return entidade;
        }

        public IEnumerable<Autor> Paginacao(int numeroPagina, int numeroItems)
        {
            throw new System.NotImplementedException();
        }

        public IEnumerable<Autor> SemPaginacao()
        {
            using (SqlDataReader sqlDataReader = new SqlCommand().ExecutarSpComRetorno(StoredProcedure.UspTodosAutores))
            {
                while (sqlDataReader.Read())
                {
                    yield return new Autor
                    {
                        Id = int.Parse(sqlDataReader["Id"].ToString()),
                        Nome = sqlDataReader["Nome"].ToString(),
                        Biografia = sqlDataReader["Biografia"].ToString(),
                        Imagem = sqlDataReader.IsDBNull(3) ? null : (byte[])sqlDataReader["Imagem"],
                    };
                }
            }
        }
    }
}