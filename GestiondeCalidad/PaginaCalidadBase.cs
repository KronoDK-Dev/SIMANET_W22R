using EasyControlWeb;
using EasyControlWeb.Form.Controls;
using SIMANET_W22R.Exceptiones;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;

namespace SIMANET_W22R.GestiondeCalidad
{
    public class PaginaCalidadBase : PaginaBase
    {


        string cmll = EasyUtilitario.Constantes.Caracteres.ComillaDoble;

        public int IdReporteInspeccion { get { return 8; } }

        public const string KEYIDPROYECTO = "IdPry";
        public const string KEYIDINSPECCION = "IdInspec";
        public const string KEYNROFICHATECNICA = "NroFTec";
        public const string KEYQIDPERSONAL = "IdPer";
        public const string KEYQIDETALLERPTARESPAREA = "IdDetRptResp";
        public const string KEYQNROSOLICITUDCORREO = "NsoLeMail";
        //
        public const string KEYQNOMACTIVIDAD = "NomAct";
        //Personal firmante

        public const string KEYQIDPERFIRMANTE = "IdPerFirm";
        public const string KEYQIDTIPOFIRMANTE = "IdTipoFirm";
        public const string KEYQIMGFIRM = "ImagenFirma";

        //Para la busqueda por proyecto
        public const string KEYQNOMBREPROY = "NombreProyecto";
        public const string KEYQIDINSPECTOR= "IdInspector";
        public const string KEYQIDINSPECTOR_PRINCIPAL = "Principal";

        public static string KEYQTALLE_CONTRATISTA = "TalleoContratista";

        public static string KEYQRI_BLOQUEDO = "RI_LOCK";


        public int InspectorPrincipal { get { return Convert.ToInt32(Page.Request.Params[KEYQIDINSPECTOR_PRINCIPAL]); } }

        public string IdInspector { get { return Page.Request.Params[KEYQIDINSPECTOR]; } }

        public int IdPersonal { get { return Convert.ToInt32(Page.Request.Params[KEYQIDPERSONAL]); } }

        public string IdProyecto
        {
            get { return Page.Request.Params[KEYIDPROYECTO]; }
        }
        public string IdInspeccion
        {
            get { return (((Page.Request.Params[KEYIDINSPECCION] == "") || (Page.Request.Params[KEYIDINSPECCION] == null)) ? "0" : Page.Request.Params[KEYIDINSPECCION]); }
        }
        public string NroFichaTecnica
        {
            get { return Page.Request.Params[KEYNROFICHATECNICA]; }
        }
        public string IdDetalleRepuestaResposableArea
        {
            get { return Page.Request.Params[KEYQIDETALLERPTARESPAREA]; }
        }
        public int IdPersonaFirmante {
            get { return Convert.ToInt32(Page.Request.Params[KEYQIDPERFIRMANTE]); }
        }
        public int IdTipoFirmante
        {
            get { return Convert.ToInt32(Page.Request.Params[KEYQIDTIPOFIRMANTE]); }
        }
        public string ImagenFirma
        {
            get { return Page.Request.Params[KEYQIMGFIRM]; }
        }

        //Para busqueda de proytecto
        public string NombreProyecto
        {
            get { return Page.Request.Params[KEYQNOMBREPROY]; }
        }

        //
        public string NombreActividad {
            get { return Page.Request.Params[KEYQNOMACTIVIDAD]; }
        }
        public string TalleroContratista
        {
            get { return Page.Request.Params[KEYQTALLE_CONTRATISTA]; }
        }

        public int RI_Bloqueado {
            get { return Convert.ToInt32(Page.Request.Params[KEYQRI_BLOQUEDO]); }
        }


        protected override void OnPreRender(EventArgs e)
        {
            this.ListarConstantesPropias();

            base.OnPreRender(e);
        }

        protected override void OnUnload(EventArgs e)
        {

        }

        public void ListarConstantesPropias()
        {
            string PathImgFirmas = EasyUtilitario.Helper.Configuracion.Leer("ConfigModCalidad", "CalidadHttpFirma");
            string Pagina = this.GetPageName();
            string FormCreateVar = @"<script>
                                        setTimeout(function(){
                                                    " + Pagina + @".PathImagenFirmas = '" + PathImgFirmas + @"';
                                                    SIMA.Utilitario.Constantes.ImgDataURL.IconEnEspera=" + cmll + EasyUtilitario.Constantes.ImgDataURL.IconEnEspera + cmll + @";
                                                }, 500);
                                    </script>";

            Page.RegisterClientScriptBlock(Pagina,  FormCreateVar );
        }
               
    }
}

   