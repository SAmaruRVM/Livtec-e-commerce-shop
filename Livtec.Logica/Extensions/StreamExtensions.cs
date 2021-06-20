using System.IO;

namespace Livtec.Logica.Extensions
{
    public static class StreamExtensions
    {
        public static byte[] ToByteArray(this Stream @this) 
        {
            var bytes = new byte[@this.Length];
            using (@this)
            {
                @this.Read(bytes, 0, bytes.Length);
            }
            return bytes;
        }
    }
}
