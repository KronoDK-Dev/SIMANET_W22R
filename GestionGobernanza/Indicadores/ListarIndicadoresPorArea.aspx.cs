using EasyControlWeb;
using EasyControlWeb.Filtro;
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
    public partial class ListarIndicadoresPorArea : GobernanzaBase, IPaginaBase
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                this.LlenarCombos();
                this.LlenarGrilla();
                this.LlenarDatos(); 
            }
            catch (Exception ex)
            {
                StackTrace stack = new StackTrace();
                string NombreMetodo = stack.GetFrame(1).GetMethod().Name + "/" + stack.GetFrame(0).GetMethod().Name;

                this.LanzarException(NombreMetodo, ex);
            }
        }

        public DataTable LstIndicadoresPorArea(int Tipo,string pCodArea,string pCodEmp,string pCodSuc)
        {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.ConfigPathSrvRemoto = "PathBaseWSCore";
            odi.MetodoConexion = MetododeConexion.WebServiceExterno;
            odi.UrlWebService = "GestionGobernanza/Indicadores.asmx";
            odi.Metodo = "ListarIndicadoresPorArea";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "CodArea";
            oParam.Paramvalue = pCodArea;
            oParam.TipodeDato = TiposdeDatos.String;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "CodEmp";
            oParam.Paramvalue = pCodEmp;
            oParam.TipodeDato = TiposdeDatos.String;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "CodSuc";
            oParam.Paramvalue = pCodSuc;
            oParam.TipodeDato = TiposdeDatos.String;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);


            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);
            DataTable dtR = odi.GetDataTable();
            dtR.Columns.Add(new DataColumn("TIPO"));

            foreach (DataRow row in dtR.Rows)
            {
                row["TIPO"] = Tipo.ToString();
            }
            dtR.AcceptChanges();
            dtR.TableName = "Table";
            return dtR;
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
            this.ddlPeriodo.DataInterconect.UrlWebService = this.PathNetCore + "/General/General.asmx";
            this.ddlPeriodo.LoadData();
            this.ddlPeriodo.ID="ddl_" + this.CodArea;
        }

        public void LlenarDatos()
        {
            //Establece los nombres de controles segun area
            LsIndicadores.ID = "LstInd_" + this.CodArea;
            DetIndicador.ID = "DetInd_" + this.CodArea;
            //Listar Responsables por area
            lstReponsable.Controls.Add(ListarResponsables());

        }

        EasyListView ListarResponsables() {
            EasyListView oListViewResponsable= new EasyListView();
            oListViewResponsable.TipoItem = TipoItemView.ImagenCircular;
            oListViewResponsable.DataComplete.Add("IdUsuario", this.UsuarioId.ToString());
            oListViewResponsable.DataComplete.Add("UserName", this.UsuarioLogin);
            oListViewResponsable.DataComplete.Add("Principal", "0");
            //oListViewInspect.DataComplete.Add("IdInspector", );

            oListViewResponsable.AlertTitulo = "RESPONSABLES DE AREA";
            oListViewResponsable.AlertMensaje = "Desea eliminar este registro ahora";
            oListViewResponsable.ID = "LsvResponsable";
            oListViewResponsable.ClassName = "BaseItemSecond";
            oListViewResponsable.Ancho = "100%";
          
            oListViewResponsable.FncItemOnMouseMove = "ListViewResponsable_ItemMouseMove";
            oListViewResponsable.TextAlign = EasyUtilitario.Enumerados.Ubicacion.Izquierda;


            foreach (DataRow dr in (new ListaReponsablePorArea()).ListarResponsable(this.CodArea).GetDataTable().Rows)
            {
                EasyListItem oEasyListItemR = new EasyListItem();
                oEasyListItemR = new EasyListItem();
                oEasyListItemR.Src = EasyUtilitario.Helper.Configuracion.PathFotos + dr["NRODNI"].ToString() + ".jpg";
                oEasyListItemR.Value = dr["IdUsuario"].ToString();
                oEasyListItemR.Text = dr["apellidosyNombres"].ToString();
                Dictionary<string, string> dc = new Dictionary<string, string>();
                dc.Add("IdItem", dr["IDITEM"].ToString());
                oEasyListItemR.DataComplete = dc;
                oListViewResponsable.ListItems.Add(oEasyListItemR);
            }
            return oListViewResponsable;
        }

        public void LlenarGrilla()
        {
            DataTable  dtIndicadores = LstIndicadoresPorArea(1, this.CodArea,this.CodEmpresa,this.CodSucursal);
            string[] FieldGroup = { "IDTBLOBJETIVO", "IDOBJETIVO","CODIGOOBJETIVO", "NOMBREOBJETIVO","TIPO" };
            DataTable dtObjetivo =  EasyUtilitario.Helper.Data.GroupBy(dtIndicadores, FieldGroup, null);

            dtObjetivo.DefaultView.Sort = "CODIGOOBJETIVO asc";
            dtObjetivo = dtObjetivo.DefaultView.ToTable(true);

            EasyDGIndicadores.DataSource = dtObjetivo;
            EasyDGIndicadores.DataBind();
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

        protected void EasyDGIndicadores_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = (DataRowView)e.Row.DataItem;
                DataRow dr = drv.Row;

                e.Row.Cells[1].Controls.Add(this.NodoTree("EasyDGIndicadores", dr, e.Row.RowIndex, 1, dr["IDTBLOBJETIVO"].ToString() +"-"+ dr["IDOBJETIVO"].ToString(), "0", dr["CODIGOOBJETIVO"].ToString(), true, "OnClickObjetivo"));
               // e.Row.Cells[3].Text = dr["NOMBREOBJETIVO"].ToString();

            }
        }
    }
}