using SIMANET_W22R.srvGestionCalidad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestiondeCalidad
{
    public partial class Interoperabilidad : System.Web.UI.Page
    {
        const string KEYQPRC_UPD_FIRMA = "1";

        string IdInspeccion { get { return Page.Request.Params["ID"].ToString(); }  }
        string TokenID { get { return Page.Request.Params["Token"].ToString(); } }
        string IdPersonal { get { return Page.Request.Params["idPer"].ToString(); } }

        string IdProceso { get { return Page.Request.Params["IDPrc"].ToString(); } }

        int IdEstado{ get { return Convert.ToInt32(Page.Request.Params["IdEst"].ToString()); } }

        


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (IdProceso == KEYQPRC_UPD_FIRMA)
                {
                    UsuarioFirmanteBE UsuarioFirmanteBE =new UsuarioFirmanteBE();
                    UsuarioFirmanteBE.IdInspeccion = IdInspeccion;
                    UsuarioFirmanteBE.IdPersonaFirmante= Convert.ToInt32(IdPersonal);
                    UsuarioFirmanteBE.Token = TokenID;
                    UsuarioFirmanteBE.UpDateEmail =1;
                    UsuarioFirmanteBE.IdTipoPlazo = 0;
                    UsuarioFirmanteBE.TiempoPlazo = 0;
                    UsuarioFirmanteBE.IdEstado = this.IdEstado;
                    (new ControlInspeccionesSoapClient()).FirmaAprobarFromEMail(UsuarioFirmanteBE);
                }
            }
        }
    }
}