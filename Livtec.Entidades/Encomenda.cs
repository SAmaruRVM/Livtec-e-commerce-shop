using System;

namespace Livtec.Entidades
{
    public sealed class Encomenda
    {
        public int Id { get; set; }
        public DateTime DataCriacao { get; set; }
        public EstadoEncomenda EstadoEncomenda { get; set; }
        public Encomenda EncomendaObject { get; set; }
        public Cliente Cliente { get; set; }

    }
}
