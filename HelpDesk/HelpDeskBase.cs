using EasyControlWeb;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SIMANET_W22R.HelpDesk
{
    public class HelpDeskBase:PaginaBase
    {
        string cmll = EasyUtilitario.Constantes.Caracteres.ComillaDoble;

        public const string KEYIDSYS_PRC = "IdSys";
        public const string KEYIDSERVICIO = "IdSrv";
        public const string KEYNOMBRESERVICIO = "NomSrv";
        public const string KEYPATHSERVICIO = "PathSrv";

        public const string KEYIDACTIVIDAD = "IdAct";
        public const string KEYIDACCCION = "IdAcc";
        public const string KEYIDNOTA = "IdNota";
        public const string KEYIDACTPARAMINOUT = "PInOut";
        public const string KEYIDCONTACTO = "IdContact";
        public const string KEYNOMCONTACTO = "NContact";
        public const string KEYFOTOGRUPO = "FotoGRP";

        public const string KEYIDAREA = "IdArea";
      

        public const string KEYIDPADRE = "IdPadre";

        public const string KEYIDTIPOELEMENTO = "IdTelem";
        public const string KEYNOMBREELEMENTO = "NomTelem";

        public const string KEYIDACTELEMENTO = "IdActElem";

        //
        public const string KEYIDTIPOSTAKEHOLDER = "IdTipoSH";
        public const string KEYIDNOMBRESTAKEHOLDER = "NomTSH";

        public const string KEYIDTAKEHOLDER = "IdSH";
        //Control de cambios Tipo de Documentacion
        public const string KEYIDTIPODOCUM = "IdTipoDoc";
        public const string KEYIDPERSONAL = "IdPer";
        public const string KEYIDPERSONALRQR = "IdPerRqr";

        public const string KEYIDTABDEFAULT = "IdTabDef";

        //Requerimientos
        public const string KEYIDREQUERIMIENTO = "IdRqr";
        public const string KEYIDREQUERIMIENTOPADRE = "IdRqrP";
        public const string KEYIDUSUARIOREQ = "IdUsuReq";
        public const string KEYIDAPROBREQUERIMIENTO = "IdAproRqr";
        //Avance
        public const string KEYAVANCE = "Ava";

        public string IdRequerimiento
        {
            get { return ( (Page.Request.Params[KEYIDREQUERIMIENTO]==null)?"0": Page.Request.Params[KEYIDREQUERIMIENTO]); }
        }
        public string IdRequerimientPadre
        {
            get { return ((Page.Request.Params[KEYIDREQUERIMIENTOPADRE] == null) ? "0" : Page.Request.Params[KEYIDREQUERIMIENTOPADRE]); }
        }
        public string IdUsuarioRequerimiento
        {
            get { return ((Page.Request.Params[KEYIDUSUARIOREQ] == null) ? "0" : Page.Request.Params[KEYIDUSUARIOREQ]); }
        }
        public string IdAprobadorRequerimiento
        {
            get { return ((Page.Request.Params[KEYIDAPROBREQUERIMIENTO] == null) ? "0" : Page.Request.Params[KEYIDAPROBREQUERIMIENTO]); }
        }
        public string Avance
        {
            get { return ((Page.Request.Params[KEYAVANCE] == null) ? "0" : Page.Request.Params[KEYAVANCE]); }
        }



        //Resposable de atencion
        public const string KEYIDRESPONSABLEATE = "IdResAt";
        public string IdResponsableAtencion
        {
            get { return ((Page.Request.Params[KEYIDRESPONSABLEATE] == null) ? "0" : Page.Request.Params[KEYIDRESPONSABLEATE]); }
        }

        //Item de la tarea que pertenece a la actividad
        public const string KEYIDACTIVIDADTAREA = "IdActTask";
        public string IdActividadTarea
        {
            get { return ((Page.Request.Params[KEYIDACTIVIDADTAREA] == null) ? "0" : Page.Request.Params[KEYIDACTIVIDADTAREA]); }
        }
        //Nombre de la tarea que pertenece a la actividad
        public const string KEYNOMBRETAREA = "NTask";
        public string NombreTarea
        {
            get { return ((Page.Request.Params[KEYNOMBRETAREA] == null) ? "0" : Page.Request.Params[KEYNOMBRETAREA]); }
        }

        public const string KEYDECRIPCIONTAREA = "DTask";
        public string DescripcionTarea
        {
            get { return ((Page.Request.Params[KEYDECRIPCIONTAREA] == null) ? "0" : Page.Request.Params[KEYDECRIPCIONTAREA]); }
        }
        public const string KEYIDTASKITEMHISTORY = "DTaskHis";
        public string IdTaskItemHistory
        {
            get { return ((Page.Request.Params[KEYIDTASKITEMHISTORY] == null) ? "0" : Page.Request.Params[KEYIDTASKITEMHISTORY]); }
        }
        public const string KEYIDTASKPARTICIPA = "DTaskPart";
        public string IdTaskParticipante
        {
            get { return ((Page.Request.Params[KEYIDTASKPARTICIPA] == null) ? "0" : Page.Request.Params[KEYIDTASKPARTICIPA]); }
        }
        public const string KEYIDITEMACTCRONOGRAMA = "IdActCrono";
        public string IdActividadCronograma
        {
            get { return ((Page.Request.Params[KEYIDITEMACTCRONOGRAMA] == null) ? "0" : Page.Request.Params[KEYIDITEMACTCRONOGRAMA]); }
        }

        public const string KEYIDTASKITEMCRONOGRAMA = "IdTaskItmCro";
        public string IdTareaItemCronograma
        {
            get { return ((Page.Request.Params[KEYIDTASKITEMCRONOGRAMA] == null) ? "0" : Page.Request.Params[KEYIDTASKITEMCRONOGRAMA]); }
        }

        public const string KEYIDSERVICIOAREA = "IdSrvA";
        public string IdServicioArea
        {
            get { return ((Page.Request.Params[KEYIDSERVICIOAREA] == null) ? "0" : Page.Request.Params[KEYIDSERVICIOAREA]); }
        }

        public const string KEYIDPLANTRABAJO = "IdPlan";
        public string IdPlandeTrabajo
        {
            get { return ((Page.Request.Params[KEYIDPLANTRABAJO] == null) ? "0" : Page.Request.Params[KEYIDPLANTRABAJO]); }
        }



        public string IdSistemaProcesoAct {
            get { return Page.Request.Params[KEYIDSYS_PRC].ToString(); }
        }
        public string  IdServicio { get { return Page.Request.Params[KEYIDSERVICIO]; } }
        public string NombreServicio { get { return Page.Request.Params[KEYNOMBRESERVICIO]; } }

        public string PathServicio { get { return Page.Request.Params[KEYPATHSERVICIO]; } }

        public string IdContacto
        {
            get { return Page.Request.Params[KEYIDCONTACTO].ToString(); }
        }
        public string IdArea
        {
            get { return Page.Request.Params[KEYIDAREA].ToString(); }
        }

   

        public string IdActividad { get { return Page.Request.Params[KEYIDACTIVIDAD]; } }
        public string IdAccion{ get { return Page.Request.Params[KEYIDACCCION]; } }
        public string IdNota { get { return Page.Request.Params[KEYIDNOTA]; } }
        

        public string IdTipoElemento { get { return Page.Request.Params[KEYIDTIPOELEMENTO]; } }
        public string NombreElemento { get { return Page.Request.Params[KEYNOMBREELEMENTO]; } }

        public string IdActividadElemento { get { return Page.Request.Params[KEYIDACTELEMENTO]; } }

        public string IdTipoStakeHolder { get { return Page.Request.Params[KEYIDTIPOSTAKEHOLDER]; } }

        public string IdStakeHolder { get { return Page.Request.Params[KEYIDTAKEHOLDER]; } }

        public string IdTipoDocumentacion { get { return Page.Request.Params[KEYIDTIPODOCUM]; } }

        public string RutaHTTPFirmas { get { return EasyUtilitario.Helper.Configuracion.Leer("ConfigModSistemas", "SysHttpFirma"); } }


        public string IdTabDefault { get { return Page.Request.Params[KEYIDTABDEFAULT]; } }

        public string IdPersonal { get { return Page.Request.Params[KEYIDPERSONAL]; } }

        public string IdPersonalRequerimiento { get { return Page.Request.Params[KEYIDPERSONALRQR]; } }

        



        protected override void OnPreRender(EventArgs e)
        {
            string DefEnum = @"<script>
                                    SIMA.Utilitario.Enumerados.TipoSrv = {
                                                                               Servcio:'0'
                                                                                ,Producto:'1'
                                                                            };
                            </script>
            ";
            Page.RegisterClientScriptBlock("EnumRPT", DefEnum);

            this.ListarConstantesPropias();
            base.OnPreRender(e);
        }

        public void ListarConstantesPropias()
        {
            string PathImgFirmas = this.RutaHTTPFirmas.ToString();
            string Pagina = this.GetPageName();
            string FormCreateVar = @"<script>
                                        setTimeout(function(){
                                                    " + Pagina + @".PathImagenFirmas = '" + PathImgFirmas + @"';
                                                    SIMA.Utilitario.Constantes.ImgDataURL.IconEnEspera=" + cmll + EasyUtilitario.Constantes.ImgDataURL.IconEnEspera + cmll + @";
                                                }, 500);
                                    </script>";

            Page.RegisterClientScriptBlock(Pagina, FormCreateVar);
        }

    }
}