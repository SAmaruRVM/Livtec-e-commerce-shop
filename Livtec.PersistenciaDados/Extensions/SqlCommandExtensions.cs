using Livtec.PersistenciaDados.Helpers;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace Livtec.PersistenciaDados.Extensions
{
    internal static class SqlCommandExtensions
    {
        internal static void ExecutarComandoSQLComRetorno(this SqlCommand @this, string comandoSQL, Dictionary<string, object> storedProcedureParametros = null)
        {
            using (var sqlConnection = new SqlConnection(Helper.ConnectionString))
            {
                using (@this)
                {
                    @this.Connection = sqlConnection;
                    @this.CommandText = comandoSQL;
                    @this.CommandType = CommandType.StoredProcedure;

                    if (storedProcedureParametros != null)
                    {
                        foreach (KeyValuePair<string, object> storedProcedureParametro in storedProcedureParametros)
                        {
                            @this.Parameters.AddWithValue(storedProcedureParametro.Key, storedProcedureParametro.Value);
                        }
                    }

                    sqlConnection.Open();
                    return @this.ExecuteReader(CommandBehavior.CloseConnection);
                }
            }
        }

        internal static void ExecutarComandoSQLSemRetorno(this SqlCommand @this, string comandoSQL, Dictionary<string, object> storedProcedureParametros = null)
        {
            using (var sqlConnection = new SqlConnection(Helper.ConnectionString))
            {
                using (@this)
                {
                    @this.Connection = sqlConnection;
                    @this.CommandText = comandoSQL;
                    @this.CommandType = CommandType.Text;

                    if (storedProcedureParametros != null)
                    {
                        foreach (KeyValuePair<string, object> storedProcedureParametro in storedProcedureParametros)
                        {
                            @this.Parameters.AddWithValue(storedProcedureParametro.Key, storedProcedureParametro.Value);
                        }
                    }

                    sqlConnection.Open();
                    @this.ExecuteNonQuery();
                }
            }
        }

        internal static void ExecutarSPSemRetorno(this SqlCommand @this, StoredProcedure storedProcedureAExecutar, Dictionary<string, object> storedProcedureParametros = null)
        {
            using (var sqlConnection = new SqlConnection(Helper.ConnectionString))
            {
                using (@this)
                {
                    @this.Connection = sqlConnection;
                    @this.CommandText = storedProcedureAExecutar.ToString();
                    @this.CommandType = CommandType.StoredProcedure;

                    if (storedProcedureParametros != null)
                    {
                        foreach (KeyValuePair<string, object> storedProcedureParametro in storedProcedureParametros)
                        {
                            @this.Parameters.AddWithValue(storedProcedureParametro.Key, storedProcedureParametro.Value);
                        }
                    }

                    sqlConnection.Open();
                    @this.ExecuteNonQuery();
                }
            }
        }
        internal static SqlDataReader ExecutarSpComRetorno(this SqlCommand @this, StoredProcedure storedProcedureAExecutar, Dictionary<string, object> storedProcedureParametros = null)
        {
            var sqlConnection = new SqlConnection(Helper.ConnectionString);
            
                using (@this)
                {
                    @this.Connection = sqlConnection;
                    @this.CommandText = storedProcedureAExecutar.ToString();
                    @this.CommandType = CommandType.StoredProcedure;

                    if (storedProcedureParametros != null)
                    {
                        foreach (KeyValuePair<string, object> storedProcedureParametro in storedProcedureParametros)
                        {
                            @this.Parameters.AddWithValue(storedProcedureParametro.Key, storedProcedureParametro.Value);
                        }
                    }

                    sqlConnection.Open();
                    return @this.ExecuteReader(CommandBehavior.CloseConnection);
                }
            }
        }

}
