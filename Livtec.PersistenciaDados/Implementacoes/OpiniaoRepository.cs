using Livtec.Entidades;
using Livtec.PersistenciaDados.Interfaces;
using System;
using System.Collections.Generic;
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

        public Opiniao EncontrarPorId(int Id)
        {
            throw new NotImplementedException();
        }

        public Opiniao Inserir(Opiniao entidade)
        {
            throw new NotImplementedException();
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
