using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SIMANET_W22R.GestionReportes
{
    public class ReporteBase : PaginaBase
    {
        public static string KEYQIDOBJETO = "IdObj";
        public static string KEYQNOMBREOBJETO = "NomObjeto";

        public static string KEYQIDTIPOCONTROL = "IdTipCtrl";
        public static string KEYQIDTIPOOBJETO = "IdTipoOBJ";

        public static string KEYQNOMBREMETODO = "NomMetodo";
        public static string KEYQNOMBREPARAM = "NomParam";
        public static string KEYQTIPOPARAM = "TipParam";


        public static string KEYQVARENTORNO = "VEntorno";

        public int IdObjeto { get { return Convert.ToInt32(Page.Request.Params[KEYQIDOBJETO]); } }
        public int IdTipoObjeto { get { return Convert.ToInt32(Page.Request.Params[KEYQIDTIPOOBJETO]); } }
        public string NombreObjeto { get { return Page.Request.Params[KEYQNOMBREOBJETO]; } }
        public int IdTipodeControl { get { return Convert.ToInt32(Page.Request.Params[KEYQIDTIPOCONTROL]); } }

        public string NombreParam { get { return Page.Request.Params[KEYQNOMBREPARAM]; } }
        public string TipoDatoParam { get { return Page.Request.Params[KEYQTIPOPARAM]; } }

        public string TipoVarEntorno { get { return Page.Request.Params[KEYQVARENTORNO]; } }

        protected override void OnPreRender(EventArgs e)
        {
            string DefEnum = @"<script>
                                    SIMA.Utilitario.Enumerados.TipoObjeto = {
                                                                               Navegador:'0'
                                                                                ,Carpeta:'1'
                                                                                ,Reporte:'2'
                                                                                ,Header:'3'
                                                                                ,Grupo:'4'
                                                                                ,Detalle:'5'
                                                                                ,Footer:'6'
                                                                                ,Campo:'7'
                                                                                ,Secciondeparametros:'8'
                                                                                ,parametros:'9'
                                                                            };
                            </script>
            ";
            Page.RegisterClientScriptBlock("EnumRPT", DefEnum);

            base.OnPreRender(e);
        }

    }
}