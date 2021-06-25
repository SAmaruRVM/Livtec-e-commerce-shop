using AjaxControlToolkit;
using Livtec.Entidades;
using Livtec.Logica.Extensions;
using Livtec.PersistenciaDados.Implementacoes;
using Livtec.Web.Extensions;
using System;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Livtec.Web.Administrador
{
    public partial class Produtos : System.Web.UI.Page
    {
        private byte[] _dadosBinariosImagem = null;
        protected void Page_Load(object sender, EventArgs e)
        {


            if (!(IsPostBack))
            {
                RptrLivrosTable.DataSource = new LivroRepository().SemPaginacao();
                RptrLivrosTable.DataBind();


                foreach (Autor autor in new AutorRepository().SemPaginacao())
                {
                    CKBListAutoresAssociacaoLivroInserir.Items.Add(new ListItem
                    {
                        Value = autor.Id.ToString(),
                        Text = autor.Nome
                    });
                }
            }
        }



        protected void BtnAtualizarRemoverEditora_Command(object sender, CommandEventArgs e) => Response.RedirecionarComSession(Session, "AtualizarRemoverEditoraLivro", e.CommandArgument, nameof(Editoras));


        protected void BtnEliminarLivro_Command(object sender, CommandEventArgs e)
        {

        }


        protected void OnCompleteUploadImagemLivro(object sender, AsyncFileUploadEventArgs e)
        {
            if (FPCapaImagemLivroAsync.PostedFile != null)
            {
                _dadosBinariosImagem = FPCapaImagemLivroAsync.PostedFile.InputStream.ToByteArray();
            }
        }


        protected void BtnAdicionarLivro_Click(object sender, EventArgs e)
        {
            try
            {
                var livroRepository = new LivroRepository();


                Livro livroInserido = livroRepository.Inserir(new Livro
                {
                    Titulo = TBTituloAdicionarLivro.Text,
                    Idioma = TBIdiomaAdicionarLivro.Text,
                    Editora = new Editora { Id = int.Parse(DDLEditoraAdicionarLivro.SelectedValue) },
                    ISBN = TBISBNAdicionarLivro.Text,
                    NumeroPaginas = int.Parse(TBNumeroPaginasAdicionarLivro.Text),
                    AnoEdicao = int.Parse(TBAnoEdicaoAdicionarLivro.Text),
                    Sinopse = TBSinopseAdicionarLivro.Text,
                    Preco = decimal.Parse(TBPrecoAdicionarLivro.Text),
                    TipoLivro = (TipoLivro)int.Parse(DDLTipoLivroAdicionarLivro.SelectedValue),
                    Imagem = _dadosBinariosImagem // dadosBinariosImagem
                });


                foreach (ListItem listItem in CKBListAutoresAssociacaoLivroInserir.Items)
                {
                    if (listItem.Selected)
                    {
                        livroRepository.AssociarAutorAoLivro(int.Parse(listItem.Value), livroInserido.Id);
                    }
                }




                // Javascript
                var mostrarNotificacao = "mostrarNotificacao('O livro foi inserido com sucesso', " +
                             $"'O livro com o ISBN {TBISBNAdicionarLivro.Text} foi inserido com sucesso!', 'sucesso')";
                ScriptManager.RegisterStartupScript(Page, GetType(), "FecharModalLivro", "$('#modal-novo-livro').modal('hide')", true);
                ScriptManager.RegisterStartupScript(Page, GetType(), "MostrarNotificacaoInsercaoLivroSucesso", mostrarNotificacao, true);
            }
            catch (SqlException sqlException)
            {
                // Javascript
                var mostrarNotificacao = "mostrarNotificacao('Erro ao tentar inserir um novo livro', " +
                                  $"'{sqlException.Message}', 'erro')";
                ScriptManager.RegisterStartupScript(Page, GetType(), "MostrarNotificacaoInsercaoLivroErro", mostrarNotificacao, true);
            }
        }

        protected void BtnAdicionarNovaEditora_Click(object sender, EventArgs e) => Response.RedirecionarComSession(Session, nomeSession: "RedirectEditorasInsercao", valorSession: true, nomePaginaSemExtensao: nameof(Editoras));
    }
}