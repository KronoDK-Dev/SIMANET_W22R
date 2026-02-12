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


        public string IdProgramacion 
        {
            get { return Page.Request.Params[KEYQIDPROGRAMACION]; }
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