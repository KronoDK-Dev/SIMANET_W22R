using EasyControlWeb;
using EasyControlWeb.InterConeccion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.HelpDesk.ChatBot
{
    /*REFERENCIA : https://fhumanes.com/blog/gestor-de-proyectos/gestion-de-un-chat/*/
    public partial class EasyNetLiveChat : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.EasyAcFindContacto.DataInterconect.UrlWebService = EasyUtilitario.Helper.Configuracion.Leer(EasyUtilitario.Enumerados.Configuracion.SeccionKey.Nombre.ConfigBase, "PathBaseWSCore") + "HelpDesk/ChatBot/IChatBotManager.asmx";
        }
    }
}