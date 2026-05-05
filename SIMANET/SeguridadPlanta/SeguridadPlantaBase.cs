using System;
using System.Collections.Generic;
using System.IO.Packaging;
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
        public static string KEYQIDENTIDAD = "IdEnty";

        public static string KEYQNROSALUD = "nSalud";
        public static string KEYQPENSION = "nPension";

        public static string KEYQIDROSALUD = "IdSalud";
        public static string KEYQIDPENSION = "IdPension";


        public static string KEYQIDSCTR = "idSctr";

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
        public string IdEntidad
        {
            get
            {
                return Page.Request.Params[KEYQIDENTIDAD].ToString();
            }
        }
        public string NroSalud
        {
            get
            {
                return Page.Request.Params[KEYQNROSALUD].ToString();
            }
        }
        public string NroPension
        {
            get
            {
                return Page.Request.Params[KEYQPENSION].ToString();
            }
        }


        public string IdSCTRSalud
        {
            get
            {
                return Page.Request.Params[KEYQIDROSALUD].ToString();
            }
        }
        public string IdSCTRPension
        {
            get
            {
                return Page.Request.Params[KEYQIDPENSION].ToString();
            }
        }


        public string IdSCTR
        {
            get
            {
                return Page.Request.Params[KEYQIDSCTR].ToString();
            }
        }


        
    }
}