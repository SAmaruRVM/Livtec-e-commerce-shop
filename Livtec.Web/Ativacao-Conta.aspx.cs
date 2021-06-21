using Livtec.Logica;
using Livtec.Logica.Extensions;
using Livtec.Web.Extensions;
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
                    Response.RedirecionarComSession(Session, "ContaAtivada", "A sua conta foi ativada com sucesso!", nameof(Index));
                }
            }
            catch(SqlException sqlException) 
            {
                Response.RedirecionarComSession(Session, "ContaAtivada", sqlException, nameof(Index));
            }
        }
    }
}