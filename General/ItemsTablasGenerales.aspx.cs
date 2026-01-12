using EasyControlWeb;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.srvGeneral;
using SIMANET_W22R.srvGestionCalidad;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.General
{
   
    public partial class ItemsTablasGenerales : PaginaBase
    {
        const int KEYPRC_LST_ITEMS = 1;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                switch (this.IdProceso)
                {
                    case KEYPRC_LST_ITEMS:
                        this.DataTableToXML((new GeneralSoapClient()).ListarItemTablas(this.IdTablaGeneral, this.UsuarioLogin));
                        break;
                }
            }
            catch (Exception ex)
            {
                SIMAExceptionSeguridadAccesoForms oex = new SIMAExceptionSeguridadAccesoForms(ex.Message);
                //EasyUtilitario.Helper.Data.Error(this.GetPageName(), ex.Message);
                this.LanzarException(oex);
            }
        }
    }
}