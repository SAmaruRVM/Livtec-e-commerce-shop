using System;


namespace Livtec.Web.Administrador
{
    public partial class Produtos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void BtnAdicionarLivro_Click(object sender, EventArgs e)
        {

        }

        protected void BtnAdicionarNovaEditora_Click(object sender, EventArgs e)
        {
            Session["RedirectEditorasInsercao"] = true;
            Response.Redirect($"{nameof(Editoras)}.aspx");
        }
    }
}