<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="Meus-Dados.aspx.cs" Inherits="Livtec.Web.Meus_Dados" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    

      <div class="d-flex flex-column p-5 flex-wrap mt-5">

                <h3>Dados de início de sessão</h3>

                <div class="form-group">
                    <label for="TBEmailAlteracaoDados" class="col-form-label">Email</label>
                    <asp:TextBox runat="server" ID="TBEmailAlteracaoDados" TextMode="Email" class="form-control rounded-0" ReadOnly />
                </div>

                <div class="form-group">
                    <label for="TBPasswordAlteracaoDados" class="col-form-label">Password</label>
                    <input id="TBPasswordAlteracaoDados" type="password" value="******************************" class="form-control rounded-0" ReadOnly />
                    <button type="button" class="btn btn-dark btn-sm mt-2 float-right p-2" data-toggle="modal" data-target="#modal-alteracao-password">Alterar a minha password</button>
                </div>

                <h3>Dados pessoais</h3>
                <div class="form-group">
                    <label for="TBPrimeiroNomeAlteracaoDados" class="col-form-label">Primeiro Nome</label>
                    <asp:TextBox runat="server" ID="TBPrimeiroNomeAlteracaoDados" TextMode="SingleLine" class="form-control rounded-0" />
                </div>

                <div class="form-group">
                    <label for="TBPApelidoAlteracaoDados" class="col-form-label">Apelido</label>
                    <asp:TextBox runat="server" ID="TBPApelidoAlteracaoDados" TextMode="SingleLine" class="form-control rounded-0" />
                </div>



                <div class="form-group">
                    <label for="TBContactoTelefonicoAlteracaoDados" class="col-form-label">Contacto telefónico</label>
                    +351<asp:TextBox runat="server" ID="TBContactoTelefonicoAlteracaoDados" TextMode="Number" class="form-control rounded-0" />
                </div>

                <div class="form-group">
                    <label for="TBNIFAlteracaoDados" class="col-form-label">NIF</label>
                    <asp:TextBox runat="server" ID="TBNIFAlteracaoDados" TextMode="Number" class="form-control rounded-0" />
                </div>

                <h3>Morada de Entrega</h3>







                <div class="modal fade" id="modal-alteracao-password" tabindex="-1" aria-labelledby="modal-alteracao-password-label" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="modal-alteracao-password-label">Alteração de password</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <label for="TBPasswordAtualAlteracao" class="col-form-label">Password Atual</label>
                                    <asp:TextBox runat="server" ID="TBPasswordAtualAlteracao" TextMode="Password" class="form-control rounded-0" />
                                </div>

                                <div class="form-group">
                                    <label for="TBNovaPasswordAlteracao" class="col-form-label">Nova Password</label>
                                    <asp:TextBox runat="server" ID="TBNovaPasswordAlteracao" TextMode="Password" class="form-control rounded-0" />
                                </div>

                                <div class="form-group">
                                    <label for="TBNovaPasswordConfirmacaoAlteracao" class="col-form-label">Confirme a Nova Password</label>
                                    <asp:TextBox runat="server" ID="TBNovaPasswordConfirmacaoAlteracao" TextMode="Password" class="form-control rounded-0" />

                                </div>

                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
                            </div>
                        </div>
                    </div>
                </div>


   
</div>




</asp:Content>
