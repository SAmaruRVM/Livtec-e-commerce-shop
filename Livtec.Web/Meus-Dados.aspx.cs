using Livtec.Entidades;
using System;

namespace Livtec.Web
{
    public partial class Meus_Dados : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            Utilizador utilizadorLogado = (Utilizador)Session["UtilizadorLogado"];
            TBEmailAlteracaoDados.Text = utilizadorLogado.Email;
        }
    }
}