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
using static EasyControlWeb.EasyUtilitario.Enumerados;
using static EasyControlWeb.Form.Controls.EasyPopupBase;
using static EasyControlWeb.InterConeccion.EasyDataInterConect;

namespace SIMANET_W22R.GestionGobernanza.Indicadores
{
    public partial class AdministrarMetasPorArea : GobernanzaBase, IPaginaBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                this.LlenarCombos();
                this.LlenarDatos();
            }
            catch (Exception ex)
            {
                int i = 0;
            }
        }

        DataTable ListarMetasPorIndicador() {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.ConfigPathSrvRemoto = "PathBaseWSCore";
            odi.MetodoConexion = MetododeConexion.WebServiceExterno;
            odi.UrlWebService = "GestionGobernanza/Indicadores.asmx";
            odi.Metodo = "AreaindicadorMetas_Lst";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdAreaComple";
            oParam.Paramvalue = this.IdAreaInfo;
            oParam.TipodeDato = TiposdeDatos.String;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdIndicador";
            oParam.Paramvalue = this.IdIndicador;
            oParam.TipodeDato = TiposdeDatos.String;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);


            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "Periodo";
            oParam.Paramvalue = this.Año;
            oParam.TipodeDato = TiposdeDatos.String;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);
            return odi.GetDataTable();
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
          
        }

        public void LlenarDatos()
        {
            string IcoDet = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABUAAAATCAYAAAB/TkaLAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAFtSURBVDhPY1y7du1/BmoDahsKMo8FysYAM2eegVv269cvhh8/foDx9+/fUWgQXr68hBGqFAxwGgoC5uZSUBYC1NTMZGhpSYfyGBjq6mZDWQjABKUxwL9//6AsBGhsnMfw588fhvz8HqgIA8O3b9+gLATAaejXr18ZTp58BsetrYsYfv/+zXD9+kEwnZzcABYHqUMHKN5HDkeQxs+fP8PDbdWqcqAB3xns7M4wHD06CaqKgWHWrFlQFgJghGlamjGUhQBTpuwGGzhr1lIGMTEhqChugGIoKLyQgaamMwM7Oysw3H4xTJ3KwsDDw8fg5OQPNPwsVAV2gGLoly9fUDQUFnaB6Zcv7zDU1oaD2egAi+9RIwpkKMj76BiUJkkBKIZii0kQAEWUiUk6VowN4PU+DIBcevbsLJRcgxcg5/3o6L7/2EBqag/R5QPIPIwwpQbAMNTGJh8j3M6duwVVQSSgRdGHM+9TAmhQ8jMwAAAgO9rVbQNukAAAAABJRU5ErkJggg==";
            int i = 1;
            DataTable dt = ListarMetasPorIndicador();
            if (dt != null)
            {
                HtmlTable tblBase = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(5, dt.Rows.Count+1);
                tblBase.ID = this.IdAreaInfo + "_" + this.IdIndicador + "-" + this.Año;
                tblBase.Rows[0].Style.Add("Height","45px");
                foreach (DataRow dr in dt.Rows)
                {

                    tblBase.Rows[0].Attributes.Add("class", "HeaderGrilla");
                    tblBase.Rows[0].Cells[0].InnerText= dr["NOMBRETIPO"].ToString().ToUpper();

                    tblBase.Rows[1].Cells[0].InnerText = "NUMERADOR";
                    tblBase.Rows[2].Cells[0].InnerText = "DENOMINADOR";
                    tblBase.Rows[3].Cells[0].InnerText = "RESULTADO";
                    tblBase.Rows[4].Cells[0].InnerText = "META";

                    tblBase.Rows[0].Cells[0].Attributes.Add("class", "HeaderGrilla");
                    tblBase.Rows[1].Cells[0].Attributes.Add("class", "HeaderGrilla");
                    tblBase.Rows[2].Cells[0].Attributes.Add("class", "HeaderGrilla");
                    tblBase.Rows[3].Cells[0].Attributes.Add("class", "HeaderGrilla");
                    tblBase.Rows[4].Cells[0].Attributes.Add("class", "HeaderGrilla");
                    
                    tblBase.Rows[0].Cells[i].Attributes.Add("Data", EasyUtilitario.Helper.Genericos.DataRowToStringJson(dr));

                    //Condiciones del indicador
                    DataTable dtCondInd = (new DetalleAreaIndicador()).ListarCondiciones(this.IdAreaInfo, this.IdIndicador, this.UsuarioLogin);
                    foreach (DataRow drc in dtCondInd.Rows) {
                        tblBase.Rows[0].Cells[i].Attributes.Add("C_" +drc["IDCOLOR"].ToString(), EasyUtilitario.Helper.Genericos.DataRowToStringJson(drc));
                    }

                   
                    tblBase.Rows[0].Cells[i].InnerHtml= dr["NOMBRE"].ToString().ToUpper();
                    tblBase.Rows[0].Cells[i].Attributes.Add("Data", EasyUtilitario.Helper.Genericos.DataRowToStringJson(dr));


                    EasyTextBox otxt = new EasyTextBox();
                    otxt.ID = "n_" + dr["IDITEM"].ToString();
                    otxt.SetValue(dr["NUMERADOR"].ToString());
                    otxt.Attributes.Add("onblur", "AdministrarMetasPorArea.OnChange(jNet.get(this),'" + this.CodArea + "')");

                    tblBase.Rows[1].Cells[i].Attributes.Add("onclick", "AdministrarMetasPorArea.DetalleAnalisis(jNet.get(this),'" + this.CodArea + "');");
                    tblBase.Rows[1].Cells[i].Controls.Add(otxt);
               

                    otxt = new EasyTextBox();
                    otxt.ID = "D_" + dr["IDITEM"].ToString();
                    otxt.SetValue(dr["DENOMINADOR"].ToString());
                    otxt.Attributes.Add("onblur", "AdministrarMetasPorArea.OnChange(jNet.get(this))");
                    tblBase.Rows[2].Cells[i].Attributes.Add("onclick", "AdministrarMetasPorArea.DetalleAnalisis(jNet.get(this),'" + this.CodArea + "');");
                    tblBase.Rows[2].Cells[i].Controls.Add(otxt);


                   
                    tblBase.Rows[3].Cells[i].InnerHtml = dr["RESULTADO"].ToString();
                    tblBase.Rows[3].Cells[i].Attributes.Add("style", "background-color:" + dr["COLOR"].ToString() + ";color:" + dr["FONTCOLOR"].ToString());
                    //rESULTADO
                    tblBase.Rows[4].Cells[i].InnerHtml = dr["META"].ToString();


                    i++;
                }

                HtmlTable tblMaster = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(6,1);
                tblMaster.Attributes.Add("border", "0");
                tblMaster.Rows[0].Cells[0].Controls.Add(tblBase);
                tblMaster.Rows[1].Cells[0].InnerText = "ANALISIS";
                tblMaster.Rows[1].Cells[0].Attributes.Add("class", "Etiqueta");

                EasyTextBox oEasyTextBox = new EasyTextBox();
                oEasyTextBox.ID = "txtA_" + this.CodArea;                
                tblMaster.Rows[2].Cells[0].Controls.Add(oEasyTextBox);


                tblMaster.Rows[3].Cells[0].InnerText = "ACCIONES Y RECOMENDACIONES";
                tblMaster.Rows[3].Cells[0].Attributes.Add("class", "Etiqueta");
                oEasyTextBox = new EasyTextBox();
                oEasyTextBox.ID = "txtAc_" + this.CodArea;
                tblMaster.Rows[4].Cells[0].Controls.Add(oEasyTextBox);
                //Control de Barras
                string cmll = EasyUtilitario.Constantes.Caracteres.ComillaDoble;
                string htmlCanvas = "<canvas id=" + cmll  +"Chart_"+ this.CodArea + cmll  +" width =" + cmll + "600"+ cmll +" height ="+ cmll + "100" + cmll  + "></canvas>";
                tblMaster.Rows[5].Cells[0].Controls.Add(new LiteralControl(htmlCanvas));


                Page.Form.Controls.Add(tblMaster);
            }
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
    }
}