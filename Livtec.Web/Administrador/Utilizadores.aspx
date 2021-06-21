<%@ Page Title="" Language="C#" MasterPageFile="~/Administrador/Admin.Master" AutoEventWireup="true" CodeBehind="Utilizadores.aspx.cs" Inherits="Livtec.Web.Administrador.Utilizadores" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
       <title>Livtec Utilizadores - Administração</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager runat="server"></asp:ScriptManager>
    <asp:UpdatePanel runat="server" ID="UpdtPanelUtilizadores">
        <ContentTemplate>
            <div class="container col-lg-12 mt-2 flex-column d-flex">
                <div class="card mb-4 mt-2 shadow-lg">
                    <div class="card-header bg-dark text-center text-light">
                        <i class="fas fa-pen-alt"></i>
                        Utilizadores
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th style="text-align: center; vertical-align: middle;">Email</th>
                                        <th style="text-align: center; vertical-align: middle;">Está ativo</th>
                                        <th style="text-align: center; vertical-align: middle;">Data criação</th>
                                        <th style="text-align: center; vertical-align: middle;">Data Ultimo Login</th>
                                        <th style="text-align: center; vertical-align: middle;">Ações</th>
                                    </tr>
                                </thead>
                                <asp:Repeater runat="server" ID="RptrUtilizadoresTable">
                                    <HeaderTemplate>
                                        <tbody class="text-center text-md-center">
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td style="text-align: center; vertical-align: middle;">
                                                <%# Eval("Email") %>
                                            </td>
                                            <td style="text-align: center; vertical-align: middle;">
                                                <%# Eval("EstaAtivo") %>
                                            </td>
                                            <td style="text-align: center; vertical-align: middle;">
                                                <%# Eval("DataCriacao") %>
                                            </td>
                                            <td style="text-align: center; vertical-align: middle;">
                                                <%# ((DateTime)Eval("DataUltimoLogin")) != DateTime.MinValue ? Eval("DataUltimoLogin") : "User ainda não se logou pela primeira vez" %>
                                            </td>
                                            <td style="text-align: center; vertical-align: middle;">
                                                <asp:LinkButton runat="server"
                                                    ID="BtnEnviarEmailConfirmacaoUtilizador"
                                                    CssClass="btn btn-danger"
                                                    OnCommand="BtnEnviarEmailConfirmacaoUtilizador_Command"
                                                    CommandArgument='<%# $"{Eval("Email")};{Eval("EstaAtivo")}" %>'>
                                    <asp:UpdateProgress runat="server" AssociatedUpdatePanelID="UpdtPanelUtilizadores">
                                        <ProgressTemplate>
                                           <i class="fas fa-circle-notch fa-spin"></i>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                               Reenviar email de confirmação
                                                </asp:LinkButton>
                                            </td>
                                            <td style="text-align: center; vertical-align: middle;">
                                                <asp:Button runat="server" ID="BtnEliminarEditora" Text="Eliminar" CssClass="btn btn-danger"
                                                    OnCommand="BtnEliminarUtilizador_Command" CommandArgument='<%# Eval("Id") %>' />
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



</asp:Content>
