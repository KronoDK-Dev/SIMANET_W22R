using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.Form.Controls;
using EasyControlWeb.InterConeccion;
using EasyControlWeb.InterConecion;
using SIMANET_W22R.Controles;
using SIMANET_W22R.GestiondeCalidad;
using SIMANET_W22R.HelpDesk.Requerimiento;
using SIMANET_W22R.srvGestionCalidad;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO.Packaging;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SIMANET_W22R.HelpDesk
{
    /// <summary>
    /// Descripción breve de HDProcesos
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class HDProcesos : System.Web.Services.WebService
    {
        string btnAprobado = "data:image/gif;base64,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";
        string btnDesaprobado = "data:image/gif;base64,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";
        #region Solicita Aprobacion del servicio brindado

        [System.Web.Services.WebMethod]
        public string EnviaEmailAprobarServicio(string NroDocDNISolicitante,string ApellidosyNombresSolicitante,int IdUsuarioRQR, string IdRequerimiento,string PathApp,int IdUsuario,string UserName)
        {
            Guid gToken = Guid.NewGuid();//Identificador unico que servira para relacionar la fila de la grilla con sus data en script
            string sToken = gToken.ToString();
            //string PathApp
            //EasyUtilitario.Helper.Pagina.PathSite() 
            string PageParamsAprob = PathApp+ "/General/Iteroperabilidad.aspx?" + HelpDeskBase.KEYQIDPROCESO  +"=1&"+ HelpDeskBase.KEYIDREQUERIMIENTO + "=" + IdRequerimiento + "&" + PaginaBase.KEYTOKEN + "=" + sToken + "&" + HelpDeskBase.KEYQIDESTADO + "=9&IdUsu=" + IdUsuarioRQR.ToString() + "&UsuNa=" + UserName;
            string PageParamsDesAprob = PathApp + "/General/Iteroperabilidad.aspx?" + HelpDeskBase.KEYQIDPROCESO + "=1&" + HelpDeskBase.KEYIDREQUERIMIENTO + "=" + IdRequerimiento + "&" + PaginaBase.KEYTOKEN + "=" + sToken + "&" + HelpDeskBase.KEYQIDESTADO + "=10&IdUsu=" + IdUsuarioRQR.ToString() + "&UsuNa=" + UserName;
            string cmll = EasyUtilitario.Constantes.Caracteres.ComillaDoble;
            string HTML_APROBADO = "<a href=" + cmll + PageParamsAprob  + cmll + "> <img src=" + cmll + btnAprobado + cmll + " width=" + cmll + "62px" + cmll + "height =" + cmll + "91px" + cmll + "></a>";
            string HTML_DESAAPROBADO = "<a href=" + cmll + PageParamsDesAprob + cmll + "> <img src=" + cmll + btnDesaprobado + cmll + " width=" + cmll + "74px" + cmll + "height =" + cmll + "91px" + cmll + "></a>";


            
            string UrlFoto = EasyUtilitario.Helper.Configuracion.Leer("ConfigBase", "PathFotos");
            string ImgFoto = EasyUtilitario.Helper.Archivo.UrlImagen.DownloadToUrlData(new Uri(UrlFoto + NroDocDNISolicitante + ".jpg"));

            string PathFileMod = EasyUtilitario.Helper.Configuracion.Leer("ConfigModHelpDesk", "HelpDeskLocalFiles") + "Plantillas\\FrmSolocitaAprobacion.aspx";
            string BodyEmail = EasyUtilitario.Helper.Archivo.Leer(PathFileMod);

            EasyBaseEntityBE oEasyBaseEntityBE = (new DetalleRequerimiento()).CargarDetalle(IdUsuarioRQR.ToString(), IdRequerimiento);

            string htmlCell = @"<td  width='45px' height='35px' style='border-bottom:solid; border-top:solid;border-color:#dadada;border-width:1px;'>
                                    <img width='45px' height='35px' src='" + EasyUtilitario.Constantes.ImgDataURL.Path0.ToString() + @"'/>
                              </td>";
            //Crear el path service para el correo
            string[] PathItem = oEasyBaseEntityBE.GetValue("PathServicio").ToString().Split('|');
            List<string> list = PathItem.ToList();
            list.Reverse();
            int i = 0;
            foreach (string str in list)
            {
                if (i == PathItem.Length-1)
                {
                    htmlCell += " <td nowrap='true' style='border-bottom:solid; border-top:solid;border-color:#dadada;border-width:1px;font-size:12px;color:navy;font-size:9px;color:navy'>" + str + "</td>";
                    htmlCell += @" <td width='15px'><img width='45px' src='" + EasyUtilitario.Constantes.ImgDataURL.Path3.ToString()  + "'/> </td>";
                }
                else {
                    htmlCell += " <td nowrap='true' style='border-bottom:solid; border-top:solid;border-color:#dadada;border-width:1px; font-size:12px;color:navy;font-size:9px;color:navy'>" + str + "</td>";
                    htmlCell += " <td width='15px' style='border-bottom:solid; border-top:solid;border-color:#dadada;border-width:1px;' ><img width='15px' src='" + EasyUtilitario.Constantes.ImgDataURL.Path2.ToString() + "'/> </td>";

                }
                i++;
            }
            string htmlPath = "<table><tr>" + htmlCell + "</tr></table>";




            string LstEmailAprobadores = "";
            int p = 0;
            foreach (DataRow drApr in (new DetalleRequerimiento()).ListarAprobadores(IdRequerimiento, UserName).Rows) {
                LstEmailAprobadores += ((p==0)?"":",") + drApr["PTRMAILCOR"].ToString();
                p++;
            }
            BodyEmail = BodyEmail.Replace("[IMG]", ImgFoto)
                                  .Replace("[QUIENENVIA]", ApellidosyNombresSolicitante)
                                  .Replace("[TICKET]", oEasyBaseEntityBE.GetValue("NroTicket"))
                                  .Replace("[PATHSERVICIO]", htmlPath)
                                  .Replace("[FECHA]", oEasyBaseEntityBE.GetValue("Fecha").Substring(0,10))
                                  .Replace("[DESCRIPCION]", oEasyBaseEntityBE.GetValue("Descripcion"))
                                  .Replace("[APROB]", HTML_APROBADO)
                                  .Replace("[DESAPROB]", HTML_DESAAPROBADO)
                                  .Replace("[PATHAPP]", "");
            string email = oEasyBaseEntityBE.GetValue("Email");
            // Mail oMail = new Mail(UserName.ToLower() + "@sima.com.pe", "erosales@sima.com.pe", BodyEmail, "Solicito aprobación de Servicio brindado", null);
             Mail oMail = new Mail(oEasyBaseEntityBE.GetValue("Email"), LstEmailAprobadores, BodyEmail, "Solicito aprobación de Servicio brindado", null);
            //Mail oMail = new Mail("erosales@sima.com.pe", "erosales@sima.com.pe", BodyEmail, "Solicito aprobación de Servicio brindado", null);
            MailResult oMailResult = oMail.enviaMail();

            //Actualizar Nro de Envios de solicitud de aprobaciones
          

            return ActualizarNroSolicitud(IdRequerimiento, sToken,0, IdUsuario, UserName); 
        }

       public  string ActualizarNroSolicitud(string _IdRequerimiento,string _Token,int _IdEstado,int _IdUsuario,string _UserName) {
            EasyDataInterConect odic = new EasyDataInterConect();
            odic.ConfigPathSrvRemoto = "PathBaseWSCore";
            odic.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odic.UrlWebService = "/HelpDesk/AdministrarHD.asmx";
            odic.Metodo = "SolicitarAprobaciondeAtencionxServ";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdRequerimiento";
            oParam.Paramvalue = _IdRequerimiento;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odic.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "Token";
            oParam.Paramvalue = _Token;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odic.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdEstado";
            oParam.Paramvalue = _IdEstado.ToString();
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            odic.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdUsuario";
            oParam.Paramvalue = _IdUsuario.ToString();
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            odic.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = _UserName;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odic.UrlWebServicieParams.Add(oParam);
            return odic.SendData();
        }


        #endregion
        string  HtmlPathService(EasyBaseEntityBE oEasyBaseEntityBE)
        {
            string htmlCell = @"<td  width='45px' height='35px' style='border-bottom:solid; border-top:solid;border-color:#dadada;border-width:1px;'>
                                    <img width='45px' height='35px' src='" + EasyUtilitario.Constantes.ImgDataURL.Path0.ToString() + @"'/>
                              </td>";
            //Crear el path service para el correo
            string[] PathItem = oEasyBaseEntityBE.GetValue("PathServicio").ToString().Split('|');
            List<string> list = PathItem.ToList();
            list.Reverse();
            int i = 0;
            foreach (string str in list)
            {
                if (i == PathItem.Length - 1)
                {
                    htmlCell += " <td nowrap='true' style='border-bottom:solid; border-top:solid;border-color:#dadada;border-width:1px;font-size:12px;color:navy;font-size:9px;color:navy'>" + str + "</td>";
                    htmlCell += @" <td width='15px'><img width='45px' src='" + EasyUtilitario.Constantes.ImgDataURL.Path3.ToString() + "'/> </td>";
                }
                else
                {
                    htmlCell += " <td nowrap='true' style='border-bottom:solid; border-top:solid;border-color:#dadada;border-width:1px; font-size:12px;color:navy;font-size:9px;color:navy'>" + str + "</td>";
                    htmlCell += " <td width='15px' style='border-bottom:solid; border-top:solid;border-color:#dadada;border-width:1px;' ><img width='15px' src='" + EasyUtilitario.Constantes.ImgDataURL.Path2.ToString() + "'/> </td>";

                }
                i++;
            }

            return "<table><tr>" + htmlCell + "</tr></table>";
        }



        [System.Web.Services.WebMethod]
        public string EnviaEmailAprobarRequerimiento(string NroDocDNISolicitante, string ApellidosyNombresSolicitante, int IdUsuarioRQR, string IdRequerimiento, string PathApp,string IdUsuAprobadorRqr,  string EmailAprobador,string UserName)
        {
            Guid gToken = Guid.NewGuid();//Identificador unico que servira para relacionar la fila de la grilla con sus data en script
            string sToken = gToken.ToString();
            //string PathApp
            //EasyUtilitario.Helper.Pagina.PathSite() 
            string PageParamsAprob = PathApp + "/General/Iteroperabilidad.aspx?" + HelpDeskBase.KEYQIDPROCESO + "=2&" + HelpDeskBase.KEYIDAPROBREQUERIMIENTO + "=" + IdUsuAprobadorRqr + "&" + PaginaBase.KEYTOKEN + "=" + sToken + "&" + HelpDeskBase.KEYQIDESTADO + "=1&IdUsu=" + IdUsuarioRQR.ToString() + "&UsuNa=" + UserName;
            string PageParamsDesAprob = PathApp + "/General/Iteroperabilidad.aspx?" + HelpDeskBase.KEYQIDPROCESO + "=2&" + HelpDeskBase.KEYIDAPROBREQUERIMIENTO + "=" + IdUsuAprobadorRqr + "&" + PaginaBase.KEYTOKEN + "=" + sToken + "&" + HelpDeskBase.KEYQIDESTADO + "=00&IdUsu=" + IdUsuarioRQR.ToString() + "&UsuNa=" + UserName;
            string cmll = EasyUtilitario.Constantes.Caracteres.ComillaDoble;
            string HTML_APROBADO = "<a href=" + cmll + PageParamsAprob + cmll + "> <img src=" + cmll + btnAprobado + cmll + " width=" + cmll + "62px" + cmll + "height =" + cmll + "91px" + cmll + "></a>";
            string HTML_DESAAPROBADO = "<a href=" + cmll + PageParamsDesAprob + cmll + "> <img src=" + cmll + btnDesaprobado + cmll + " width=" + cmll + "74px" + cmll + "height =" + cmll + "91px" + cmll + "></a>";



            string UrlFoto = EasyUtilitario.Helper.Configuracion.Leer("ConfigBase", "PathFotos");
            string ImgFoto = EasyUtilitario.Helper.Archivo.UrlImagen.DownloadToUrlData(new Uri(UrlFoto + NroDocDNISolicitante + ".jpg"));

            string PathFileMod = EasyUtilitario.Helper.Configuracion.Leer("ConfigModHelpDesk", "HelpDeskLocalFiles") + "Plantillas\\FrmSolocitaAprobacionRQR.aspx";
            string BodyEmail = EasyUtilitario.Helper.Archivo.Leer(PathFileMod);

            EasyBaseEntityBE oEasyBaseEntityBE = (new DetalleRequerimiento()).CargarDetalle(IdUsuarioRQR.ToString(), IdRequerimiento);


            BodyEmail = BodyEmail.Replace("[IMG]", ImgFoto)
                                  .Replace("[QUIENENVIA]", ApellidosyNombresSolicitante)
                                  .Replace("[TICKET]", oEasyBaseEntityBE.GetValue("NroTicket"))
                                  .Replace("[PATHSERVICIO]", HtmlPathService(oEasyBaseEntityBE))
                                  .Replace("[FECHA]", oEasyBaseEntityBE.GetValue("Fecha").Substring(0, 10))
                                  .Replace("[DESCRIPCION]", oEasyBaseEntityBE.GetValue("Descripcion"))
                                  .Replace("[APROB]", HTML_APROBADO)
                                  .Replace("[DESAPROB]", HTML_DESAAPROBADO)
                                  .Replace("[PATHAPP]", "");
            string EmailSolicitante = oEasyBaseEntityBE.GetValue("Email");
            //Mail oMail = new Mail(EmailSolicitante, EmailAprobador, BodyEmail, "Solicito aprobación de Requerimiento Generado", null);
            Mail oMail = new Mail("erosales@sima.com.pe", "erosales@sima.com.pe", BodyEmail, "Solicito aprobación de Requerimiento Generado", null);
            MailResult oMailResult = oMail.enviaMail();
            //Actualizar Nro de Envios de solicitud de aprobaciones
            return ActualizarNroSolicitudPorAprobdor(IdUsuAprobadorRqr, sToken, 0, IdUsuarioRQR, UserName);
        }



        public string ActualizarNroSolicitudPorAprobdor(string _IdResponsableAprobacion, string _Token, int _IdEstado, int _IdUsuario, string _UserName)
        {
            EasyDataInterConect odic = new EasyDataInterConect();
            odic.ConfigPathSrvRemoto = "PathBaseWSCore";
            odic.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odic.UrlWebService = "/HelpDesk/AdministrarHD.asmx";
            odic.Metodo = "SolicitarAprobaciondeRequerimiento";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdResponsableAprobRqr";
            oParam.Paramvalue = _IdResponsableAprobacion;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odic.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "Token";
            oParam.Paramvalue = _Token;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odic.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdUsuario";
            oParam.Paramvalue = _IdUsuario.ToString();
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            odic.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = _UserName;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odic.UrlWebServicieParams.Add(oParam);
            return odic.SendData();
        }


        public string AprobarDesaprobarSolicitudPorAprobador(string _IdResponsableAprobacion, string _Token, int _IdEstado, int _IdUsuario, string _UserName)
        {
            EasyDataInterConect odic = new EasyDataInterConect();
            odic.ConfigPathSrvRemoto = "PathBaseWSCore";
            odic.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odic.UrlWebService = "/HelpDesk/AdministrarHD.asmx";
            odic.Metodo = "ApruebaRequerimientoPorAprobador";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdResponsableAprobRqr";
            oParam.Paramvalue = _IdResponsableAprobacion;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odic.UrlWebServicieParams.Add(oParam);


            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "Aprobado";
            oParam.Paramvalue = _IdEstado.ToString();
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            odic.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "Token";
            oParam.Paramvalue = _Token;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odic.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdUsuario";
            oParam.Paramvalue = _IdUsuario.ToString();
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            odic.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = _UserName;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odic.UrlWebServicieParams.Add(oParam);
            return odic.SendData();
        }

    }
}
