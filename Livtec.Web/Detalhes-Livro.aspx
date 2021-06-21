<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="Detalhes-Livro.aspx.cs" Inherits="Livtec.Web.Detalhes_Livro" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="col-sm-12 col-md-12 col-lg-12 mt-5">
        <!-- product -->
        <div class="product-content product-wrap clearfix product-deatil">
            <div class="row">
                <div class="col-md-5 col-sm-12 col-xs-12">
                    <div class="product-image">
                        <div id="myCarousel-2" class="carousel slide">
                            <asp:Image runat="server" ID="ImagemCapaLivro" class="bd-placeholder-img card-img-top" alt="Capa livro (Imagem)" />
                        </div>
                    </div>
                </div>

                <div class="col-md-6 col-md-offset-1 col-sm-12 col-xs-12">
                    <h2 class="name">
                        <asp:Label runat="server" ID="LblNomeLivro" CssClass="d-block"></asp:Label>
                        <asp:Label runat="server" ID="LblEditoraLivro" CssClass="d-block"></asp:Label>
                        <asp:Label runat="server" ID="LblAnoEdicaoLivro" CssClass="d-block"></asp:Label>
                        <a href="javascript:void(0);">109 customer reviews</a>
                    </h2>
                    <hr />
                    <h3 class="price-container">
                        <asp:Label runat="server" ID="LblPrecoLivro"></asp:Label>
                    </h3>
                    <hr />
                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" id="sinopse-tab" data-toggle="tab" href="#sinopse" role="tab" aria-controls="sinopse" aria-selected="true">Sinopse</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="opinioes-tab" data-toggle="tab" href="#opinioes" role="tab" aria-controls="opinioes" aria-selected="false">Opiniões</a>
                        </li>
                    </ul>
                    <div class="tab-content" id="myTabContent">
                        <div class="tab-pane fade show active p-3" id="sinopse" role="tabpanel" aria-labelledby="sinopse-tab">
                            <asp:Label runat="server" ID="LblSinopseLivro"></asp:Label>
                        </div>
                        <div class="tab-pane fade" id="opinioes" role="tabpanel" aria-labelledby="opinioes-tab"></div>
                    </div>
                    <hr />
                    <div class="row">
                        <div class="col-sm-12 col-md-6 col-lg-6">
                            <asp:LinkButton runat="server" ID="LinkBtnAdicionarLivroAoCarrinho" class="btn btn-success btn-lg"
                            OnClick="LinkBtnAdicionarLivroAoCarrinho_Click">
                            <i class="fas fa-cart-plus fa-lg"></i>
                            Adicionar ao meu carrinho
                            </asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end product -->
    </div>


</asp:Content>
