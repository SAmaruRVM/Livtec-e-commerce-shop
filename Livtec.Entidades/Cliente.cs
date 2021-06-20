namespace Livtec.Entidades
{
    public sealed class Cliente : Utilizador
    {
        public string PrimeiroNome { get; set; }
        public string Apelido { get; set; }
        public string NIF { get; set; }
        public string ContactoTelefonico { get; set; }
        public TipoCliente TipoCliente { get; set; }
    }
}
