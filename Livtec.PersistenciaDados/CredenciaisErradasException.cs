using System;


namespace Livtec.PersistenciaDados
{
    public sealed class CredenciaisErradasException : Exception
    {
        public CredenciaisErradasException(string message) : base(message) {}
    }
}
