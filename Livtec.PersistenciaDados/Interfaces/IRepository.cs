using System.Collections.Generic;

namespace Livtec.PersistenciaDados.Interfaces
{
    internal interface IRepository<TChave, TEntidade> where TEntidade : class
    {
        TEntidade EncontrarPorId(TChave Id);
        IEnumerable<TEntidade> Paginacao(int numeroPagina, int numeroItems);

        TEntidade Inserir(TEntidade entidade);
        TEntidade EliminarPorId(TChave Id);
        TEntidade Atualizar(TEntidade entidade);
        IEnumerable<TEntidade> SemPaginacao();
    }
}
