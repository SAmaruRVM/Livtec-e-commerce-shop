using System.Configuration;
using System.IO;
using System.Reflection;

namespace Livtec.Logica.Helper
{
    public static class Helper
    {
        internal static string SmtpHost => ConfigurationManager.AppSettings["smtp-host"];
        internal static string SmtpEmail => ConfigurationManager.AppSettings["smtp-email"];
        internal static string SmtpPassword => ConfigurationManager.AppSettings["smtp-password"];
        internal static int SmtpPort => int.Parse(ConfigurationManager.AppSettings["smtp-port"]);

        public static string EncryptDecryptStringPassphrase => ConfigurationManager.AppSettings["encrypt-decrypt-passphrase"];
    }
}
