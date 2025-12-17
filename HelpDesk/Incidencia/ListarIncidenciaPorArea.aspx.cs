using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.HelpDesk.Incidencia
{
    public partial class ListarIncidenciaPorArea : HelpDeskBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                treeNavSrv.ID = "treeNavSrv_" + this.IdArea;
            }
            catch (Exception ex)
            {
            }
        }
    }
}