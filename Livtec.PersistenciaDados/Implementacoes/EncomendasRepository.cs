using Livtec.Entidades;
using Livtec.PersistenciaDados.Interfaces;
using System.Collections.Generic;
using System.Linq;

namespace Livtec.PersistenciaDados.Implementacoes
{
    class EncomendasRepository : IRepository<int, Encomenda>
    {
        public IEnumerable<Encomenda> EncomendasDeUmDeterminadoCliente(int idCliente)
        {
            return Enumerable.Empty<Encomenda>();
        }



        public Encomenda Atualizar(Encomenda entidade)
        {
            throw new System.NotImplementedException();
        }

        public Encomenda EliminarPorId(int Id)
        {
            throw new System.NotImplementedException();
        }

        public Encomenda EncontrarPorId(int Id)
        {
            throw new System.NotImplementedException();
        }

        public Encomenda Inserir(Encomenda entidade)
        {
            throw new System.NotImplementedException();
        }

        public IEnumerable<Encomenda> Paginacao(int numeroPagina, int numeroItems)
        {
            throw new System.NotImplementedException();
        }

        public IEnumerable<Encomenda> SemPaginacao()
        {
            throw new System.NotImplementedException();
        }
    }
}
