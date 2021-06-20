using Livtec.PersistenciaDados.Extensions;
using Livtec.PersistenciaDados;
using System;
using System.Data.SqlClient;
using System.Collections.Generic;
using Livtec.Entidades;

namespace Livtec.Logica
{
    public sealed class UserAutenticacao
    {

        public void AtivarContaUtilizador(string email) => new SqlCommand().ExecutarSPSemRetorno(StoredProcedure.UspAtivarContaUtilizador, new Dictionary<string, object>
        {
            ["@email"] = email
        });


        

        public Utilizador VerificarSeUserEstaLogado(Guid cookieAutenticacao)
        {
            if (cookieAutenticacao == Guid.Empty)
            {
                return null;
            }


            using (SqlDataReader sqlDataReader = new SqlCommand().ExecutarSpComRetorno(StoredProcedure.UspUtilizadorPorCookieAutenticacaoGuid, new Dictionary<string, object>
            {
                ["@cookieAutenticacao"] = cookieAutenticacao
            }))
            {
                if (sqlDataReader.Read())
                {
                    new SqlCommand().ExecutarSPSemRetorno(StoredProcedure.UspAtualizarCookieAutenticacao, new Dictionary<string, object>
                    {
                        ["@cookieGuid"] = cookieAutenticacao,
                        ["@email"] = sqlDataReader["Email"]
                    });

                    return new Utilizador
                    {
                        Id = int.Parse(sqlDataReader["Id"].ToString()),
                        DataCriacao = DateTime.Parse(sqlDataReader["DataCriacao"].ToString()),
                        DataUltimoLogin = DateTime.Today,
                        Email = sqlDataReader["Email"].ToString(),
                        EstaAtivo = bool.Parse(sqlDataReader["EstaAtivo"].ToString()),
                        TipoUtilizador = (TipoUtilizador)Enum.Parse(typeof(TipoUtilizador), sqlDataReader["TipoUtilizador"].ToString())
                    };
                }
            }
            return null;
        }

        public Utilizador AutenticarUtilizador(string email, string password, Guid cookieAutenticacao)
        {
            using (SqlDataReader sqlDataReader = new SqlCommand().ExecutarSpComRetorno(StoredProcedure.UspAutenticarUtilizador, new Dictionary<string, object>
            {
                ["@email"] = email
            }))
            {
                if (sqlDataReader.Read())
                {
                    if (BCrypt.Net.BCrypt.Verify(password, sqlDataReader["Password"].ToString()))
                    {
                        new SqlCommand().ExecutarSPSemRetorno(StoredProcedure.UspAtualizarCookieAutenticacao, new Dictionary<string, object>
                        {
                            ["@cookieGuid"] = cookieAutenticacao,
                            ["@email"] = sqlDataReader["Email"]
                        });

                        return new Utilizador
                        {
                            Id = int.Parse(sqlDataReader["Id"].ToString()),
                            DataCriacao = DateTime.Parse(sqlDataReader["DataCriacao"].ToString()),
                            DataUltimoLogin = DateTime.Today,
                            Email = sqlDataReader["Email"].ToString(),
                            EstaAtivo = bool.Parse(sqlDataReader["EstaAtivo"].ToString()),
                            TipoUtilizador = (TipoUtilizador)Enum.Parse(typeof(TipoUtilizador), sqlDataReader["TipoUtilizador"].ToString())
                        };
                    }
                }

                throw new CredenciaisErradasException("Email ou password incorreta.");

            }
        }
    }
}
