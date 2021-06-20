using System;
using System.Web;
using System.Web.SessionState;

namespace Livtec.Web.Extensions
{
    public static class HttpResponseExtensions
    {
        public static void RemoverCookie(this HttpResponse @this, string nomeCookie) 
        {
            @this.Cookies.Remove(nomeCookie);
            @this.Cookies.Add(new HttpCookie(nomeCookie)
            {
                Expires = DateTime.Today.AddDays(-1)
            });
        }

        public static void RedirecionarComSession(this HttpResponse @this, HttpSessionState sessionObject, string nomeSession, object valorSession, string nomePaginaSemExtensao) 
        {    
            sessionObject[nomeSession] = valorSession;
            @this.Redirect($"{nomePaginaSemExtensao}.aspx");
        }


        public static void StatusCode(this HttpResponse @this, int statusCode) 
        {
            @this.Clear();
            @this.StatusCode = statusCode;
            @this.End();
        }
    }
}