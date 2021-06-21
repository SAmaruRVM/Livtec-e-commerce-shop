<%@ Page Title="" Language="C#" MasterPageFile="~/Administrador/Admin.Master" AutoEventWireup="true" CodeBehind="Editoras.aspx.cs" Inherits="Livtec.Web.Administrador.Editoras" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Livtec Editoras - Administração</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager runat="server"></asp:ScriptManager>
    <asp:UpdatePanel runat="server" ID="UpdtPanelEliminarAtualizarEditora">
        <ContentTemplate>
            <div class="container col-lg-12 mt-2 flex-column d-flex">
                <button type="button" class="btn btn-primary my-3 w-25 align-self-lg-end" data-toggle="modal" data-target="#modal-nova-editora">Inserir uma nova editora</button>
                <div class="card mb-4 mt-2 shadow-lg">
                    <div class="card-header bg-dark text-center text-light">
                        <i class="fas fa-pen-alt"></i>
                        Editoras
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th style="text-align: center; vertical-align: middle;">Nome</th>
                                        <th style="text-align: center; vertical-align: middle;">Alterações</th>
                                    </tr>
                                </thead>
                                <asp:Repeater runat="server" ID="RptrEditorasTable">
                                    <HeaderTemplate>
                                        <tbody class="text-center text-md-center">
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td style="text-align: center; vertical-align: middle;">
                                                <%# Eval("Nome") %>
                                            </td>
                                            <td style="text-align: center; vertical-align: middle;">
                                                <asp:Button runat="server" ID="BtnAtualizarEditora" Text="Atualizar" CssClass="btn btn-success"
                                                    OnCommand="BtnAtualizarEditora_Command"
                                                    CommandArgument='<%# Eval("Id") + ";" + Eval("Nome") %>' />
                                                <asp:Button runat="server" ID="BtnEliminarEditora" Text="Eliminar" CssClass="btn btn-danger"
                                                    OnCommand="BtnEliminarEditora_Command" CommandArgument='<%# Eval("Id") %>' />
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








    <div class="modal fade" id="modal-atualizar-editora" tabindex="-1" aria-labelledby="modal-atualizar-editora-label" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title font-weight-bold h3" id="modal-atualizar-editora-label">Atualizar editora</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel runat="server" ID="UpdtPanelAtualizarEditora">
                        <ContentTemplate>
                            <div class="form-group">
                                <label for="TBNomeAtualizarEditora" class="col-form-label">Nome<i class="far fa-newspaper ml-2"></i></label>
                                <asp:TextBox runat="server" ID="TBNomeAtualizarEditora" TextMode="SingleLine" class="form-control rounded-0" placeholder="Nome da editora" />
                                <asp:RequiredFieldValidator runat="server"
                                    CssClass="text-danger text-center m-0"
                                    ControlToValidate="TBNomeAtualizarEditora"
                                    ErrorMessage="O Nome da editora é de preenchimento obrigatório!"
                                    SetFocusOnError="true"
                                    ValidationGroup="VGAtualizarEditora"
                                    Display="Dynamic" />
                            </div>
                            <asp:HiddenField runat="server" ID="HiddenFieldIdEditora" />
                            <asp:LinkButton runat="server"
                                ID="BtnAtualizarEditora"
                                CssClass="btn btn-block btn-primary"
                                ValidationGroup="VGAtualizarEditora"
                                OnClick="BtnAtualizarEditora_Click">
                        <i class="fas fa-book"></i>
                            Atualizar editora
                            </asp:LinkButton>

                            <asp:LinkButton runat="server"
                                ID="BtnEliminarEditora"
                                CssClass="btn btn-block btn-danger"
                                OnClick="BtnEliminarEditora_Click">
                        <i class="fas fa-trash"></i>
                            Eliminar editora
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

























    <div class="modal fade" id="modal-nova-editora" tabindex="-1" aria-labelledby="modal-nova-editora-label" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title font-weight-bold h3" id="modal-nova-editora-label">Adicionar nova editora</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel runat="server" ID="UpdtPanelInserirEditora">
                        <ContentTemplate>
                            <div class="form-group">
                                <label for="TBNomeAdicionarEditora" class="col-form-label">Nome<i class="far fa-newspaper ml-2"></i></label>
                                <asp:TextBox runat="server" ID="TBNomeAdicionarEditora" TextMode="SingleLine" class="form-control rounded-0" placeholder="Nome da editora" />
                                <asp:RequiredFieldValidator runat="server"
                                    CssClass="text-danger text-center m-0"
                                    ControlToValidate="TBNomeAdicionarEditora"
                                    ErrorMessage="O Nome da editora é de preenchimento obrigatório!"
                                    SetFocusOnError="true"
                                    ValidationGroup="VGAdicionarEditora"
                                    Display="Dynamic" />
                            </div>

                            <asp:LinkButton runat="server"
                                ID="BtnAdicionarEditora"
                                CssClass="btn btn-block btn-primary"
                                ValidationGroup="VGAdicionarEditora"
                                OnClick="BtnAdicionarEditora_Click">
                          <asp:UpdateProgress runat="server" AssociatedUpdatePanelID="UpdtPanelInserirEditora">
                                        <ProgressTemplate>
                                           <i class="fas fa-circle-notch fa-spin"></i>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                        <i class="fas fa-book"></i>
                            Adicionar editora
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
