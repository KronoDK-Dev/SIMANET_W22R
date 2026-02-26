using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestionReportes
{
    public partial class PortafolioPBI : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // URL de ejemplo: demo de Power BI
                //string reportUrl = "https://playground.powerbi.com/sampleReportEmbed";
                // string reportUrl = "http://spsrvpowerbi:771/POWERBI_SIMA/browse";
                string reportUrl = "https://spsrvpowerbi:444/POWERBI_SIMA/browse";

                // Construye el iframe dinámicamente
                string iframe = $@"<iframe class='report-frame'
                                         src='{reportUrl}'
                                         frameborder='0'
                                         allowFullScreen='true'
                                    style='width:100%;height:80vh;border:0;'
                                        >
                                   </iframe>";
                ltlIframe.Mode = LiteralMode.PassThrough;
                ltlIframe.Text = iframe;
            }
        }
    }
}