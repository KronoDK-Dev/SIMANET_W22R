using EasyControlWeb;
using EasyControlWeb.InterConeccion;
using EasyControlWeb.InterConecion;
using Microsoft.SqlServer.Server;
using SIMANET_W22R.GestiondeCalidad;
using SIMANET_W22R.GestionReportes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Net.Http.Headers;
using System.Runtime.Remoting.Contexts;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.General
{
    public partial class EasyDataInterConectPrc : PaginaBase
    {
        const string KEYQMETODOCONEXCION = "MtdCn";
        const string KEYQURL_WEB_SERVICE = "UrlWS";
        const string KEYQMETODO_WEB_SERVICE = "MtdWS";
        const string KEYQTIPO_RETORNO = "TipReturn";
        const string KEYQPARAMS = "ParamsSW";
        const string KEYQPARAMSTIPO = "ParamsSWTipo";


        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public override void ProcessRequest(HttpContext context)
        {
            DataTable dt;
            string PathLocal = context.Request.Params[KEYQMETODOCONEXCION];
            string strEntity = context.Request.Params[KEYQPARAMS];
            string strEntityTipo = context.Request.Params[KEYQPARAMSTIPO];
            string TipoObjReturn = context.Request.Params[KEYQTIPO_RETORNO];
            //Datos del webService y del metodo
            string sw = context.Request.Params[KEYQURL_WEB_SERVICE];
           /* int Existe = sw.ToUpper().LastIndexOf(".ASMX");
            if (Existe != -1) {
                //desemcritar
               // sw = EasyEncrypta.DesEncriptar(sw);
            }
            */
            string mtd = context.Request.Params[KEYQMETODO_WEB_SERVICE];

            Dictionary<string, string> oEntity = EasyUtilitario.Helper.Data.SeriaizedDiccionario(strEntity);
            Dictionary<string, string> oEntityTipos = EasyUtilitario.Helper.Data.SeriaizedDiccionario(strEntityTipo);

            object[] param = new object[oEntity.Count]; int i = 0;
            foreach (var item in oEntity)
            {
                string valor = item.Value.ToString().Replace('�', ',');
                switch (oEntityTipos[item.Key])
                {
                    case "String":
                        param[i] = valor;
                        break;
                    case "Int":
                        param[i] = Convert.ToInt32(valor);
                        break;
                    case "Double":
                        param[i] = Convert.ToDouble(valor);
                        break;                  
                }
                
                i++;
            }
            try
            {
                switch ((EasyDataInterConect.MetododeConexion)System.Enum.Parse(typeof(EasyDataInterConect.MetododeConexion), context.Request.Params[KEYQMETODOCONEXCION].ToString()))
                {
                    case EasyDataInterConect.MetododeConexion.WebServiceInterno:
                    case EasyDataInterConect.MetododeConexion.WebServiceExterno:
                      
                        EasyUtilitario.Helper.Pagina.DEBUG(mtd);

                        object objResult = EasyWebServieHelper.InvokeWebService2(sw, "", mtd, param);
                        switch (TipoObjReturn)
                        {
                            case "Table":
                                dt = (DataTable)objResult;
                                this.DataTableToXML(dt);
                                break;
                            case "DictionaryBE":
                                string DiccionaryBE = (string)objResult;
                                this.DiccionaryToEntityJS(DiccionaryBE);
                                break;
                            case "Entity":
                                this.EntityServerToEntityJS(objResult);
                                break;
                            case "NonQuery":
                                this.ResultNonQuery(objResult.ToString());
                                break;
                        }
                        break;
                }
            }
            catch (Exception ex) {
                this.ErrorToXML("0002", this.GetPageName(), ex);
                // 21.01.2026 capturamos el error:

                string msg = ex.ToString().Replace("'", "");
                context.Response.Clear();
                context.Response.Write($"console.error('Error en el metodo ProcessRequest del servidor: {msg}');");
                context.Response.End();

            }



            //Llamar a los webs Services

        }
    
    
    
    }
}