using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SIMANET_W22R.SIMANET.SeguridadPlanta
{
    public class SeguridadPlantaBase:PaginaBase
    {
        public static string KEYQIDPROGRAMACION = "IdProg";
        public static string KEYQLSTDNI = "LstDNI";
        public static string KEYQNROITEM = "NItem";
        public static string KEYQIDEQUIPO = "IdeQ";
        public static string KEYQNRODOC = "NDoc";
        public static string KEYQNOMBRES = "Nom";

        public string IdProgramacion 
        {
            get { return Page.Request.Params[KEYQIDPROGRAMACION]; }
        }
        public string NroDocumento
        {
            get { return Page.Request.Params[KEYQNRODOC]; }
        }
        public string Nombres
        {
            get { return Page.Request.Params[KEYQNOMBRES]; }
        }
        public string IdEquipo
        {
            get { return Page.Request.Params[KEYQIDEQUIPO]; }
        }
        public string[] LstNroDNI
        {
            get
            {
                if (Page.Request.Params[KEYQLSTDNI] != null)
                {
                    return Page.Request.Params[KEYQLSTDNI].ToString().Split('@');
                }
                else
                {
                    return null;
                }
            }
        }

    }
}