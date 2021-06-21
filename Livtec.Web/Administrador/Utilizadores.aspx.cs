using Livtec.Entidades;
using Livtec.Logica.Extensions;
using Livtec.PersistenciaDados.Implementacoes;
using System;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Livtec.Web.Administrador
{
    public partial class Utilizadores : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            RptrUtilizadoresTable.DataSource = new UtilizadorRepository().SemPaginacao();
            RptrUtilizadoresTable.DataBind();
        }
        protected void BtnEnviarEmailConfirmacaoUtilizador_Command(object sender, CommandEventArgs e) 
        {
            var argumentosCommand = e.CommandArgument.ToString().Split(';');
            bool.TryParse(argumentosCommand[1], out var estaAtivo);
            if (!(estaAtivo))
            {
                new SmtpClient().EnviarEmail(argumentosCommand[0], "Livtec - Obrigado por se juntar a nós!", $"<a href='https://localhost:44393/{nameof(Ativacao_Conta).Replace('_', '-')}.aspx?email={argumentosCommand[0].ToString().Encrypt()}'>Ative a sua conta</a>");
                var mostrarNotificacao = "mostrarNotificacao('Email enviado com sucesso!', " +
                 $"'O email foi enviado com sucesso para o utilizador selecionado', 'sucesso')";
                ScriptManager.RegisterStartupScript(Page, GetType(), "MostrarNotificacaoRegistoErro", mostrarNotificacao, true);
            }
            else 
            {
                var mostrarNotificacao = "mostrarNotificacao('Erro ao tentar enviar o email de confirmação para o utilizador selecionado', " +
                   $"'Não é possível enviar um email de confirmação a utilizadores cuja conta já se encontra ativa', 'erro')";
                ScriptManager.RegisterStartupScript(Page, GetType(), "MostrarNotificacaoRegistoErro", mostrarNotificacao, true);
            }
        }

        protected void BtnEliminarUtilizador_Command(object sender, CommandEventArgs e) 
        {
            try
            {
                Utilizador utilizadorEliminado = new UtilizadorRepository().EliminarPorId(int.Parse(e.CommandArgument.ToString()));


                // Notificações - Javascript
                var mostrarNotificacao = "mostrarNotificacao('O utilizador selecionado foi eliminado com sucesso!', " +
                                  $"'O utilizador com o email ({utilizadorEliminado.Email}) foi eliminado da base de dados com sucesso.', 'sucesso')";
                ScriptManager.RegisterStartupScript(Page, GetType(), "MostrarNotificacaoEliminacaoUtilizadorSucesso", mostrarNotificacao, true);
            }
            catch (SqlException sqlException)
            {
                // Notificações - Javascript
                var mostrarNotificacao = "mostrarNotificacao('Houve um erro ao tentar eliminar o utilizador selecionado!', " +
                           $"'{sqlException.Message}', 'erro')";
                ScriptManager.RegisterStartupScript(Page, GetType(), "MostrarNotificacaoEliminacaoUtilizadorErro", mostrarNotificacao, true);
            }
        }
    }
}