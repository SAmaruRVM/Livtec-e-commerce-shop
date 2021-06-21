<%@ Page Title="" Language="C#" MasterPageFile="~/Administrador/Admin.Master" AutoEventWireup="true" CodeBehind="Autores.aspx.cs" Inherits="Livtec.Web.Administrador.Autores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <title>Livtec Autores - Administração</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager runat="server"></asp:ScriptManager>
    <asp:UpdatePanel runat="server" ID="UpdtPanelEliminarAtualizarAutor">
        <ContentTemplate>
            <div class="container col-lg-12 mt-2 flex-column d-flex">
                <button type="button" class="btn btn-primary my-3 w-25 align-self-lg-end" data-toggle="modal" data-target="#modal-novo-autor">Inserir um novo autor/a</button>
                <div class="card mb-4 mt-2 shadow-lg">
                    <div class="card-header bg-dark text-center text-light">
                        <i class="fas fa-pen-alt"></i>
                        Autores
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th style="text-align: center; vertical-align: middle;">Nome</th>
                                        <th style="text-align: center; vertical-align: middle;">Biografia</th>
                                        <th style="text-align: center; vertical-align: middle;">Imagem</th>
                                        <th style="text-align: center; vertical-align: middle;">Alterações</th>
                                    </tr>
                                </thead>
                                <asp:Repeater runat="server" ID="RptrAutoresTable">
                                    <HeaderTemplate>
                                        <tbody class="text-center text-md-center">
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td style="text-align: center; vertical-align: middle;">
                                                <%# Eval("Nome") %>
                                            </td>
                                            <td style="text-align: center; vertical-align: middle;">
                                                <%# Eval("Biografia") %>
                                            </td>
                                            <td style="text-align: center; vertical-align: middle;">
                                                <img style="height:50px;" alt="Capa do livro (Imagem)" <%# (Eval("Imagem") is null) ? "src='../Recursos/Imagens/Imagem-Livro-Placeholder.png'" : $"src='data:image/png;base64,{Convert.ToBase64String((byte[])Eval("Imagem"))}'" %> />
                                            </td>
                                            <td style="text-align: center; vertical-align: middle;">
                                                <asp:Button runat="server" ID="BtnAtualizarEditora" Text="Atualizar" CssClass="btn btn-success"
                                                    OnCommand="BtnAtualizarAutor_Command"
                                                    CommandArgument='<%# Eval("Id") + ";" + Eval("Nome") %>' />
                                                <asp:Button runat="server" ID="BtnEliminarEditora" Text="Eliminar" CssClass="btn btn-danger"
                                                    OnCommand="BtnEliminarAutor_Command" CommandArgument='<%# Eval("Id") %>' />
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








    <div class="modal fade" id="modal-atualizar-autor" tabindex="-1" aria-labelledby="modal-atualizar-autor-label" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title font-weight-bold h3" id="modal-atualizar-autor-label">Atualizar Autor</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel runat="server" ID="UpdtPanelAtualizarAutor">
                        <ContentTemplate>
                            <div class="form-group">
                                <label for="TBNomeAtualizarAutor" class="col-form-label">Nome<i class="far fa-newspaper ml-2"></i></label>
                                <asp:TextBox runat="server" ID="TBNomeAtualizarAutor" TextMode="SingleLine" class="form-control rounded-0" placeholder="Nome do autor/a" />
                                <asp:RequiredFieldValidator runat="server"
                                    CssClass="text-danger text-center m-0"
                                    ControlToValidate="TBNomeAtualizarAutor"
                                    ErrorMessage="O Nome do autor/a é de preenchimento obrigatório!"
                                    SetFocusOnError="true"
                                    ValidationGroup="VGAtualizarAutor"
                                    Display="Dynamic" />
                            </div>

                            <div class="form-group">
                                <label for="TBBiografiaAtualizarAutor" class="col-form-label">Biografia<i class="far fa-newspaper ml-2"></i></label>
                                <asp:TextBox runat="server" ID="TBBiografiaAtualizarAutor" TextMode="Multiline" class="form-control rounded-0" placeholder="Biografia do autor/a" />
                            </div>




                            <asp:HiddenField runat="server" ID="HiddenFieldIdAutor" />
                            <asp:LinkButton runat="server"
                                ID="BtnAtualizarAutor"
                                CssClass="btn btn-block btn-primary"
                                ValidationGroup="VGAtualizarAutor">
                        <i class="fas fa-book"></i>
                            Atualizar autor/a
                            </asp:LinkButton>

                            <asp:LinkButton runat="server"
                                ID="BtnEliminarAutor"
                                CssClass="btn btn-block btn-danger">
                        <i class="fas fa-trash"></i>
                            Eliminar autor/a
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

























    <div class="modal fade" id="modal-novo-autor" tabindex="-1" aria-labelledby="modal-novo-autor-label" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title font-weight-bold h3" id="modal-novo-autor-label">Adicionar novo autor/a</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel runat="server" ID="UpdtPanelInserirAutor">
                        <ContentTemplate>
                            <div class="form-group">
                                <label for="TBNomeAdicionarAutor" class="col-form-label">Nome<i class="far fa-newspaper ml-2"></i></label>
                                <asp:TextBox runat="server" ID="TBNomeAdicionarAutor" TextMode="SingleLine" class="form-control rounded-0" placeholder="Nome do autor/a" />
                                <asp:RequiredFieldValidator runat="server"
                                    CssClass="text-danger text-center m-0"
                                    ControlToValidate="TBNomeAdicionarAutor"
                                    ErrorMessage="O Nome do autor/a é de preenchimento obrigatório!"
                                    SetFocusOnError="true"
                                    ValidationGroup="VGAdicionarAutor"
                                    Display="Dynamic" />
                            </div>


                            <div class="form-group">
                                <label for="TBBiografiaAdicionarAutor" class="col-form-label">Biografia<i class="far fa-newspaper ml-2"></i></label>
                                <asp:TextBox runat="server" ID="TBBiografiaAdicionarAutor" TextMode="Multiline" class="form-control rounded-0" placeholder="Biografia do autor/a" />
                            </div>


                            <div class="custom-file mt-2 mb-4 p-2">
                                <label for="FPImagemAdicionarAutorAsync" class="custom-file-label">Imagem</label>
                                <ajaxToolkit:AsyncFileUpload runat="server" ID="FPImagemAdicionarAutorAsync" accept="image/*" CssClass="custom-file-input" OnUploadedComplete="OnCompleteUploadImagemAutor" />
                            </div>




                            <asp:LinkButton runat="server"
                                ID="BtnAdicionarAutor"
                                CssClass="btn btn-block btn-primary"
                                ValidationGroup="VGAdicionarAutor"
                                OnClick="BtnAdicionarAutor_Click">
                          <asp:UpdateProgress runat="server" AssociatedUpdatePanelID="UpdtPanelInserirAutor">
                                        <ProgressTemplate>
                                           <i class="fas fa-circle-notch fa-spin"></i>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                        <i class="fas fa-book"></i>
                            Adicionar Autor
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
