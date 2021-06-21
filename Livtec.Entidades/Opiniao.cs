using System;

namespace Livtec.Entidades
{
    public sealed class Opiniao
    {
        public int Id { get; set; }
        public string OpiniaoTexto { get; set; }
        public Utilizador Utilizador { get; set; }
        public Livro Livro { get; set; }
        public DateTime DataCriacao { get; set; }
    }
}
