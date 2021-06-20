<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="Livtec.Web.Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Livtec</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-5 mt-5">
        <div class="row text-center mb-5">
            <div class="col-lg-7 mx-auto">
                <h1 class="display-4">Últimos livros adicionados</h1>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12 mx-auto">
                <ul class="list-group shadow">
                    <asp:Repeater runat="server" ID="RptrUltimosProdutos">
                        <ItemTemplate>
                            <li class="list-group-item">
                                <div class="media align-items-lg-center flex-column flex-lg-row p-3">
                                    <div class="media-body order-2 order-lg-1">
                                        <h5 class="mt-0 font-weight-bold mb-2">Awesome product</h5>
                                        <p class="font-italic text-muted mb-0 small">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Suscipit fuga autem maiores necessitatibus.</p>
                                        <div class="d-flex align-items-center justify-content-between mt-1">
                                            <h6 class="font-weight-bold my-2">$120.00</h6>
                                            <ul class="list-inline small">
                                                <li class="list-inline-item m-0"><i class="fa fa-star text-success"></i></li>
                                                <li class="list-inline-item m-0"><i class="fa fa-star text-success"></i></li>
                                                <li class="list-inline-item m-0"><i class="fa fa-star text-success"></i></li>
                                                <li class="list-inline-item m-0"><i class="fa fa-star text-success"></i></li>
                                                <li class="list-inline-item m-0"><i class="fa fa-star-o text-gray"></i></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <img src="https://res.cloudinary.com/mhmd/image/upload/v1556485076/shoes-1_gthops.jpg" alt="Generic placeholder image" width="200" class="ml-lg-5 order-1 order-lg-2">
                                </div>
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>
        </div>
    </div>

    <div class="album py-5 bg-light">
        <div class="container">
            <div class="row">
                <asp:Repeater runat="server" ID="RptrProdutos">
                    <ItemTemplate>
                        <div class="col-md-4">
                            <div class="card mb-4 shadow-sm">
                                <svg class="bd-placeholder-img card-img-top" width="100%" height="225" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img" aria-label="Placeholder: Thumbnail">
                                    <title>Placeholder</title>
                                    <rect width="100%" height="100%" fill="#55595c" />
                                    <text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text></svg>
                                <div class="card-body">
                                    <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-sm btn-outline-secondary">Adicionar ao carr</button>
                                        </div>
                                        <small class="text-muted">9 mins</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
</asp:Content>
