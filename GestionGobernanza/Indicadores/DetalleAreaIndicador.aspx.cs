using EasyControlWeb.Filtro;
using EasyControlWeb.InterConeccion;
using EasyControlWeb;
using SIMANET_W22R.HelpDesk.Sistemas;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.UI.HtmlControls;
using EasyControlWeb.Form.Controls;
using SIMANET_W22R.srvSeguridad;
using static EasyControlWeb.EasyUtilitario.Enumerados;
using DocumentFormat.OpenXml.Office.PowerPoint.Y2021.M06.Main;

namespace SIMANET_W22R.GestionGobernanza.Indicadores
{
    public partial class DetalleAreaIndicador : GobernanzaBase,IPaginaBase,IPaginaMantenimento
    {
     
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                this.LlenarCombos();
                this.CargarModoPagina();
                this.LlenarDatos();
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
            DataTable dt = ListarAreaResponsable();
            foreach (DataRow dr in dt.Rows)
            {
                if (this.IdTablaGeneral.ToString().Equals(dr["IDTBL"].ToString()) && this.IdTablaGeneralItems.ToString().Equals(dr["IDITEM"].ToString())) {
                    this.txtNombreArea.SetValue(dr["NOMBRE_AREA"].ToString());
                    this.txtFormula.SetValue(dr["FORMULA"].ToString());
                    this.txtFuente.SetValue(dr["FUENTEINFORMACION"].ToString());
                    this.ddlProceso.SetValue(dr["IDPROCESO"].ToString());
                    this.ddlMedicion.SetValue(dr["IDPERIODOMEDICION"].ToString());
                    this.ddlSentido .SetValue(dr["IDSENTIDO"].ToString());
                    this.ddlUnidad.SetValue(dr["IDUNDMEDIDA"].ToString());
                    this.hIdAreaInfo.Value = dr["IDTBLITEMRELACION"].ToString();
                }
            }
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

        public void LlenarGrilla()
        {
            throw new NotImplementedException();
        }

        public void LlenarGrilla(string strFilter)
        {
            throw new NotImplementedException();
        }

        public void LlenarCombos()
        {
            this.ddlUnidad.DataInterconect.UrlWebService = this.PathNetCore + "/General/General.asmx";
            this.ddlUnidad.LoadData();

            this.ddlSentido.DataInterconect.UrlWebService = this.PathNetCore + "/General/General.asmx";
            this.ddlSentido.LoadData();

            this.ddlMedicion.DataInterconect.UrlWebService = this.PathNetCore + "/General/General.asmx";
            this.ddlMedicion.LoadData();

            this.ddlProceso.DataInterconect.UrlWebService = this.PathNetCore + "/General/General.asmx";
            this.ddlProceso.LoadData();
        }



        public DataTable ListarCondiciones(string IdArea,string IdIndicador, string UserName)
        {

            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/GestionGobernanza/Indicadores.asmx";
            odi.Metodo = "ListarIndicadorCondicion";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdArea";
            oParam.Paramvalue = IdArea;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdIndicador";
            oParam.Paramvalue = IdIndicador;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            odi.UrlWebServicieParams.Add(oParam);


            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = UserName;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);
            return odi.GetDataTable();
        }

     
        public void LlenarDatos()
        {
            int c = 0;
            HtmlTable tbl = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(2, 3);
            tbl.ID = "tbl_Condicion";
            foreach (DataRow drc in ListarCondiciones(this.IdTablaGeneralItems, this.IdTablaGeneralItemsRel, this.UsuarioLogin).Rows)
            {
                EasyTextBox tbCond = new EasyTextBox();
                tbCond.ID = "txt" + drc["IDCOLOR"].ToString();
                tbCond.SetValue(drc["VALORCONDICION"].ToString());
                tbCond.Attributes.Add("required", " ");

                tbl.Rows[0].Cells[c].InnerText = drc["NOMBRECOLOR"].ToString();
                tbl.Rows[0].Cells[c].Align = "center";
                tbl.Rows[0].Cells[c].Attributes.Add("reference", tbCond.ID);

                tbl.Rows[0].Cells[c].Attributes["class"] = "Etiqueta";
                tbl.Rows[0].Cells[c].Style.Add("background-color", drc["COLOR"].ToString());

                tbl.Rows[1].Cells[c].Controls.Add(tbCond);
                tbl.Rows[1].Cells[c].Attributes.Add("Data", EasyUtilitario.Helper.Genericos.DataRowToStringJson(drc));

                c++;
            }
            this.tblCond.Controls.Add(tbl);
        }

        public DataTable ListarAreaResponsable() {

            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/GestionGobernanza/Indicadores.asmx";
            odi.Metodo = "ListarAccioneResponsable";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdTblObjetivo";
            oParam.Paramvalue = this.IdTablaGeneralRel;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdObjetivo";
            oParam.Paramvalue = this.IdTablaGeneralItemsRel;
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


        public void LlenarJScript()
        {
            throw new NotImplementedException();
        }

        public void RegistrarJScript()
        {
            throw new NotImplementedException();
        }

        public void Imprimir()
        {
            throw new NotImplementedException();
        }

        public void Exportar()
        {
            throw new NotImplementedException();
        }

        public void ConfigurarAccesoControles()
        {
            throw new NotImplementedException();
        }

        public bool ValidarFiltros()
        {
            throw new NotImplementedException();
        }

        public bool ValidarDatos()
        {
            throw new NotImplementedException();
        }
    }
}