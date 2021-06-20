using Livtec.Entidades;
using Livtec.PersistenciaDados.Implementacoes;
using Livtec.Logica.Extensions;
using System;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Web.UI;
using System.Web;
using Livtec.Logica;
using Livtec.PersistenciaDados;
using Livtec.Web.Extensions;

namespace Livtec.Web
{
    public partial class Default : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!(IsPostBack))
            {
                var utilizadorLogado = new UserAutenticacao().VerificarSeUserEstaLogado(Guid.TryParse(Request.Cookies.Get("Authentication")?.Value, out var authGuid) ? authGuid : Guid.Empty) ?? Session["UtilizadorLogado"] as Utilizador;
                if (utilizadorLogado != null)
                {
                    // Então, user está logado
                    Session["UtilizadorLogado"] = utilizadorLogado;

                    if (utilizadorLogado.TipoUtilizador == TipoUtilizador.Admin)
                    {
                        Response.Redirect($"Administrador/{nameof(Index)}.aspx");
                    }

                    LinkMeusDadosPessoais.Visible = true;
                    LinkMinhasEncomendas.Visible = true;
                    DropDownDividerLogout.Visible = true;
                    BtnLogout.Visible = true;
                    BtnLoginModal.Visible = false;
                    BtnRegistarModal.Visible = false;
                    DropDownDivider.Visible = false;
                    navbarDropdown.InnerText = $"Olá, {utilizadorLogado.Email}!";
                }
            }
        }

        protected void BtnEfetuarLogin_Click(object sender, EventArgs e)
        {
            try
            {
                var guidGeradoCookie = Guid.NewGuid();

                Response.Cookies.Add(new HttpCookie(name: "Authentication", value: guidGeradoCookie.ToString())
                {
                    Expires = DateTime.Now.AddDays(30),
                    HttpOnly = true,
                    Path = "/",
                });

                Utilizador utilizadorLogado = new UserAutenticacao().AutenticarUtilizador(TBEmailLogin.Text, TBPasswordLogin.Text, guidGeradoCookie);

                Session["UtilizadorLogado"] = utilizadorLogado;

                if(utilizadorLogado.TipoUtilizador == TipoUtilizador.Admin)
                {
                    Response.Redirect($"Administrador/{nameof(Index)}.aspx");
                }

                Response.Redirect(Request.RawUrl);
            }
            catch (CredenciaisErradasException credenciaisErradasException)
            {
                var mostrarNotificacao = "mostrarNotificacao('Não foi possível autenticar com as credenciais que nos forneceu', " +
                                       $"'{credenciaisErradasException.Message}', 'erro')";
                ScriptManager.RegisterStartupScript(Page, GetType(), "MostrarNotificacaoLoginErroCredenciaisCredenciaisErradasException", mostrarNotificacao, true);
            }
            catch (SqlException sqlException)
            {
                var mostrarNotificacao = "mostrarNotificacao('Não foi possível autenticar com as credenciais que nos forneceu', " +
                                        $"'{sqlException.Message}', 'erro')";
                ScriptManager.RegisterStartupScript(Page, GetType(), "MostrarNotificacaoLoginErroCredenciaisSqlException", mostrarNotificacao, true);
            }
        }

        protected void BtnEfetuarRegisto_Click(object sender, EventArgs e)
        {
            try
            {
                var utilizadorRepository = new UtilizadorRepository();
                var mostrarNotificacao = "mostrarNotificacao('Registo efetuado com sucesso', " +
                                         "'Foi enviado um email onde terá que ativar a sua conta de modo a que possa navegar pelo nosso site. Obrigado por se juntar a nós!', 'sucesso')";

                Utilizador utilizadorInserido = utilizadorRepository.Inserir(new Utilizador
                {
                    Email = TBEmailRegisto.Text,
                    Password = TBPasswordRegisto.Text
                });
                new SmtpClient().EnviarEmail(utilizadorInserido.Email, "Livtec - Obrigado por se juntar a nós!", $"<a href='https://localhost:44393/{nameof(Ativacao_Conta).Replace('_', '-')}.aspx?email={utilizadorInserido.Email.Encrypt()}'>Ative a sua conta</a>");

                ScriptManager.RegisterStartupScript(Page, GetType(), "FecharModalRegisto", "$('#modal-registo').modal('hide')", true);
                ScriptManager.RegisterStartupScript(Page, GetType(), "MostrarNotificacaoRegistoSucesso", mostrarNotificacao, true);
            }
            catch (SqlException sqlException)
            {
                var mostrarNotificacao = "mostrarNotificacao('Erro ao tentar criar conta', " +
                                        $"'{sqlException.Message}', 'erro')";
                ScriptManager.RegisterStartupScript(Page, GetType(), "MostrarNotificacaoRegistoErro", mostrarNotificacao, true);
            }
        }

        protected void BtnLogout_Click(object sender, EventArgs e)
        {
            Response.RemoverCookie("Authentication");
            Response.Redirect(Request.RawUrl);
        }
    }
}