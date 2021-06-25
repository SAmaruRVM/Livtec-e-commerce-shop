namespace Livtec.Entidades
{
    public sealed class Morada
    {
        public int Id { get; set; }
        public string Rua { get; set; }
        public string CodigoPostal { get; set; }
        public string Cidade { get; set; }
        public string Fracao { get; set; }
        public string OutrosDetalhes { get; set; }
        public Utilizador Utilizador { get; set; }
    }

}