using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SIMANET_W22R.GestionComercial
{
    public class BaseComercial : PaginaBase
    {
        public string KEYQCENTROOPERATIVO { get; set; }
        public string KEYNROSOLICITUD { get; set; }

        public static string KEYLNNEGOCIO = "LnNeg";
        public static string KEYCLASETRAB = "ClaseT";
        public static string KEYSUBLNNEGOCIO = "SUBLnNeg";
        public string LineaNegocio { get { return Page.Request.Params[KEYLNNEGOCIO]; } }
        public string ClaseTrabajo { get { return Page.Request.Params[KEYCLASETRAB]; } }
    }
}