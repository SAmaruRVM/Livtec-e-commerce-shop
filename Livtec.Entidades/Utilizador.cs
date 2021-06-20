using System;

namespace Livtec.Entidades
{
    public sealed class Utilizador
    {
        public int Id { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public bool EstaAtivo { get; set; }
        public DateTime DataCriacao { get; set; }
        public DateTime DataUltimoLogin { get; set; }
        public TipoUtilizador TipoUtilizador { get; set; }
    }
}
