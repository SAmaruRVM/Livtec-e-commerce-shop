using System.Configuration;

namespace Livtec.PersistenciaDados.Helpers
{
    public static class Helper
    {
        public static string ConnectionString
        {
            get
            {
                return ConfigurationManager.ConnectionStrings["SQL-SERVER.Livtec"].ConnectionString;
            }
        }
    }
}
