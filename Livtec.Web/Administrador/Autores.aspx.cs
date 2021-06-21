using AjaxControlToolkit;
using Livtec.Entidades;
using Livtec.Logica.Extensions;
using Livtec.PersistenciaDados.Implementacoes;
using System;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Livtec.Web.Administrador
{
    public partial class Autores : Page
    {
        private byte[] _dadosBinariosImagem = null;

        protected void Page_Load(object sender, EventArgs e)
        {



            RptrAutoresTable.DataSource = new AutorRepository().SemPaginacao();
            RptrAutoresTable.DataBind();
        }


        protected void OnCompleteUploadImagemAutor(object sender, AsyncFileUploadEventArgs e)
        {
            if (FPImagemAdicionarAutorAsync.PostedFile != null)
            {
                _dadosBinariosImagem = FPImagemAdicionarAutorAsync.PostedFile.InputStream.ToByteArray();
            }
        }


        protected void BtnAdicionarAutor_Click(object sender, EventArgs e)
        {
            try
            {

                var autorInserido = new AutorRepository().Inserir(new Autor 
                {
                    Nome = TBNomeAdicionarAutor.Text,
                    Biografia = TBBiografiaAdicionarAutor.Text,
                    Imagem = _dadosBinariosImagem
                });



                // Javascript
                var mostrarNotificacao = "mostrarNotificacao('O autor foi inserido com sucesso', " +
                             $"'O/a autor/a {autorInserido.Nome} foi inserido/a com sucesso!', 'sucesso')";
                ScriptManager.RegisterStartupScript(Page, GetType(), "FecharModalLivro", "$('#modal-novo-autor').modal('hide')", true);
                ScriptManager.RegisterStartupScript(Page, GetType(), "MostrarNotificacaoInsercaoAutorSucesso", mostrarNotificacao, true);
            }
            catch (SqlException sqlException)
            {
                // Javascript
                var mostrarNotificacao = "mostrarNotificacao('Erro ao tentar inserir um novo autor/a', " +
                                  $"'{sqlException.Message}', 'erro')";
                ScriptManager.RegisterStartupScript(Page, GetType(), "MostrarNotificacaoInsercaoAutorErro", mostrarNotificacao, true);
            }
        }





        protected void BtnAtualizarAutor_Command(object sender, CommandEventArgs e)
        {

        }


        protected void BtnEliminarAutor_Command(object sender, CommandEventArgs e)
        {
            try
            {
                Autor autorEliminado = new AutorRepository().EliminarPorId(int.Parse(e.CommandArgument.ToString()));


                // Notificações - Javascript
                var mostrarNotificacao = "mostrarNotificacao('O/a autor/a foi eliminada com sucesso!!', " +
                                  $"'O/a autor/a {autorEliminado.Nome} foi eliminado/a da base de dados com sucesso.', 'sucesso')";
                ScriptManager.RegisterStartupScript(Page, GetType(), "MostrarNotificacaoEliminacaoEditoraSucesso", mostrarNotificacao, true);
            }
            catch (SqlException sqlException)
            {
                // Notificações - Javascript
                var mostrarNotificacao = "mostrarNotificacao('Houve um erro ao tentar eliminar o/a autor/a selecionado/a!', " +
                           $"'{sqlException.Message}', 'erro')";
                ScriptManager.RegisterStartupScript(Page, GetType(), "MostrarNotificacaoEliminacaoEditoraErro", mostrarNotificacao, true);
            }
        }
    }
}