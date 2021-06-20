using System.Configuration;

namespace Livtec.PersistenciaDados.Helpers
{
    public static class Helper
    {
        public static string ConnectionString => ConfigurationManager.ConnectionStrings["SQL-SERVER.Livtec"].ConnectionString;
    }
}

