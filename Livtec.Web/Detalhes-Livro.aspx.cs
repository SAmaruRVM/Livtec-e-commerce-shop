using Livtec.PersistenciaDados.Implementacoes;
using Livtec.Web.Extensions;
using System;
namespace Livtec.Web
{
    public partial class Detalhes_Livro : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Request.QueryString["isbn"] is null) 
            {
                Response.StatusCode(404);
            }

            var livroURL = new LivroRepository().EncontrarPorISBN(Request.QueryString["isbn"]);

            // Se nenhum livro for devolvido com o isbn especificado, então mandamos um status code 404 porque esse livro / url não existe
            if(livroURL is null) 
            {
                Response.StatusCode(404);
            }


        }
    }
}