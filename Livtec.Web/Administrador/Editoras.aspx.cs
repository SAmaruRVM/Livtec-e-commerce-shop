using Livtec.Entidades;
using Livtec.PersistenciaDados.Implementacoes;
using System;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Livtec.Web.Administrador
{
    public partial class Editoras : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["RedirectEditorasInsercao"] != null && (bool)Session["RedirectEditorasInsercao"])
            {
                ScriptManager.RegisterStartupScript(Page, GetType(), "AbrirModalEditora", "$('#modal-nova-editora').modal('show')", true);
                Session.Remove("RedirectEditorasInsercao");
            }


            RptrEditorasTable.DataSource = new EditoraRepository().SemPaginacao();
            RptrEditorasTable.DataBind();
        }

        protected void BtnAdicionarEditora_Click(object sender, EventArgs e)
        {
            try
            {
                new EditoraRepository().Inserir(new Editora { Nome = TBNomeAdicionarEditora.Text });


                // Notificações - Javascript
                var mostrarNotificacao = "mostrarNotificacao('Editora inserida com sucesso', " +
                                      "'A editora com os dados fornecidos foi inserida com sucesso!', 'sucesso')";
                ScriptManager.RegisterStartupScript(Page, GetType(), "FecharModalEditora", "$('#modal-nova-editora').modal('hide')", true);
                ScriptManager.RegisterStartupScript(Page, GetType(), "MostrarNotificacaoInsericaoEditoraSucesso", mostrarNotificacao, true);

                TBNomeAdicionarEditora.Text = string.Empty;
            }
            catch (SqlException sqlException)
            {
                // Notificações - Javascript
                var mostrarNotificacao = "mostrarNotificacao('Erro ao tentar inserir uma nova editora', " +
                                   $"'{sqlException.Message}', 'erro')";
                ScriptManager.RegisterStartupScript(Page, GetType(), "MostrarNotificacaoRegistoErro", mostrarNotificacao, true);
            }
        }



        protected void BtnAtualizarEditora_Click(object sender, EventArgs e)
        {
            try
            {
                new EditoraRepository().Atualizar(new Editora { Id = int.Parse(HiddenFieldIdEditora.Value), Nome = TBNomeAtualizarEditora.Text });


                // Notificações - Javascript
                var mostrarNotificacao = "mostrarNotificacao('Editora atualizada com sucesso', " +
                                         "'A editora selecionada foi atualizada!', 'sucesso')";
                ScriptManager.RegisterStartupScript(Page, GetType(), "FecharModalEditora", "$('#modal-atualizar-editora').modal('hide')", true);
                ScriptManager.RegisterStartupScript(Page, GetType(), "MostrarNotificacaoAtualizacaoEditoraSucesso", mostrarNotificacao, true);

                
            }
            catch (SqlException sqlException)
            {
                // Notificações - Javascript
                var mostrarNotificacao = "mostrarNotificacao('Erro ao tentar atualizar a editora selecionada', " +
                                   $"'{sqlException.Message}', 'erro')";
                ScriptManager.RegisterStartupScript(Page, GetType(), "MostrarNotificacaoRegistoErro", mostrarNotificacao, true);
            }
        }






        protected void BtnEliminarEditora_Command(object sender, CommandEventArgs e)
        {
            try
            {
                Editora editoraEliminada = new EditoraRepository().EliminarPorId(int.Parse(e.CommandArgument.ToString()));


                // Notificações - Javascript
                var mostrarNotificacao = "mostrarNotificacao('A editora selecionada foi eliminada com sucesso!', " +
                                  $"'A editora {editoraEliminada.Nome} foi eliminada da base de dados com sucesso.', 'sucesso')";
                ScriptManager.RegisterStartupScript(Page, GetType(), "MostrarNotificacaoEliminacaoEditoraSucesso", mostrarNotificacao, true);
            }
            catch (SqlException sqlException)
            {
                // Notificações - Javascript
                var mostrarNotificacao = "mostrarNotificacao('Houve um erro ao tentar eliminar a editora selecionada!', " +
                           $"'{sqlException.Message}', 'erro')";
                ScriptManager.RegisterStartupScript(Page, GetType(), "MostrarNotificacaoEliminacaoEditoraErro", mostrarNotificacao, true);
            }
        }



        protected void BtnAtualizarEditora_Command(object sender, CommandEventArgs e)
        {
            TBNomeAtualizarEditora.Text = e.CommandArgument.ToString().Split(';')[1];
            HiddenFieldIdEditora.Value = e.CommandArgument.ToString().Split(';')[0];
            ScriptManager.RegisterStartupScript(Page, GetType(), "MostrarModalAtualizarEditora", "$('#modal-atualizar-editora').modal('show')", true);
        }
    }
}