using EasyControlWeb;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestionReportes
{
    public partial class RptPrevioInPopup : ReporteBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LlenarJScript();
        }

      
        public void LlenarJScript()
        {
            string qPath = Page.Request.Params["rptNamePath"].ToString();
            string PathRpt = qPath.Replace("@",EasyUtilitario.Constantes.Caracteres.BackSlash.ToString()).Replace("|",":");
            RptPrevio.Src = PathRpt;
        }

       
    }
}