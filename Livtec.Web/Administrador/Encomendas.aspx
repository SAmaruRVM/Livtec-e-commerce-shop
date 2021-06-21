<%@ Page Title="" Language="C#" MasterPageFile="~/Administrador/Admin.Master" AutoEventWireup="true" CodeBehind="Encomendas.aspx.cs" Inherits="Livtec.Web.Administrador.Encomendas" EnableEventValidation="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
            <title>Livtec Encomendas - Administração</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <asp:ScriptManager runat="server"></asp:ScriptManager>
    <asp:UpdatePanel runat="server" ID="UpdtPanelEliminarAtualizarEncomenda">
        <ContentTemplate>
            <div class="container col-lg-12 mt-2 flex-column d-flex">
                <div class="card mb-4 mt-2 shadow-lg">
                    <div class="card-header bg-dark text-center text-light">
                        <i class="fas fa-pen-alt"></i>
                        Encomendas
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
                                                    
                                                    CommandArgument='<%# Eval("Id") + ";" + Eval("Nome") %>' />
                                                <asp:Button runat="server" ID="BtnEliminarEditora" Text="Eliminar" CssClass="btn btn-danger"
                                                     CommandArgument='<%# Eval("Id") %>' />
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








    <div class="modal fade" id="modal-atualizar-encomenda" tabindex="-1" aria-labelledby="modal-atualizar-encomenda-label" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title font-weight-bold h3" id="modal-atualizar-encomenda-label">Atualizar encomenda</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel runat="server" ID="UpdtPanelAtualizarEncomenda">
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
                                >
                        <i class="fas fa-book"></i>
                            Atualizar editora
                            </asp:LinkButton>

                            <asp:LinkButton runat="server"
                                ID="BtnEliminarEditora"
                                CssClass="btn btn-block btn-danger"
                                >
                        <i class="fas fa-trash"></i>
                            Eliminar encomenda
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
