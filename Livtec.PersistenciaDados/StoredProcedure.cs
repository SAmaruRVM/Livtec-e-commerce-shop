namespace Livtec.PersistenciaDados
{
    internal enum StoredProcedure
    {
        UspInserirUtilizador,
        UspUtilizadorPorId,
        UspAutenticarUtilizador,
        UspAtualizarCookieAutenticacao,
        UspAtivarContaUtilizador,
        UspUtilizadorPorCookieAutenticacaoGuid,
        UspInserirEditora,
        UspTodasEditoras,
        UspEliminarEditoraPorId,
        UspInserirLivro,
        UspLivrosPaginacao,
        UspTodosLivros,
        UspAtualizarEditora,
        UspAdicionaLivroAoCarrinho,
        UspProcurarLivroPorISBN
    }
}
