using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace Livtec.Web
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlException contaAtivadaSqlException = null;
            if (Session["ContaAtivada"] != null)
            {
                var contaAtiva = ((contaAtivadaSqlException = Session["ContaAtivada"] as SqlException)) == null;
                var mostrarNotificacao = $"mostrarNotificacao('{(contaAtiva ? "A sua conta foi ativada com sucesso!" : "Erro na ativação da conta")}', " +
                          $"'{(contaAtiva ? "Com a sua conta ativada, já poderá realizar login e começar a fazer a encomendar os seus livros preferidos. Obrigado!" : contaAtivadaSqlException.Message)}', '{(contaAtiva ? "sucesso" : "erro")}')";
                ScriptManager.RegisterStartupScript(Page, GetType(), "MostrarNotificacaoSessionContaAtivada", mostrarNotificacao, true);
                Session.Remove("ContaAtivada");
            }
        }
    }
}