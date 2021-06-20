using System;
namespace Livtec.Entidades
{
    public sealed class Livro
    {
        public int Id { get; set; }

        public string Titulo { get; set; }

        public decimal Preco { get; set; }

        public int NumeroPaginas { get; set; }

        public string Sinopse { get; set; }

        public string ISBN { get; set; }

        public string Idioma { get; set; }

        public int AnoEdicao { get; set; }

        public TipoLivro TipoLivro { get; set; }

        public Editora Editora { get; set; }

        public byte[] Imagem { get; set; }

        public DateTime? DataCriacao { get; set; }
    }
}
