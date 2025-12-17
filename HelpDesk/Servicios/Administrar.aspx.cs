using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SIMANET_W22R.Controles;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.GestionReportes;

namespace SIMANET_W22R.HelpDesk.Servicios
{
    public partial class Administrar : HelpDeskBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                Header.RegistrarLibs(Page.Header, Header.TipoLib.Style,(new AdministrarReporte()).StyleBase,true);
                Header.RegistrarLibs(Page.Header, Header.TipoLib.Script, (new AdministrarReporte()).ScriptBase, true);
            }
            catch (SIMAExceptionSeguridadAccesoForms ex)
            {
                this.LanzarException(ex);
            }
        }
    }
}