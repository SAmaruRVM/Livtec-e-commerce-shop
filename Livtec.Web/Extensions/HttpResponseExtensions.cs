
using System;
using System.Web;

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
    }
}