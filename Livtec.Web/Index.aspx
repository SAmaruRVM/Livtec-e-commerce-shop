<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="Livtec.Web.Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Livtec</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="container-fluid py-5 mt-5 banner-livros">
        <div class="row text-center mb-5">
            <div class="col-lg-7 mx-auto">
                <h1 class="display-3 text-primary">Últimos livros adicionados</h1>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12 mx-auto">
                <ul class="list-group shadow">
                    <asp:Repeater runat="server" ID="RptrUltimosLivros">
                        <ItemTemplate>
                            <li class="list-group-item">
                                <div class="media align-items-lg-center flex-column flex-lg-row py-3">
                                    <div class="media-body order-2 order-lg-1">
                                        <h5 class="mt-0 font-weight-bold mb-2"><%# Eval("Titulo") %></h5>
                                        <p class="font-italic text-muted mb-0 small"><%# Eval("Sinopse") %></p>
                                    </div>
                                    <img class="ml-lg-5 order-1 order-lg-2" width="100" alt="Capa livro (Imagem)" <%# (Eval("Imagem") is null) ? "src='Recursos/Imagens/Imagem-Livro-Placeholder.png'" : $"src='data:image/png;base64,{Convert.ToBase64String((byte[])Eval("Imagem"))}'"%> />
                                </div>
                                <a class="btn btn-sm btn-primary btn-block p-2" href="Detalhes-Livro.aspx?titulo=<%# string.Join("-", Eval("Titulo").ToString().Split(' ')) %>&isbn=<%# Eval("ISBN") %>" target="_blank">
                                    <i class="fas fa-info-circle fa-lg"></i>
                                    Ver mais detalhes
                                </a>
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>
        </div>
    </div>

    <asp:UpdatePanel runat="server" ID="UpdtPanelAdicionarLivroAoCarrinho">
        <ContentTemplate>
            <div class="album py-5 bg-light">
                <div class="container">
                    <div class="ml-2 my-lg-0 my-3">
                        <asp:TextBox runat="server" ID="TBFiltarLivroPorIdOuISBN" TextMode="SingleLine" class="form-control mr-sm-2 my-2" placeholder="Filtrar livros" aria-label="Search" />
                        <asp:RequiredFieldValidator runat="server"
                            CssClass="text-danger text-center m-0"
                            ControlToValidate="TBFiltarLivroPorIdOuISBN"
                            ErrorMessage="O filtro de pesquisa é de preenchimento obrigatório!"
                            SetFocusOnError="true"
                            ValidationGroup="VGFiltrarLivrosPorIdOuISBN"
                            Display="Dynamic" />
                        <asp:Button runat="server" ID="BtnPesquisarTitulo" Text="Pesquisar por nome ou ISBN" class="btn btn-outline-success my-sm-0 my-3 float-right" ValidationGroup="VGFiltrarLivrosPorIdOuISBN" OnClick="BtnPesquisarTitulo_Click" />
                    </div>
                    <div class="row mt-5">
                        <asp:Repeater runat="server" ID="RptrLivros">
                            <ItemTemplate>
                                <div class="col-md-4">
                                    <div class="card mb-4 shadow-sm p-4">
                                        <small class="float-right text-info h4 font-weight-bold">
                                            <%# Eval("Preco") + "€" %>
                                        </small>
                                        <img class="bd-placeholder-img card-img-top" alt="Capa livro (Imagem)" <%# (Eval("Imagem") is null) ? "src='Recursos/Imagens/Imagem-Livro-Placeholder.png'" : $"src='data:image/png;base64,{Convert.ToBase64String((byte[])Eval("Imagem"))}'"%> />
                                        <h3 class="text-center text-success">
                                            <%# Eval("Titulo") %>
                                        </h3>
                                        <small class="text-center h6"><%# Eval("Editora.Nome") %></small>
                                        <hr />
                                        <p class="card-text text-center text-primary"><%# Eval("Sinopse") %></p>
                                        <div class="d-flex justify-content-center align-items-center">
                                            <div class="btn-group flex-column w-75">
                                                <asp:LinkButton runat="server" ID="LKBAdicionarLivroAoCarrinho"
                                                    class="btn btn-sm btn-info btn-block p-2"
                                                    OnCommand="LKBAdicionarLivroAoCarrinho_Command"
                                                    CommandArgument='<%# Eval("Id") %>'>
                                                <i class="fas fa-cart-plus fa-lg"></i>
                                                Adicionar ao meu carrinho
                                                </asp:LinkButton>
                                                <a class="btn btn-sm btn-primary btn-block p-2" href="Detalhes-Livro.aspx?titulo=<%# string.Join("-", Eval("Titulo").ToString().Split(' ')) %>&isbn=<%# Eval("ISBN") %>" target="_blank">
                                                    <i class="fas fa-info-circle fa-lg"></i>
                                                    Ver mais detalhes
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                    <asp:Repeater runat="server" ID="RptrPaginacaoBotoes">
                        <HeaderTemplate>
                            <ul class="pagination">
                                <li class="page-item disabled">
                                    <a class="page-link" href="#" tabindex="-1">Previous</a>
                                </li>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <!-- class active for the active button (page) of the pagination -->

                            <li class="page-item active">
                                <a class="page-link" href="#">2 <span class="sr-only">(current)</span></a>
                            </li>

                        </ItemTemplate>
                        <FooterTemplate>
                            <li class="page-item">
                                <a class="page-link" href="#">Next</a>
                            </li>
                            </ul>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
