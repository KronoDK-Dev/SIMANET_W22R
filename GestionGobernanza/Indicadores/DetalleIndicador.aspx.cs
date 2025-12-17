using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.Form.Controls;
using EasyControlWeb.InterConeccion;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestionGobernanza.Indicadores
{
    public partial class DetalleIndicador : GobernanzaBase,IPaginaMantenimento
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                this.LlenarCombos();
                this.CargarModoPagina();
            }
            catch (Exception ex)
            {
                int i = 0;
            }
        }

        public void Agregar()
        {
            throw new NotImplementedException();
        }

        public void CargarModoConsulta()
        {
            throw new NotImplementedException();
        }

        public void CargarModoModificar()
        {
            foreach (DataRow dr in (new DetalleObjetivo()).ListarTodos(this.IdTablaGeneralRel, this.IdTablaGeneralItemsRel, this.UsuarioLogin).Rows)
            {
                if ((dr["IDTBL"].ToString() == this.IdTablaGeneral) 
                    && (dr["IDITEM"].ToString() == this.IdTablaGeneralItems)
                    && (dr["VAL4"].ToString() == "4")
                    )
                {
                    this.SetData(dr);
                    this.txtCodigo.SetValue(dr["CODIGO"].ToString());
                    this.txtNombre.SetValue(dr["NOMBRE"].ToString());
                    this.txtDescripcion.SetValue(dr["DESCRIPCION"].ToString());
                   // this.txtMeta.SetValue(dr["VAL5"].ToString());


               
                   

                }
            }
        }

        DataTable ListaResponsables()
        {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/GestionGobernanza/Indicadores.asmx";
            odi.Metodo = "ListarAccioneResponsableTodos";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdTblObjetivo";
            oParam.Paramvalue = this.IdTablaGeneral;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdObjetivo";
            oParam.Paramvalue = this.IdTablaGeneralItems;
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

        public void LlenarCombos() {
            DataTable dtR = ListaResponsables();
            foreach (DataRow dr in dtR.Rows)
            {
                string Item = EasyUtilitario.Helper.Genericos.DataRowToStringJson(dr);
                Dictionary<string, string> oData = EasyUtilitario.Helper.Data.SeriaizedDiccionario(Item);

                EasyListItem LItem = new EasyListItem("", oData[this.EasyAcBuscarPersonal.DisplayText], oData[this.EasyAcBuscarPersonal.ValueField]);
                LItem.DataComplete = oData;
                this.EasyAcBuscarPersonal.ListItems.Add(LItem);

            }
            //Para la busqueda  de personas
            this.EasyAcBuscarPersonal.DataInterconect.UrlWebService = this.PathNetCore + "General/Busquedas.asmx";
        }





        public void CargarModoNuevo()
        {
            throw new NotImplementedException();
        }

        public void CargarModoPagina()
        {
            switch (this.ModoPagina)
            {
                case EasyUtilitario.Enumerados.ModoPagina.N:
                    CargarModoNuevo();
                    break;
                case EasyUtilitario.Enumerados.ModoPagina.M:
                    CargarModoModificar();
                    break;
            }
        }

        public void Eliminar()
        {
            throw new NotImplementedException();
        }

        public void Modificar()
        {
            throw new NotImplementedException();
        }

        public bool ValidarCampos()
        {
            throw new NotImplementedException();
        }

        public bool ValidarCamposRequeridos()
        {
            throw new NotImplementedException();
        }

        public bool ValidarExpresionesRegulares()
        {
            throw new NotImplementedException();
        }

       
    }
}