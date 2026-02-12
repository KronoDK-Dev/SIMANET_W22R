using EasyControlWeb;
using EasyControlWeb.Filtro;
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
using static EasyControlWeb.EasyUtilitario;
using static EasyControlWeb.EasyUtilitario.Enumerados;
using static EasyControlWeb.InterConeccion.EasyDataInterConect;

namespace SIMANET_W22R.SIMANET.SeguridadPlanta
{
    public partial class ListaTrabajadores : SeguridadPlantaBase,IPaginaBase
    {

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

        public void LlenarGrilla()
        {
            this.grvTrabajadores.DataInterconect = ListarTrabajadores();
            grvTrabajadores.LoadData();
        }
        EasyDataInterConect ListarTrabajadores()
        {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.ConfigPathSrvRemoto = "PathBaseWSCore";
            odi.MetodoConexion = MetododeConexion.WebServiceExterno;
            odi.UrlWebService = "SIMANET/SeguridadPlanta/Contratista.asmx";
            odi.Metodo = "ProgramacionTrabajador_lst";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "Periodo";
            oParam.Paramvalue = this.Año;
            oParam.TipodeDato = TiposdeDatos.Int;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdProgramacion";
            oParam.Paramvalue = this.IdProgramacion;
            oParam.TipodeDato = TiposdeDatos.Int;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);


            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "NroDNI";
            oParam.Paramvalue = "";
            oParam.TipodeDato = TiposdeDatos.String;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);



            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);
            return odi;
        }

        EasyDataInterConect ListarRequisitosTrabajadores(string NroDNI)
        {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.ConfigPathSrvRemoto = "PathBaseWSCore";
            odi.MetodoConexion = MetododeConexion.WebServiceExterno;
            odi.UrlWebService = "SIMANET/SeguridadPlanta/Contratista.asmx";
            odi.Metodo = "ProgramacionTrabajadorRequisitos_lst";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "NroDNI";
            oParam.Paramvalue = NroDNI;
            oParam.TipodeDato = TiposdeDatos.String;
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

        protected void grvTrabajadores_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                HtmlTable tblH = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(2, 2);
                tblH.Style.Add("width", "100%");
                tblH.Rows[0].Cells[0].InnerText = "SCTR";
                tblH.Rows[0].Cells[0].Align = "CENTER";
                tblH.Rows[0].Cells[0].ColSpan = 2;
                tblH.Rows[0].Cells[1].Style.Add("visibility", "hidden");
                tblH.Rows[0].Cells[0].Attributes.Add("style", " border-bottom-style: solid;border-bottom-color: white;border-bottom-width: 1px;");

                tblH.Rows[1].Cells[0].InnerText = "SALUD";
                tblH.Rows[1].Cells[0].Align = "CENTER";
                tblH.Rows[1].Cells[1].InnerText = "PENS.";
                tblH.Rows[1].Cells[0].Align = "CENTER";
                tblH.Rows[1].Cells[1].Attributes.Add("style", "border-Left-style: solid;border-Left-color:white;border-Left-width: 1px;");
                e.Row.Cells[3].Controls.Add(tblH);

                tblH = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(2, 2);
                tblH.Style.Add("width", "100%");
                tblH.Rows[0].Cells[0].InnerText = "EXAMEN";
                tblH.Rows[0].Cells[0].Align = "CENTER";
                tblH.Rows[0].Cells[0].ColSpan = 2;
                tblH.Rows[0].Cells[1].Style.Add("visibility", "hidden");
                tblH.Rows[0].Cells[0].Attributes.Add("style", " border-bottom-style: solid;border-bottom-color: white;border-bottom-width: 1px;");

                tblH.Rows[1].Cells[0].InnerText = "MEDICO";
                tblH.Rows[1].Cells[0].Align = "CENTER";
                tblH.Rows[1].Cells[1].InnerText = "INDUC.";
                tblH.Rows[1].Cells[0].Align = "CENTER";
                tblH.Rows[1].Cells[1].Attributes.Add("style", "border-Left-style: solid;border-Left-color:white;border-Left-width: 1px;");
                e.Row.Cells[4].Controls.Add(tblH);
            }
            else if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = (DataRowView)e.Row.DataItem;
                DataRow dr = drv.Row;
                //Salud y pension

                foreach (DataRow drvr in ListarRequisitosTrabajadores(dr["NroDNI"].ToString()).GetDataTable().Rows) {

                    //Autorizacion de feriados

                    HtmlTable tblAutiriza = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(1, 2);
                    tblAutiriza.Style.Add("Width", "100%");
                    tblAutiriza.Rows[0].Attributes["class"] = "ItemGrillaSinColor";

                    tblAutiriza.Rows[0].Cells[0].InnerText = dr["NroDni"].ToString();
                    tblAutiriza.Rows[0].Cells[0].Style.Add("Width", "100%");
                    if (dr["IdEstado"].ToString().Equals("3"))//NO esta activo en esta programacion 
                    {
                        tblAutiriza.Rows[0].Cells[0].Style.Add("text-decoration", "line-through");
                    }

                    //crear el ctrl Chk
                    CheckBox chkf = new CheckBox();
                    chkf.Checked = ((dr["AutorizadoFeriado"].ToString() == "1") ? true : false);
                    chkf.Attributes["chkFeriado"] = "";
                    chkf.Attributes["Data"] = Helper.Genericos.DataRowToStringJson(dr);

                    tblAutiriza.Rows[0].Cells[1].Controls.Add(chkf);
                    //Establece Los Atributos para la autorizacion
                    tblAutiriza.Rows[0].Cells[1].Attributes["NroDNI"] = dr["NroDNI"].ToString();
                    
                    e.Row.Cells[1].Controls.Add(tblAutiriza);




                    HtmlTable tblH = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(1, 2);
                        tblH.Style.Add("border-collapse", "collapse");
                        tblH.Style.Add("width", "100%");

                        System.Web.UI.WebControls.CheckBox chk = new System.Web.UI.WebControls.CheckBox();
                        chk.Checked = ((drvr["SCTRSalud"].ToString().Equals("SI")) ? true : false);

                        tblH.Rows[0].Cells[0].Controls.Add(chk);

                        chk = new System.Web.UI.WebControls.CheckBox();
                        chk.Checked = ((drvr["SCTRPension"].ToString().Equals("SI")) ? true : false);
                        tblH.Rows[0].Cells[1].Controls.Add(chk);

                        e.Row.Cells[3].Controls.Add(tblH);

                        tblH = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(1, 2);
                        tblH.Style.Add("border-collapse", "collapse");

                        tblH.Style.Add("width", "100%");
                        tblH.Rows[0].Cells[0].InnerText = drvr["ExamenMedico"].ToString();
                        tblH.Rows[0].Cells[0].Style.Add("padding", "0");

                        if (drvr["ExamenMedico"].ToString().Equals("NO"))
                        {
                            tblH.Rows[0].Cells[0].Style.Add("background-color", "red");
                            tblH.Rows[0].Cells[0].Style.Add("color", "white");
                        }

                        tblH.Rows[0].Cells[1].InnerText = drvr["ExamenInduccion"].ToString();
                        tblH.Rows[0].Cells[1].Style.Add("padding","0");

                        if (drvr["ExamenInduccion"].ToString().Equals("NO"))
                        {
                            tblH.Rows[0].Cells[1].Style.Add("background-color", drvr["ColorInd"].ToString());
                            tblH.Rows[0].Cells[1].Style.Add("color", "white");
                        }                        
                        e.Row.Cells[4].Controls.Add(tblH);

                }

                e.Row.Cells[5].Text = dr["tFechaInicio"].ToString().Substring(0, 10);
                e.Row.Cells[6].Text = dr["tFechaTermino"].ToString().Substring(0, 10);

                HtmlImage oImg = new HtmlImage();
                oImg.Src = EasyUtilitario.Constantes.ImgDataURL.IconDelete;
                oImg.Attributes.Add(EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString(), "ListaTrabajadores.Eliminar(this)");
                oImg.Style.Add("cursor", "pointer");
                e.Row.Cells[7].Controls.Add(oImg);

            }
        }
    }
}