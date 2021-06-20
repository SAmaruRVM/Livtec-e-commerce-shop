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


            RptrEditorasTable.DataSource = new EditoraRepository().TodasEditoras();
            RptrEditorasTable.DataBind();
        }

        protected void BtnAdicionarEditora_Click(object sender, EventArgs e)
        {
            try 
            {
                new EditoraRepository().Inserir(new Editora { Nome = TBNomeAdicionarEditora.Text });
                var mostrarNotificacao = "mostrarNotificacao('Editora inserida com sucesso', " +
                                         "'A editora com os dados fornecidos foi inserida com sucesso!', 'sucesso')";
                ScriptManager.RegisterStartupScript(Page, GetType(), "FecharModalEditora", "$('#modal-nova-editora').modal('hide')", true);
                ScriptManager.RegisterStartupScript(Page, GetType(), "MostrarNotificacaoInsericaoEditoraSucesso", mostrarNotificacao, true);

                RptrEditorasTable.DataSource = new EditoraRepository().TodasEditoras();
                RptrEditorasTable.DataBind();
            }
            catch(SqlException sqlException) 
            {
                var mostrarNotificacao = "mostrarNotificacao('Erro ao tentar inserir uma nova editora', " +
                                   $"'{sqlException.Message}', 'erro')";
                ScriptManager.RegisterStartupScript(Page, GetType(), "MostrarNotificacaoRegistoErro", mostrarNotificacao, true);
            }
        }

        protected void BtnEliminarEditora_Command(object sender, CommandEventArgs e) 
        {
            try
            {
                new EditoraRepository().EliminarPorId(int.Parse(e.CommandArgument.ToString()));
            }
            catch (SqlException sqlException)
            {

            }
        }
    }
}