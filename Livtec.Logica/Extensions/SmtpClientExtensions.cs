using System.Configuration;
using System.Net;
using System.Net.Mail;

namespace Livtec.Logica.Extensions
{
    public static class SmtpClientExtensions
    {
        public static void EnviarEmail(this SmtpClient @this, string destinatario, string titulo, string conteudo, bool contemHTML = true)
        {
            var mailMessage = new MailMessage()
            {
                Subject = titulo,
                Body = conteudo,
                IsBodyHtml = contemHTML,
                From = new MailAddress(Helper.Helper.SmtpEmail)
            };
            mailMessage.To.Add(new MailAddress(destinatario));

            @this.Credentials = new NetworkCredential(Helper.Helper.SmtpEmail, Helper.Helper.SmtpPassword);
            @this.EnableSsl = true;
            @this.Host = Helper.Helper.SmtpHost;
            @this.Port = Helper.Helper.SmtpPort;
            @this.Send(mailMessage);
        }
    }
}
