using DocumentFormat.OpenXml.Drawing.Diagrams;
using EasyControlWeb;
using NPOI.SS.UserModel;
using SIMANET_W22R.HelpDesk;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.General
{
    public partial class Iteroperabilidad : System.Web.UI.Page
    {
        const string KEYIDUSUARIO = "IdUsu";
        const string KEYNAMEUSUARIO = "UsuNa";
        int IdEstado = 0;
        string RESULTADO="";
        protected void Page_Load(object sender, EventArgs e)
        {
            HelpDeskBase oHelpDeskBase = new HelpDeskBase();
            Dictionary<string, string> oResultBE;
            string Mensaje = "";
            switch (Page.Request.Params[HelpDeskBase.KEYQIDPROCESO]) { 
                case "1":
                    IdEstado = Convert.ToInt32(Page.Request.Params[HelpDeskBase.KEYQIDESTADO]);
                    RESULTADO=(new HDProcesos()).ActualizarNroSolicitud(Page.Request.Params[HelpDeskBase.KEYIDREQUERIMIENTO], Page.Request.Params[HelpDeskBase.KEYTOKEN] , IdEstado, Convert.ToInt32(Page.Request.Params[KEYIDUSUARIO]), Page.Request.Params[KEYNAMEUSUARIO]);
                    oResultBE= EasyUtilitario.Helper.Data.SeriaizedDiccionario(RESULTADO);
                    switch (oResultBE["IdOut"]) {
                        case "-99":
                            Mensaje = "Solicitud se ha aprobado";
                            break;
                        case "-100":
                            Mensaje = "Solicitud se ha desaprobado";
                            break;
                        case "-101":
                            Mensaje = "Solicitud se encuentra aprobada";
                            break;
                        case "-102":
                            Mensaje = "Solicitud se encuentra desaprobada";
                            break;
                        default:
                            Mensaje = "Descartar enlace de solicitud enviado [TOKEN NO VALIDO]";
                            break;
                    }

                    Page.Controls.Add(new LiteralControl("<script>alert('" + Mensaje + "');window.open('', '_self', '');window.close();</script>"));
                    break;
                case "2":
                    IdEstado = Convert.ToInt32(Page.Request.Params[HelpDeskBase.KEYQIDESTADO]);
                    RESULTADO = (new HDProcesos()).AprobarDesaprobarSolicitudPorAprobador(Page.Request.Params[HelpDeskBase.KEYIDAPROBREQUERIMIENTO]
                                                                                        , Page.Request.Params[HelpDeskBase.KEYTOKEN]
                                                                                        , IdEstado
                                                                                        , Convert.ToInt32(Page.Request.Params[KEYIDUSUARIO])
                                                                                        , Page.Request.Params[KEYNAMEUSUARIO]);
                    oResultBE = EasyUtilitario.Helper.Data.SeriaizedDiccionario(RESULTADO);
                    switch (oResultBE["IdOut"])
                    {
                        case "-99":
                            Mensaje = "No es  posible aprobar o desaprobar el requerimiento, se encuentra en otra face de atención";
                            break;
                        case "99":
                            Mensaje = "El requerimiento  se aprobó en su totalidad";
                            break;
                        case "98":
                            Mensaje = "Por ahora el requerimiento esta parcialmente aprobado";
                            break;
                    }

                    Page.Controls.Add(new LiteralControl("<script>alert('" + Mensaje + "');window.open('', '_self', '');window.close();</script>"));

                    break;
            }
        }
    }
}