using Livtec.Entidades;
using Livtec.PersistenciaDados.Implementacoes;
using System;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Livtec.Web
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!(IsPostBack))
            {
                if (Session["ContaAtivada"] != null)
                {
                    Session.Remove("ContaAtivada");
                    SqlException contaAtivadaSqlException = null;
                    var contaAtiva = ((contaAtivadaSqlException = Session["ContaAtivada"] as SqlException)) == null;

                    // Javascript
                    var mostrarNotificacao = $"mostrarNotificacao('{(contaAtiva ? "A sua conta foi ativada com sucesso!" : "Erro na ativação da conta")}', " +
                              $"'{(contaAtiva ? "Com a sua conta ativada, já poderá realizar login e começar a encomendar os seus livros preferidos. Obrigado!" : contaAtivadaSqlException.Message)}', '{(contaAtiva ? "sucesso" : "erro")}')";
                    ScriptManager.RegisterStartupScript(Page, GetType(), "MostrarNotificacaoSessionContaAtivada", mostrarNotificacao, true);
                }

            }

            CarregarRepeaterProdutos();
            CarregarRepeaterUltimosProdutos();

        }



        private void CarregarRepeaterProdutos(int pagina = 1)
        {
            RptrLivros.DataSource = new LivroRepository().Paginacao(numeroPagina: pagina);
            RptrLivros.DataBind();
        }
        private void CarregarRepeaterUltimosProdutos()
        {
            RptrUltimosLivros.DataSource = new LivroRepository().Paginacao().Take(5);
            RptrUltimosLivros.DataBind();
        }

        protected void LKBAdicionarLivroAoCarrinho_Command(object sender, CommandEventArgs e)
        {
            var tupleCarrinho = (quantidadeProdutos: 0, valorTotalCarrinho: 0M);
            try
            {
                if (Session["UtilizadorLogado"] != null && Session["UtilizadorLogado"] is Utilizador utilizador)
                {
                    // Então, user está logado
                    tupleCarrinho = new CarrinhoRepository().AdicionarLivro(utilizador.Id, int.Parse(e.CommandArgument.ToString()));
                }

                ((Label)Master.FindControl("LblNumeroProdutosCarrinho")).Text = $"{tupleCarrinho.quantidadeProdutos} produtos - Total: {tupleCarrinho.valorTotalCarrinho}€";




                // Javascript
                var mostrarNotificacao = "mostrarNotificacao('O livro foi adicionado seu carrinho com sucesso', " +
                                $"'Boa escolha! Esperemos que goste do livro!', 'sucesso')";
                ScriptManager.RegisterStartupScript(Page, GetType(), "MostrarNotificacaoLivroAdicionadoAoCarrinhoSucesso", mostrarNotificacao, true);
            }
            catch (SqlException sqlException)
            {
                // Javascript
                var mostrarNotificacao = "mostrarNotificacao('Não foi possível adicionar o livro selecionado ao seu carrinho', " +
                                     $"'{sqlException.Message}', 'erro')";
                ScriptManager.RegisterStartupScript(Page, GetType(), "MostrarNotificacaoLivroAdicionadoAoCarrinhoErro", mostrarNotificacao, true);
            }
        }
    }
}
