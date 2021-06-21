using Livtec.Entidades;
using Livtec.PersistenciaDados.Implementacoes;
using Livtec.Web.Extensions;
using System;
using System.Web.UI.WebControls;

namespace Livtec.Web
{
    public partial class Detalhes_Livro : System.Web.UI.Page
    {
        private Livro _livroURL = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["isbn"] is null)
            {
                Response.StatusCode(404);
            }

            _livroURL = new LivroRepository().EncontrarPorISBN(Request.QueryString["isbn"]);

            // Se nenhum livro for devolvido com o isbn especificado, então respondemos com um status code 404 porque esse livro / url não existe
            if (_livroURL is null)
            {
                Response.StatusCode(404);
            }

            Title = _livroURL.Titulo;
            LblNomeLivro.Text = _livroURL.Titulo;
            LblPrecoLivro.Text = $"{_livroURL.Preco}€";
            LblEditoraLivro.Text = $"Editora: {_livroURL.Editora.Nome}";
            LblAnoEdicaoLivro.Text = $"Ano de edição: {_livroURL.AnoEdicao}";
            LblSinopseLivro.Text = _livroURL.Sinopse ?? "A sinopse deste livro não se encontra disponível. Pedimos desculpa pelo incómodo";
            ImagemCapaLivro.ImageUrl = (_livroURL.Imagem is null) ? "Recursos/Imagens/Imagem-Livro-Placeholder.png" : $"src='data:image/png;base64,{Convert.ToBase64String(_livroURL.Imagem)}";
        }

        protected void LinkBtnAdicionarLivroAoCarrinho_Click(object sender, EventArgs e)
        {
            var tupleCarrinho = (quantidadeProdutos: 0, valorTotalCarrinho: 0M);

            if (Session["UtilizadorLogado"] != null && Session["UtilizadorLogado"] is Utilizador utilizador)
            {
                // Então, user está logado
                tupleCarrinho = new CarrinhoRepository().AdicionarLivro(utilizador.Id, _livroURL.Id);
            }
            ((Label)Master.FindControl("LblNumeroProdutosCarrinho")).Text = $"{tupleCarrinho.quantidadeProdutos} produtos - Total: {tupleCarrinho.valorTotalCarrinho}€";
        }
    }
}