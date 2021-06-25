using Livtec.Entidades;
using Livtec.PersistenciaDados.Implementacoes;
using Livtec.Web.Extensions;
using System;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Livtec.Web
{
    public partial class Detalhes_Livro : System.Web.UI.Page
    {
        private Livro _livroURL = null;
        private Utilizador _utilizadorLogado = null;
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


            if (Session["UtilizadorLogado"] != null && Session["UtilizadorLogado"] is Utilizador utilizador)
            {
                // Então, user está logado
                _utilizadorLogado = utilizador;
                BtnInserirOpiniao.Visible = true;
                TBInserirOpiniao.Visible = true;
            }



            RptrOpinioesLivro.DataSource = new OpiniaoRepository().EncontrarPorIdLivro(_livroURL.Id);
            RptrOpinioesLivro.DataBind();

            Title = _livroURL.Titulo;
            LblNomeLivro.Text = _livroURL.Titulo;
            LblPrecoLivro.Text = $"{_livroURL.Preco}€";
            LblEditoraLivro.Text = $"Editora: {_livroURL.Editora.Nome}";
            LblAnoEdicaoLivro.Text = $"Ano de edição: {_livroURL.AnoEdicao}";
            LblSinopseLivro.Text = _livroURL.Sinopse ?? "A sinopse deste livro não se encontra disponível. Pedimos desculpa pelo incómodo";
            ImagemCapaLivro.ImageUrl = (_livroURL.Imagem is null) ? "Recursos/Imagens/Imagem-Livro-Placeholder.png" : $"src='data:image/png;base64,{Convert.ToBase64String(_livroURL.Imagem)}";
            TBInserirOpiniao.Attributes.Add("placeholder", $"Diga-nos o que achou de {_livroURL.Titulo}");

        }

        protected void LinkBtnAdicionarLivroAoCarrinho_Click(object sender, EventArgs e)
        {
            var tupleCarrinho = (quantidadeProdutos: 0, valorTotalCarrinho: 0M);


            tupleCarrinho = new CarrinhoRepository().AdicionarLivro(_utilizadorLogado.Id, _livroURL.Id);

            ((Label)Master.FindControl("LblNumeroProdutosCarrinho")).Text = $"{tupleCarrinho.quantidadeProdutos} produtos - Total: {tupleCarrinho.valorTotalCarrinho}€";
        }

        protected void BtnInserirOpiniao_Click(object sender, EventArgs e)
        {
            try
            {

                new OpiniaoRepository().Inserir(new Opiniao
                {
                    OpiniaoTexto = TBInserirOpiniao.Text,
                    Utilizador = new Utilizador { Id = _utilizadorLogado.Id },
                    Livro = new Livro { Id = _livroURL.Id }
                });


                // Javascript
                var mostrarNotificacao = "mostrarNotificacao('A sua opinião importa bastante para que possamos melhorar', " +
                                $"'Obrigado por dar a sua opinião!', 'sucesso')";
                ScriptManager.RegisterStartupScript(Page, GetType(), "AdicionarOpiniaoSucesso", mostrarNotificacao, true);
            }
            catch (SqlException sqlException)
            {
                // Javascript
                var mostrarNotificacao = "mostrarNotificacao('Não foi possível adicionar a sua opinião sobre o livro especificado!', " +
                                     $"'{sqlException.Message}', 'erro')";
                ScriptManager.RegisterStartupScript(Page, GetType(), "AdicionarOpiniaoErro", mostrarNotificacao, true);
            }
        }
    }
}