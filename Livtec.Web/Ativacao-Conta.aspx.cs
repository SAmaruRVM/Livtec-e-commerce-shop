using Livtec.Logica;
using Livtec.Logica.Extensions;
using System;
using System.Data.SqlClient;

namespace Livtec.Web
{
    public partial class Ativacao_Conta : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string email = string.Empty;
                if ((email = Request.QueryString["Email"]?.Decrypt()) != null)
                {
                    var userAutenticacao = new UserAutenticacao();
                    userAutenticacao.AtivarContaUtilizador(email);
                    Session["ContaAtivada"] = "A sua conta foi ativada com sucesso!";
                }
            }
            catch(SqlException sqlException) 
            {
                Session["ContaAtivada"] = sqlException;
            }
            finally 
            {
                Response.Redirect($"{nameof(Index)}.aspx");
            }
        }
    }
}