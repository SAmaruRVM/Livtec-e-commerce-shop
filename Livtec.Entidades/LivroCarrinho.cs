namespace Livtec.Entidades
{
    public sealed class LivroCarrinho
    {
        public Livro Livro { get; set; }
        public int Quantidade { get; set; }
        public decimal Total { get; set; }
    }
}
