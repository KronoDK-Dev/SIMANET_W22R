using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Caching;
using System.Web;

namespace SIMANET_W22R
{
    public static class memoriacache
    {

        /// <summary>
        /// Construye una clave de caché consistente para IdUsuario/UserName.
        /// Normaliza: Id 123 por defecto, user "invitado" por defecto, trim y uppercase.
        /// </summary>



        private const string PendingParamsKey = "CentrosPerfil:PendingParams";

        public sealed class UserParams
        {
            public string IdUsuario { get; set; }
            public string UserName { get; set; }
        }

        /// Normaliza id/user y retorna (id,user) normalizados.
        public static (string id, string user) Normalizar(string idUsuario, string userName)
        {
            string id = "123";
            if (!string.IsNullOrWhiteSpace(idUsuario) && int.TryParse(idUsuario, out var parsed) && parsed > 0)
                id = parsed.ToString();

            string user = string.IsNullOrWhiteSpace(userName) ? "invitado" : userName.Trim();
            return (id, user);
        }

        /// Guarda ambos parámetros en MemoryCache (no se guarda DataTable).
        public static void Guarda2params(string idUsuario, string userName, int minutos = 30)
        {
            var (id, user) = Normalizar(idUsuario, userName);

            var cache = MemoryCache.Default;
            var existing = cache.Get(PendingParamsKey) as UserParams;

            // Si ya están guardados EXACTAMENTE iguales, no hacer nada
            if (existing != null &&
                existing.IdUsuario == id &&
                existing.UserName == user)
            {
                return; // ← evita sobreescritura
            }

            var policy = new CacheItemPolicy
            {
                AbsoluteExpiration = DateTimeOffset.Now.AddMinutes(minutos)
            };


            cache.Set(PendingParamsKey, new UserParams { IdUsuario = id, UserName = user }, policy);
        }

        /// Intenta leer los parámetros guardados. Devuelve null si no hay.
        public static UserParams ObtieneParams()
        {
            var cache = MemoryCache.Default;
            return cache.Get(PendingParamsKey) as UserParams;
        }

        /// Limpia los parámetros pendientes si quieres invalidar.
        public static void LimpiaParams()
        {
            MemoryCache.Default.Remove(PendingParamsKey);
        }


    }
}