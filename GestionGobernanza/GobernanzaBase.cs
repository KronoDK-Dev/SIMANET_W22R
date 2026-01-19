using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SIMANET_W22R.GestionGobernanza
{

    public class GobernanzaBase:PaginaBase
    {
        public static string KEYOBJETIVOVERSION = "IdVer";
        public string IdVersion { get { return Page.Request.Params[KEYOBJETIVOVERSION]; } }

        public static string KEYIDAREAINFO = "IdAreaInf";
        public string IdAreaInfo { get { return Page.Request.Params[KEYIDAREAINFO]; } }

        public static string KEYIDTIPOPLAZO = "IdTipPlazo";
        public string IdTipoPlazo { get { return Page.Request.Params[KEYIDTIPOPLAZO]; } }

        public static string KEYIDINDICADOR = "IdIndica";
        public string IdIndicador { get { return Page.Request.Params[KEYIDINDICADOR]; } }
    }
} 