using EasyControlWeb.Form.Controls;
using EasyControlWeb;

using System;
using System.Collections.Generic;
using System.Data;

using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.Exceptiones;
using EasyControlWeb.Filtro;
using EasyControlWeb.InterConeccion;


namespace SIMANET_W22R.HelpDesk.Sistemas
{
    public partial class ListadeAprobadores : HelpDeskBase, IPaginaBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                this.LlenarJScript();
            }
            catch (SIMAExceptionSeguridadAccesoForms ex)
            {
                this.LanzarException(ex);
            }
        }

        DataTable ListarAprobadores() {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/HelpDesk/Sistemas/GestionSistemas.asmx";
            odi.Metodo = "ActividadElementos_StakeHolder";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdActElemento";
            oParam.Paramvalue = this.IdActividad;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);


            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdTipoStakeHolder";
            oParam.Paramvalue = "2";
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            odi.UrlWebServicieParams.Add(oParam);


            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);

            return odi.GetDataTable();
        }

        EasyListView AprobadoresLst()
        {
            DataTable dt = ListarAprobadores();

            EasyListView oListViewInspect = new EasyListView();
            oListViewInspect.TipoItem = TipoItemView.ImagenCircular;
            oListViewInspect.DataComplete.Add("IdUsuario", this.UsuarioId.ToString());

            oListViewInspect.AlertTitulo = "";
            oListViewInspect.AlertMensaje = "";
            oListViewInspect.ID = "LsvUsuariosAprob";
            oListViewInspect.ClassName = "BaseItemSecond";
            oListViewInspect.Ancho = "100%";
            oListViewInspect.TextAlign = EasyUtilitario.Enumerados.Ubicacion.Izquierda;
            oListViewInspect.FncItemOnCLick = "Administrar.Aprobadores.onClick";

            foreach (DataRow drInspect in dt.Rows)
            {
                EasyListItem oEasyListItemInspect = new EasyListItem();
                oEasyListItemInspect = new EasyListItem();
                oEasyListItemInspect.Src = EasyUtilitario.Helper.Configuracion.PathFotos + drInspect["NroDocDni"].ToString() + ".jpg";
                oEasyListItemInspect.Text = drInspect["ApellidosyNombres"].ToString();
                Dictionary<string, string> dc = new Dictionary<string, string>();
                foreach(DataColumn dcol in drInspect.Table.Columns){
                    dc[dcol.ColumnName] = drInspect[dcol.ColumnName].ToString();
                }
                oEasyListItemInspect.DataComplete = dc;
                oListViewInspect.ListItems.Add(oEasyListItemInspect);
            }
            return oListViewInspect;
        }
        public void CargarModoModificar()
        {
            throw new NotImplementedException();
        }

        public void CargarModoNuevo()
        {
            throw new NotImplementedException();
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

        public void LlenarGrilla()
        {
            throw new NotImplementedException();
        }

        public void LlenarGrilla(string strFilter)
        {
            throw new NotImplementedException();
        }

        public void LlenarJScript()
        {
            UserAprobadores.Controls.Add(AprobadoresLst());
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
    }
}