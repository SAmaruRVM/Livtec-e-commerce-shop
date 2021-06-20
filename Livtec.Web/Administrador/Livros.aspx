<%@ Page Title="" Language="C#" MasterPageFile="~/Administrador/Admin.Master" AutoEventWireup="true" CodeBehind="Livros.aspx.cs" Inherits="Livtec.Web.Administrador.Produtos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Livtec Livros - Administração</title>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager runat="server"></asp:ScriptManager>

    <button type="button" class="btn btn-primary btn-block" data-toggle="modal" data-target="#modal-novo-produto">Adicionar novo produto</button>

    <asp:GridView ID="GVProdutos" runat="server" CssClass="table table-sm table-dark">
    </asp:GridView>


    <div class="modal fade" id="modal-novo-produto" tabindex="-1" aria-labelledby="modal-novo-produto-label" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modal-novo-produto-label">Adicionar novo livro</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel runat="server" ID="UpdtPanelInserirLivro">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="TBTituloAdicionarLivro" class="col-form-label">Título</label>
                                        <asp:TextBox runat="server" ID="TBTituloAdicionarLivro" TextMode="SingleLine" class="form-control rounded-0" />
                                        <asp:RequiredFieldValidator runat="server"
                                            CssClass="text-danger text-center m-0"
                                            ControlToValidate="TBTituloAdicionarLivro"
                                            ErrorMessage="O título do livro é de preenchimento obrigatório!"
                                            SetFocusOnError="true"
                                            ValidationGroup="VGAdicionarProduto"
                                            Display="Dynamic" />

                                    </div>
                                    <div class="form-group">
                                        <label for="TBPrecoAdicionarLivro" class="col-form-label">Preço</label>
                                        <asp:TextBox runat="server" ID="TBPrecoAdicionarLivro" TextMode="Number" class="form-control rounded-0" />
                                        <asp:RequiredFieldValidator runat="server"
                                            CssClass="text-danger text-center m-0"
                                            ControlToValidate="TBPrecoAdicionarLivro"
                                            ErrorMessage="O preço do livro é de preenchimento obrigatório!"
                                            SetFocusOnError="true"
                                            ValidationGroup="VGAdicionarProduto"
                                            Display="Dynamic" />

                                        <asp:RangeValidator runat="server"
                                            CssClass="text-danger text-center m-0"
                                            ControlToValidate="TBPrecoAdicionarLivro"
                                            ErrorMessage="O preço do livro tem que ser maior que 0 obrigatoriamente!"
                                            SetFocusOnError="true"
                                            ValidationGroup="VGAdicionarProduto"
                                            Display="Dynamic" />
                                    </div>

                                    <div class="form-group">
                                        <label for="TBNumeroPaginasAdicionarLivro" class="col-form-label">Número de páginas</label>
                                        <asp:TextBox runat="server" ID="TBNumeroPaginasAdicionarLivro" TextMode="Number" class="form-control rounded-0" />
                                        <asp:RequiredFieldValidator runat="server"
                                            CssClass="text-danger text-center m-0"
                                            ControlToValidate="TBNumeroPaginasAdicionarLivro"
                                            ErrorMessage="O número de páginas do livro é de preenchimento obrigatório!"
                                            SetFocusOnError="true"
                                            ValidationGroup="VGAdicionarProduto"
                                            Display="Dynamic" />

                                        <asp:RangeValidator runat="server"
                                            CssClass="text-danger text-center m-0"
                                            ControlToValidate="TBNumeroPaginasAdicionarLivro"
                                            ErrorMessage="O número de páginas do livro tem que ser maior que 0 obrigatoriamente!"
                                            SetFocusOnError="true"
                                            ValidationGroup="VGAdicionarProduto"
                                            Display="Dynamic" />


                                    </div>

                                    <div class="form-group">
                                        <label for="DDLTipoLivroAdicionarLivro" class="col-form-label">Tipo de livro</label>
                                        <asp:DropDownList runat="server" ID="DDLTipoLivroAdicionarLivro" CssClass="wide" DataSourceID="TiposLivrosDropdownListDataSource" DataTextField="Designacao" DataValueField="Id">
                                            <asp:ListItem disabled Selected="True" Text="-- Selecionar --"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:SqlDataSource runat="server" ID="TiposLivrosDropdownListDataSource" ConnectionString="Data Source=.\SQLEXPRESS;Initial Catalog=Livtec;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT * FROM [TiposLivros]"></asp:SqlDataSource>
                                    </div>


                                </div>

                                <div class="col-md-6">


                                    <div class="form-group">
                                        <label for="TBIdiomaAdicionarLivro" class="col-form-label">Idioma</label>
                                        <asp:TextBox runat="server" ID="TBIdiomaAdicionarLivro" TextMode="SingleLine" class="form-control rounded-0" />
                                        <asp:RequiredFieldValidator runat="server"
                                            CssClass="text-danger text-center m-0"
                                            ControlToValidate="TBIdiomaAdicionarLivro"
                                            ErrorMessage="O Idioma do livro é de preenchimento obrigatório!"
                                            SetFocusOnError="true"
                                            ValidationGroup="VGAdicionarProduto"
                                            Display="Dynamic" />
                                    </div>



                                    <div class="form-group">
                                        <label for="TBAnoEdicaoAdicionarLivro" class="col-form-label">Ano de edição</label>
                                        <asp:TextBox runat="server" ID="TBAnoEdicaoAdicionarLivro" TextMode="SingleLine" class="form-control rounded-0 yearpicker" />
                                        <asp:RequiredFieldValidator runat="server"
                                            CssClass="text-danger text-center m-0"
                                            ControlToValidate="TBAnoEdicaoAdicionarLivro"
                                            ErrorMessage="O ano de edição do livro é de preenchimento obrigatório!"
                                            SetFocusOnError="true"
                                            ValidationGroup="VGAdicionarProduto"
                                            Display="Dynamic" />
                                    </div>

                                    <div class="form-group">
                                        <label for="TBISBNAdicionarLivro" class="col-form-label">ISBN</label>
                                        <asp:TextBox runat="server" ID="TBISBNAdicionarLivro" TextMode="SingleLine" class="form-control rounded-0" />
                                        <asp:RequiredFieldValidator runat="server"
                                            CssClass="text-danger text-center m-0"
                                            ControlToValidate="TBISBNAdicionarLivro"
                                            ErrorMessage="O ISBN do livro é de preenchimento obrigatório!"
                                            SetFocusOnError="true"
                                            ValidationGroup="VGAdicionarProduto"
                                            Display="Dynamic" />
                                    </div>



                                    <div class="form-group">
                                        <label for="DDLEditoraAdicionarLivro" class="col-form-label">Editora</label>
                                        <asp:DropDownList runat="server" ID="DDLEditoraAdicionarLivro" CssClass="wide" DataSourceID="EditorasDropdownListDataSource" DataTextField="Nome" DataValueField="Id">
                                            <asp:ListItem disabled Selected="True" Text="-- Selecionar --"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="EditorasDropdownListDataSource" runat="server" ConnectionString="Data Source=.\SQLEXPRESS;Initial Catalog=Livtec;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT * FROM [Editoras] ORDER BY [Nome]"></asp:SqlDataSource>
                                        <asp:Button runat="server" ID="BtnAdicionarNovaEditora" CssClass="float-right btn btn-dark btn-sm mt-2 p-2" Text="Adicionar nova editora" OnClick="BtnAdicionarNovaEditora_Click" />
                                    </div>




                                </div>


                            </div>


                            <div class="form-group">
                                <label for="TBSinopseAdicionarLivro" class="col-form-label">Sinopse</label>
                                <asp:TextBox runat="server" ID="TBSinopseAdicionarLivro" TextMode="MultiLine" class="form-control rounded-0" />

                            </div>


                            <div class="custom-file mt-2 mb-4 p-2">
                                <label for="FPCapaImagemLivro" class="custom-file-label">Capa do livro (Imagem)</label>
                                <asp:FileUpload runat="server" ID="FPCapaImagemLivro" accept="image/*" CssClass="custom-file-input" />
                            </div>



                            <asp:LinkButton runat="server"
                                ID="BtnAdicionarLivro"
                                CssClass="btn btn-block btn-primary"
                                ValidationGroup="VGAdicionarProduto"
                                OnClick="BtnAdicionarLivro_Click">
                          <asp:UpdateProgress runat="server" AssociatedUpdatePanelID="UpdtPanelInserirLivro">
                                        <ProgressTemplate>
                                           <i class="fas fa-circle-notch fa-spin"></i>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                        <i class="fas fa-book"></i>
                            Adicionar livro
                            </asp:LinkButton>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
                </div>
            </div>
        </div>
    </div>







</asp:Content>
