using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.Form.Base;
using EasyControlWeb.Form.Controls;
using EasyControlWeb.InterConeccion;
using SIMANET_W22R.HelpDesk.BandejaEntrada;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.HelpDesk.Sistemas
{
    public partial class HelpDeskListarAtenciones : HelpDeskBase, IPaginaBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                this.LlenarGrilla();
            }
            catch (Exception ex)
            {
            }
        }
        public void ConfigurarAccesoControles()
        {
            throw new NotImplementedException();
        }

        public void Exportar()
        {
            throw new NotImplementedException();
        }

        public void Imprimir()
        {
            throw new NotImplementedException();
        }

        public void LlenarCombos()
        {
            throw new NotImplementedException();
        }

        public void LlenarDatos()
        {
          
        }

        public void LlenarGrilla()
        {

            this.EasyGridrqr .DataInterconect = ObtenerDatos();
            this.EasyGridrqr.LoadData();
        }

        EasyDataInterConect ObtenerDatos()
        {
            EasyDataInterConect odic = new EasyDataInterConect();
            odic.ConfigPathSrvRemoto = "PathBaseWSCore";
            odic.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odic.UrlWebService = "/HelpDesk/AdministrarHD.asmx";
            odic.Metodo = "ListaRequerimientoPorAcvtividad";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdActividad";
            oParam.Paramvalue = this.IdActividad;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odic.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdServicio";
            oParam.Paramvalue = this.IdServicio;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odic.UrlWebServicieParams.Add(oParam);
            

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin.ToString();
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odic.UrlWebServicieParams.Add(oParam);
            return odic;
        }


        public void LlenarGrilla(string strFilter)
        {
            throw new NotImplementedException();
        }

        public void LlenarJScript()
        {
            throw new NotImplementedException();
        }

        public void RegistrarJScript()
        {
            throw new NotImplementedException();
        }

        public bool ValidarDatos()
        {
            throw new NotImplementedException();
        }

        public bool ValidarFiltros()
        {
            throw new NotImplementedException();
        }

        protected void EasyGridrqr_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = (DataRowView)e.Row.DataItem;
                DataRow dr = drv.Row;
                e.Row.Cells[2].Controls.Add((new AdministrarAtencion()).HTMLSolicitante(dr));
                e.Row.Cells[4].Controls.Add((new AdministrarAtencion()).ControlPath(dr["PATHSERVICE"].ToString()));

               /* EasyProgressbarBase oEasyProgressBar = new EasyProgressbarBase();
                oEasyProgressBar.Progreso = Convert.ToInt32(dr["PORCAVANCE"].ToString());
                e.Row.Cells[7].Controls.Add(oEasyProgressBar);*/
                //Buscar Codigo de Personal que registro el requerimiento



            }
        }
    }
}