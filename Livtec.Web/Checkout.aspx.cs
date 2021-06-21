using Livtec.Entidades;
using Livtec.PersistenciaDados.Implementacoes;
using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace Livtec.Web
{
    public partial class Checkout : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Utilizador utilizadorLogado = (Utilizador)Session["UtilizadorLogado"];
            RptrProdutosCarrinho.DataSource = new CarrinhoRepository().VerLivrosPertencentesAUmCarrinho(utilizadorLogado.Id);
            RptrProdutosCarrinho.DataBind();

            var tupleCarrinho = (quantidadeProdutos: 0, valorTotalCarrinho: 0M);

            tupleCarrinho = new CarrinhoRepository().TotalProdutosValorTotal(utilizadorLogado.Id);

            LblValorTotalCarrinho.Text = tupleCarrinho.valorTotalCarrinho + "€";
        }

        protected void BtnCheckOut_Click(object sender, EventArgs e) 
        {
            try 
            {
                new CarrinhoRepository().CheckOut(((Utilizador)Session["UtilizadorLogado"]).Id);

            }
            catch(SqlException sqlException) 
            {
                // Javascript
                var mostrarNotificacao = "mostrarNotificacao('Erro ao realizar o checkout', " +
                                  $"'{sqlException.Message}', 'erro')";
                ScriptManager.RegisterStartupScript(Page, GetType(), "MostrarNotificacaoInsercaoLivroErro", mostrarNotificacao, true);
            }
        }
    }
}