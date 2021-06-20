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
            if (Session["ContaAtivada"] != null)
            {
                Session.Remove("ContaAtivada");
                SqlException contaAtivadaSqlException = null;
                var contaAtiva = ((contaAtivadaSqlException = Session["ContaAtivada"] as SqlException)) == null;

                // Javascript
                var mostrarNotificacao = $"mostrarNotificacao('{(contaAtiva ? "A sua conta foi ativada com sucesso!" : "Erro na ativação da conta")}', " +
                          $"'{(contaAtiva ? "Com a sua conta ativada, já poderá realizar login e começar a fazer a encomendar os seus livros preferidos. Obrigado!" : contaAtivadaSqlException.Message)}', '{(contaAtiva ? "sucesso" : "erro")}')";
                ScriptManager.RegisterStartupScript(Page, GetType(), "MostrarNotificacaoSessionContaAtivada", mostrarNotificacao, true);
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
            if(Session["UtilizadorLogado"] != null) 
            {
                // Então, user está logado

            }
        }
    }
}