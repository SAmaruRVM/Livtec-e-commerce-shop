<%@ Page Title="" Language="C#" MasterPageFile="~/Administrador/Admin.Master" AutoEventWireup="true" CodeBehind="Livros.aspx.cs" Inherits="Livtec.Web.Administrador.Produtos" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Livtec Livros - Administração</title>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager runat="server"></asp:ScriptManager>
    <asp:UpdatePanel runat="server" ID="UpdtPanelEliminarAtualizarLivro">
        <ContentTemplate>
            <div class="container col-lg-12 mt-2 flex-column d-flex">
                <button type="button" class="btn btn-primary my-3 w-25 align-self-lg-end" data-toggle="modal" data-target="#modal-novo-livro">Inserir um novo livro</button>
                <div class="card mb-4 mt-2 shadow-lg">
                    <div class="card-header bg-dark text-center text-light">
                        <i class="fas fa-pen-alt"></i>
                        Livros
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th style="text-align: center; vertical-align: middle;">Título</th>
                                        <th style="text-align: center; vertical-align: middle;">Preço</th>
                                        <th style="text-align: center; vertical-align: middle;">NumeroPaginas</th>
                                        <th style="text-align: center; vertical-align: middle;">Sinopse</th>
                                        <th style="text-align: center; vertical-align: middle;">ISBN</th>
                                        <th style="text-align: center; vertical-align: middle;">Idioma</th>
                                        <th style="text-align: center; vertical-align: middle;">Ano Edição</th>
                                        <th style="text-align: center; vertical-align: middle;">Capa</th>
                                        <th style="text-align: center; vertical-align: middle;">Data criação</th>
                                        <th style="text-align: center; vertical-align: middle;">Nome Editora</th>
                                        <th style="text-align: center; vertical-align: middle;">Tipo do livro</th>
                                    </tr>
                                </thead>
                                <asp:Repeater runat="server" ID="RptrLivrosTable">
                                    <HeaderTemplate>
                                        <tbody class="text-center text-md-center">
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td style="text-align: center; vertical-align: middle;">
                                                <%# Eval("Titulo") %>
                                            </td>
                                            <td style="text-align: center; vertical-align: middle;">
                                                <%# Eval("Preco") + "€" %>
                                            </td>
                                            <td style="text-align: center; vertical-align: middle;">
                                                <%# Eval("NumeroPaginas") %>
                                            </td>
                                            <td style="text-align: center; vertical-align: middle;">
                                                <%# string.IsNullOrWhiteSpace(Eval("Sinopse").ToString()) ? "A sinopse deste livro não se encontra disponível. Pedimos desculpa pelo incómodo" : Eval("Sinopse") %>
                                            </td>
                                            <td style="text-align: center; vertical-align: middle;">
                                                <%# Eval("ISBN") %>
                                            </td>
                                            <td style="text-align: center; vertical-align: middle;">
                                                <%# Eval("Idioma") %>
                                            </td>
                                            <td style="text-align: center; vertical-align: middle;">
                                                <%# Eval("AnoEdicao") %>
                                            </td>
                                            <td style="text-align: center; vertical-align: middle;">
                                                <img style="height: 50px;" alt="Capa do livro (Imagem)" <%# (Eval("Imagem") is null) ? "src='../Recursos/Imagens/Imagem-Livro-Placeholder.png'" : $"src='data:image/png;base64,{Convert.ToBase64String((byte[])Eval("Imagem"))}'" %> />
                                            </td>
                                            <td style="text-align: center; vertical-align: middle;">
                                                <%# Eval("DataCriacao") %>
                                            </td>
                                            <td style="text-align: center; vertical-align: middle;">
                                                <%# Eval("Editora.Nome") %>
                                                <asp:Button runat="server" ID="BtnAtualizarRemoverEditora" class="btn btn-primary btn-danger"
                                                    Text="Atualizar/Remover" OnCommand="BtnAtualizarRemoverEditora_Command" CommandArgument='<%# $"{Eval("Editora.Id")};{Eval("Editora.Nome")}" %>' />
                                            </td>
                                            <td style="text-align: center; vertical-align: middle;">
                                                <%# Eval("TipoLivro") %>
                                            </td>
                                            <td style="text-align: center; vertical-align: middle;">
                                                <asp:Button runat="server" ID="BtnAtualizarLivro" Text="Atualizar" CssClass="btn btn-success" />
                                                <asp:Button runat="server" ID="BtnEliminarLivro" Text="Eliminar" CssClass="btn btn-danger"
                                                    OnCommand="BtnEliminarLivro_Command" CommandArgument='<%# Eval("Id") %>' />
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        </tbody>
                                    </FooterTemplate>
                                </asp:Repeater>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>



    <div class="modal fade" id="modal-novo-livro" tabindex="-1" aria-labelledby="modal-novo-livro-label" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title font-weight-bold h3" id="modal-novo-livro-label">Adicionar novo livro</h5>
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
                                            MinimumValue="1"
                                            MaximumValue="999.99"
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
                                            MinimumValue="1"
                                            MaximumValue="9999999"
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


                            
                            <div class="form-group">
                                <label for="CKBListAutoresAssociacaoLivroInserir" class="col-form-label">Associar autores a este livro</label>
                                    <asp:CheckBoxList runat="server" ID="CKBListAutoresAssociacaoLivroInserir" AutoPostBack="true" ClientIDMode="AutoID">
                                    </asp:CheckBoxList>
                            </div>
                 
                            

                            <div class="custom-file mt-2 mb-4 p-2">
                                <label for="FPCapaImagemLivroAsync" class="custom-file-label">Capa do livro (Imagem)</label>
                                <ajaxToolkit:AsyncFileUpload runat="server" ID="FPCapaImagemLivroAsync" accept="image/*" CssClass="custom-file-input" OnUploadedComplete="OnCompleteUploadImagemLivro" />
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
