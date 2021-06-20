using System;

namespace Livtec.Entidades
{
    public sealed class Carrinho
    {
        public Guid Id { get; set; }
        public Cliente Cliente { get; set; }
        public DateTime DataCriacao { get; set; }
    }
}
