using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.General
{
    public partial class UpLoadMaster : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public override void ProcessRequest(HttpContext context)
        {
            EasyControlWeb.EasyUtilitario.Helper.Genericos.UploadProcessRequest(context);
        }
    }
}