using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.Form.Base;
using EasyControlWeb.Form.Controls;
using EasyControlWeb.InterConeccion;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using static EasyControlWeb.EasyUtilitario.Enumerados;
using static EasyControlWeb.InterConeccion.EasyDataInterConect;

namespace SIMANET_W22R.GestionGobernanza.Indicadores
{
    public partial class AdministrarObjetivosAcciones : GobernanzaBase,IPaginaBase
    {
        EasyMessageBox oeasyMessageBox;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {

                if (!Page.IsPostBack)
                {
                    this.LlenarGrilla();
                }
            }
            catch (Exception ex)
            {
                StackTrace stack = new StackTrace();
                string NombreMetodo = stack.GetFrame(1).GetMethod().Name + "/" + stack.GetFrame(0).GetMethod().Name;

                this.LanzarException(NombreMetodo, ex);
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
            throw new NotImplementedException();
        }

        public void CargarModoNuevo()
        {
            throw new NotImplementedException();
        }

        public void CargarModoModificar()
        {
            throw new NotImplementedException();
        }

        public void LlenarGrilla()
        {
            this.EasyGridView1.DataInterconect = ListarObjetivos(80, 1);
            EasyGridView1.LoadData();
        }
        EasyDataInterConect ListarObjetivos(int IdTabla, int idItem)
        {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.ConfigPathSrvRemoto = "PathBaseWSCore";
            odi.MetodoConexion = MetododeConexion.WebServiceExterno;
            odi.UrlWebService = "GestionGobernanza/Indicadores.asmx";
            odi.Metodo = "ListarObjetivosoAcciones";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdTblObjetivo";
            oParam.Paramvalue = IdTabla.ToString();
            oParam.TipodeDato = TiposdeDatos.Int;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdObjetivo";
            oParam.Paramvalue = idItem.ToString();
            oParam.TipodeDato = TiposdeDatos.Int;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);


            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);
            return odi;
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

        protected void EasyGridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = (DataRowView)e.Row.DataItem;
                DataRow dr = drv.Row;
                
                e.Row.Cells[1].Controls.Add(this.NodoTree("EasyGridView1",dr,e.Row.RowIndex, 1, dr["IDITEM"].ToString(), "0", dr["CODIGO"].ToString(), true, "OnClickObjetivo"));
                e.Row.Cells[3].Text=dr["DESCRIPCION"].ToString();
            }
        }
    }
}