using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.Form.Controls;
using EasyControlWeb.InterConeccion;
using iTextSharp.text.pdf.codec.wmf;
using iTextSharp.text;
using Org.BouncyCastle.Asn1.X509;
using PdfSharp.Drawing;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.General;
using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.srvGestionCalidad;
using SIMANET_W22R.srvGestionReportes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using static EasyControlWeb.EasyUtilitario.Enumerados;
using static EasyControlWeb.EasyUtilitario.Enumerados.Configuracion.SeccionKey;
using System.Runtime.ConstrainedExecution;

namespace SIMANET_W22R.GestionReportes
{
    public partial class AdministrarPropiedades : ReporteBase, IPaginaBase
    {
        public DataTable dtTreeAttrVal = new DataTable();
        EasyMessageBox oeasyMessageBox;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {

                    this.LlenarDatos();
                    this.LlenarJScript();
                    this.LlenarGrilla();
                }
            }
            catch (SIMAExceptionSeguridadAccesoForms ex)
            {
                this.LanzarException(ex);
            }
        }

        public int Agregar()
        {
            throw new NotImplementedException();
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
            //this.TxtPathServicioP.Text = Page.Request.PhysicalApplicationPath.Replace(EasyUtilitario.Constantes.Caracteres.BackSlash.ToString(), "@");

            //Define la structura del datatable
            dtTreeAttrVal.Columns.Add(new DataColumn("IdAtributo", typeof(string)));
            dtTreeAttrVal.Columns.Add(new DataColumn("IdNodo", typeof(string)));
            dtTreeAttrVal.Columns.Add(new DataColumn("Nombre", typeof(string)));
            dtTreeAttrVal.Columns.Add(new DataColumn("IdAttValor", typeof(string)));
            dtTreeAttrVal.Columns.Add(new DataColumn("Valor", typeof(string)));
            dtTreeAttrVal.Columns.Add(new DataColumn("NroHijos", typeof(string)));
            dtTreeAttrVal.Columns.Add(new DataColumn("Nivel", typeof(string)));
            dtTreeAttrVal.Columns.Add(new DataColumn("NombreCtrl", typeof(string)));
            dtTreeAttrVal.Columns.Add(new DataColumn("IdTablaData", typeof(string)));
            dtTreeAttrVal.Columns.Add(new DataColumn("IdObjeto", typeof(string)));
            dtTreeAttrVal.Columns.Add(new DataColumn("OrdenParam", typeof(string)));
            dtTreeAttrVal.Columns.Add(new DataColumn("IdGrp", typeof(Int32)));

            ElaborarArbolAttr(this.IdObjeto, this.IdTipodeControl, 0, null, 1);

        }

        void ElaborarArbolAttr(int _IdObjeto, int _IdTipoControl, int _IdAttrPadre, string IdNodo, int Nivel)
        {
            AdministrarReportesSoapClient ogReports = new AdministrarReportesSoapClient();
            DataTable dt = ogReports.ListarObjetoAttributoValor(_IdObjeto, _IdTipoControl, _IdAttrPadre, this.UsuarioLogin);
            foreach (DataRow dr in dt.Rows)
            {
                DataRow drnew = dtTreeAttrVal.NewRow();
                drnew["IdAtributo"] = dr["IdAtributo"].ToString();
                string strNodo = ((IdNodo == null) ? dr["IdAtributo"].ToString() : IdNodo + "." + dr["IdAtributo"].ToString());

                drnew["IdNodo"] = strNodo;
                drnew["Nombre"] = dr["Nombre"].ToString();
                drnew["IdAttValor"] = dr["IdAtributoValor"].ToString();
                drnew["Valor"] = dr["Valor"].ToString();
                drnew["Valor"] = dr["Valor"].ToString();
                drnew["NroHijos"] = dr["NroHijos"].ToString();
                drnew["NombreCtrl"] = dr["NombreCtrl"].ToString();
                drnew["IdTablaData"] = dr["IdTablaData"].ToString();
                drnew["IdObjeto"] = dr["IdObjeto"].ToString();
                drnew["OrdenParam"] = dr["OrdenParam"].ToString();
                drnew["IdGrp"] = dr["IdGrp"].ToString();
                EasyUtilitario.Helper.Pagina.DEBUG(dr["OrdenParam"].ToString());
                drnew["Nivel"] = Nivel;
                dtTreeAttrVal.Rows.Add(drnew);
                dtTreeAttrVal.AcceptChanges();
                if (Convert.ToInt32(drnew["NroHijos"]) > 0)
                {
                    ElaborarArbolAttr(_IdObjeto, _IdTipoControl, Convert.ToInt32(dr["IdAtributo"].ToString()), strNodo, (Nivel + 1));
                }
            }
        }


        public void LlenarGrilla()
        {
            try
            {
                EasyGridViewPropiedades.DataSource = dtTreeAttrVal;
                EasyGridViewPropiedades.DataBind();
                this.LlenarJScript();
            }
            catch (Exception ex)
            {
                SIMAExceptionSeguridadAccesoForms oer = new SIMAExceptionSeguridadAccesoForms(ex.Message);
                this.ErrorDisplay(oer);
            }
        }

        public void LlenarGrilla(string strFilter)
        {
            throw new NotImplementedException();
        }

        public void LlenarJScript()
        {
            ObjetoConfigAttrBE oObjetoConfigAttrBE = new ObjetoConfigAttrBE();
            this.EntityInJavascriptFromServer(oObjetoConfigAttrBE.GetType());
            txtPathWebServiceSelectedP.Style.Add("display", "none");


            string Pagina = GetPageName();
            string FormReplicateConst = @" setTimeout(function(){
                                                    " + Pagina + @".PhysicalApplicationPath='" + Page.Request.PhysicalApplicationPath.ToString().Replace("\\", ".") + @"';
                                                    " + Pagina + @".NameSpaceBaseDll='SIMANET_W22R';
                                            }, 500);";

            Page.RegisterClientScriptBlock("ValDef", "<script>\n" + FormReplicateConst + "\n" + "</script>");

        }

        public int Modificar()
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

        protected void EasyGridViewPropiedades_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                DataRowView drv = (DataRowView)e.Row.DataItem;
                DataRow dr = drv.Row;
                HtmlTable tblNodo = new HtmlTable();
                int Nivel = Convert.ToInt32(dr["Nivel"]);
                tblNodo = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(1, (Nivel + 1));
                tblNodo.Attributes["width"] = "100%";
                // tblNodo.Attributes["border"]="2";
                tblNodo.Rows[0].Cells[Nivel].InnerText = dr["Nombre"].ToString();
                tblNodo.Rows[0].Cells[Nivel].Attributes["title"] = dr["IdAttValor"].ToString();
                tblNodo.Rows[0].Cells[Nivel].Attributes["width"] = "100%";
                tblNodo.Rows[0].Cells[Nivel].Style.Add("padding-left", "10px");
                HtmlImage oImg = new HtmlImage();
                if (Convert.ToInt32(dr["NroHijos"]) > 0)
                {
                    tblNodo.Rows[0].Cells[Nivel].Style.Add("font-weight", "bold");
                    tblNodo.Rows[0].Cells[Nivel].Style.Add("font-size", "14px");

                    oImg.Src = EasyUtilitario.Constantes.ImgDataURL.IconTreeMinus;
                    oImg.Attributes[EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString()] = "ExpandeCollapse(this, '" + dr["IdNodo"].ToString() + "','" + e.Row.RowIndex.ToString() + "')";
                    tblNodo.Rows[0].Cells[Nivel - 1].Controls.Add(oImg);

                    for (int i = 0; i <= (Nivel - 2); i++)
                    {
                        oImg = new HtmlImage();
                        oImg.Src = EasyUtilitario.Constantes.ImgDataURL.IconTreeSpace;
                        tblNodo.Rows[0].Cells[i].Controls.Add(oImg);
                    }
                }
                else
                {
                    if (dr["IdAtributo"].ToString().Equals("18") || dr["IdAtributo"].ToString().Equals("31") || dr["IdAtributo"].ToString().Equals("64"))
                    {
                        tblNodo.Attributes.Add("class", "NodoParam");
                    }
                    for (int i = 0; i <= (Nivel - 1); i++)
                    {
                        oImg = new HtmlImage();
                        oImg.Src = EasyUtilitario.Constantes.ImgDataURL.IconTreeSpace;
                        tblNodo.Rows[0].Cells[i].Controls.Add(oImg);
                    }
                }
                //establece atributos para su control
                e.Row.Attributes["IdNodo"] = dr["IdNodo"].ToString();

                e.Row.Cells[0].Controls.Add(tblNodo);
                //Opciones para el tripo de control selecionar valor
                EasyControlWeb.Form.Estilo.Bootstrap oEasyStyle;
                oEasyStyle = new EasyControlWeb.Form.Estilo.Bootstrap();
                oEasyStyle.ClassLabel = "form-label";
                oEasyStyle.ClassName = "form-control";
                oEasyStyle.Ancho = EasyControlWeb.Form.Estilo.Bootstrap.Tamaño.Cinco;

                EasyDataInterConect oEasyDataInterConect;
                EasyFiltroParamURLws oParam;

                string IdCtrl = "ctrl" + dr["IdAtributo"].ToString();
                switch (dr["NombreCtrl"].ToString())
                {
                    case "EasyDropdownList":
                        EasyDropdownList oEasyDropdownList = new EasyDropdownList();
                        switch (dr["Nombre"].ToString())
                        {
                            case "Ancho":
                            case "TipoTalla":
                            case "TipodeDato":
                            case "ObtenerValor":
                            case "VEntorno":
                            case "MetodoConexion":

                                // string idTablaGeneral = ((dr["Nombre"].ToString() == "Ancho") ? "681" : "682");
                                string idTablaGeneral = dr["IdTablaData"].ToString();
                                oEasyDataInterConect = new EasyDataInterConect();
                                oEasyDataInterConect.UrlWebService = "/General/TablasGenerales.asmx";
                                oEasyDataInterConect.Metodo = "ListarItems";

                                oParam = new EasyFiltroParamURLws();
                                oParam.ParamName = "IdTabla";
                                oParam.Paramvalue = idTablaGeneral;
                                oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
                                oEasyDataInterConect.UrlWebServicieParams.Add(oParam);

                                oParam = new EasyFiltroParamURLws();
                                oParam.ParamName = "UserName";
                                oParam.Paramvalue = "UserName";
                                oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Session;
                                oEasyDataInterConect.UrlWebServicieParams.Add(oParam);


                                //oEasyDropdownList = new EasyDropdownList();
                                oEasyDropdownList.ID = IdCtrl;
                                oEasyDropdownList.DataTextField = "VAR1";
                                oEasyDropdownList.DataValueField = "CODIGO";
                                oEasyDropdownList.MensajeValida = "No se ha seleccionado Ancho del Control";
                                oEasyDropdownList.Requerido = true;
                                oEasyDropdownList.CargaInmediata = true;
                                oEasyDropdownList.Attributes["class"] = "ItemDetalle";
                                //DataInterconec
                                oEasyDropdownList.DataInterconect = oEasyDataInterConect;

                                break;
                        }

                        oEasyDropdownList.LoadData();

                        if (dr["Nombre"].ToString().Equals("VEntorno"))
                        {
                            oEasyDropdownList.SetText(dr["Valor"].ToString());
                        }
                        else
                        {
                            oEasyDropdownList.SetValue(dr["Valor"].ToString());
                        }
                        oEasyDropdownList.fnOnSelected = "on_ddlSeleted";
                        // oEasyDropdownList.Attributes.Add(EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString(), "onClick_SelectedRow(this);");

                        e.Row.Cells[1].Controls.Add(oEasyDropdownList);
                        break;
                    case "EasyAutocompletar":
                        // case "EasyListAutocompletar":
                        EasyAutocompletar oEasyAutocompletar;
                        switch (dr["Nombre"].ToString())
                        {
                            case "UrlWebService":
                                oEasyDataInterConect = new EasyDataInterConect();
                                oEasyDataInterConect.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceInterno;
                                oEasyDataInterConect.UrlWebService = "/GestionReportes/Procesar.asmx";
                                oEasyDataInterConect.Metodo = "ListarArchivosDeDirectorio";

                                oParam = new EasyFiltroParamURLws();
                                oParam.ParamName = "RutaBase";
                                oParam.Paramvalue = "GetRutaApp()";//"TxtPathServicio";
                                oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.FunctionScript;
                                oEasyDataInterConect.UrlWebServicieParams.Add(oParam);

                                oParam = new EasyFiltroParamURLws();
                                oParam.ParamName = "Ext";
                                oParam.Paramvalue = ".asmx";
                                oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
                                oEasyDataInterConect.UrlWebServicieParams.Add(oParam);

                                oParam = new EasyFiltroParamURLws();
                                oParam.ParamName = "UserName";
                                oParam.Paramvalue = "UserName";
                                oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Session;
                                oEasyDataInterConect.UrlWebServicieParams.Add(oParam);

                                oEasyAutocompletar = new EasyAutocompletar();
                                oEasyAutocompletar.ID = IdCtrl;
                                oEasyAutocompletar.DataInterconect = oEasyDataInterConect;
                                oEasyAutocompletar.EasyStyle = oEasyStyle;
                                oEasyAutocompletar.NroCarIni = 3;
                                oEasyAutocompletar.DisplayText = "Nombre";
                                oEasyAutocompletar.ValueField = "Ruta";
                                oEasyAutocompletar.fnOnSelected = "onPropertyItemWebServiceSeleccionado";
                                // oEasyAutocompletar.fnOnClick="onClick_SelectedRow";
                                oEasyAutocompletar.fncTempaleCustom = "onDisplayTemplateFileASMX";
                                oEasyAutocompletar.Attributes["AutoComplete"] = "Servicio";
                                //Agrega a la columna 
                                e.Row.Cells[1].Controls.Add(oEasyAutocompletar);

                                string PathService = dr["Valor"].ToString();
                                if ((PathService != null) && (PathService.Length > 0))
                                {
                                    string[] PathFile = PathService.Split('/');
                                    string Nombre = PathFile[PathFile.Length - 1];
                                    oEasyAutocompletar.SetValue(Nombre, PathService);
                                    txtPathWebServiceSelectedP.Text = PathService.Substring(0, (PathService.Length - (Nombre.Length + 1)));
                                }

                                string ScriptTemplate = @"<script>
                                                            onDisplayTemplateFileASMX = function (ul, item) {
                                                                                                            var oCustomTemplateBE = new " + oEasyAutocompletar.ClientID + @".CustomTemplateBE(ul, item, AdministrarPropiedades.HtmlTemplate(ul, item));
                                                                                                            return " + oEasyAutocompletar.ClientID + @".SetCustomTemplate(oCustomTemplateBE);
                                                                                                        }

                                                             function GetRutaPaginaServicioASMX() {
                                                                        return jNet.get('txtPathWebServiceSelectedP').value + SIMA.Utilitario.Constantes.Caracter.Slash + " + oEasyAutocompletar.ClientID + @".GetText();
                                                               }


                                                            </script>
                                                            ";


                                Page.Controls.Add(new LiteralControl(ScriptTemplate));


                                break;
                            case "Metodo":
                                oEasyDataInterConect = new EasyDataInterConect();
                                oEasyDataInterConect.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceInterno;
                                oEasyDataInterConect.UrlWebService = "/GestionReportes/Procesar.asmx";
                                oEasyDataInterConect.Metodo = "BuscarMetodoWebService";

                                oParam = new EasyFiltroParamURLws();
                                oParam.ParamName = "PathBase";
                                oParam.Paramvalue = "GetNameSpaceDLL()";
                                oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.FunctionScript;
                                oEasyDataInterConect.UrlWebServicieParams.Add(oParam);

                                oParam = new EasyFiltroParamURLws();
                                oParam.ParamName = "PathWS";
                                oParam.Paramvalue = "GetRutaPaginaServicioASMX()";
                                oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.FunctionScript;
                                oEasyDataInterConect.UrlWebServicieParams.Add(oParam);

                                oParam = new EasyFiltroParamURLws();
                                oParam.ParamName = "UserName";
                                oParam.Paramvalue = "UserName";
                                oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Session;
                                oEasyDataInterConect.UrlWebServicieParams.Add(oParam);

                                oEasyAutocompletar = new EasyAutocompletar();
                                oEasyAutocompletar.ID = IdCtrl;
                                oEasyAutocompletar.DataInterconect = oEasyDataInterConect;
                                oEasyAutocompletar.EasyStyle = oEasyStyle;
                                oEasyAutocompletar.NroCarIni = 3;
                                oEasyAutocompletar.DisplayText = "Metodo";
                                oEasyAutocompletar.ValueField = "Id";
                                oEasyAutocompletar.fnOnSelected = "AdministrarPropiedades.EasyListarParametroMetodoSelected";
                                oEasyAutocompletar.Attributes["AutoComplete"] = "Metodo";
                                oEasyAutocompletar.fncTempaleCustom = "AdministrarPropiedades.EasyMetodosTemplate";

                                oEasyAutocompletar.SetValue(dr["Valor"].ToString(), "0");

                                //Agrega a la columna 
                                e.Row.Cells[1].Controls.Add(oEasyAutocompletar);

                                string ScriptMetodoTemplate = @"<script>
                                                                        AdministrarPropiedades.EasyMetodosTemplate = function (ul, item) {
                                                                                                                var oCustomTemplateBE = new " + oEasyAutocompletar.ClientID + @".CustomTemplateBE(ul, item, AdministrarPropiedades.EasyMetodosHTMLTemplate(ul, item));
                                                                                                                return " + oEasyAutocompletar.ClientID + @".SetCustomTemplate(oCustomTemplateBE);
                                                                                                            }
                                                                </script>
                                                               ";
                                Page.Controls.Add(new LiteralControl(ScriptMetodoTemplate));


                                break;
                        }
                        break;
                    case "EasyNumericBox":
                        EasyNumericBox oEasyNumericBox = new EasyNumericBox();
                        oEasyNumericBox.ID = IdCtrl;
                        oEasyNumericBox.Text = dr["Valor"].ToString();
                        oEasyNumericBox.Attributes.Add("onblur", "on_txtChange(this);");
                        //oEasyNumericBox.Attributes.Add(EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString(), "onClick_SelectedRow(this);");
                        oEasyNumericBox.CssClass = "form-control";
                        e.Row.Cells[1].Controls.Add(oEasyNumericBox);
                        break;
                    case "EasyTextBox":
                        EasyTextBox oEasyTextBox = new EasyTextBox();
                        oEasyTextBox.ID = IdCtrl;
                        oEasyTextBox.Text = dr["Valor"].ToString();
                        oEasyTextBox.CssClass = "form-control";
                        oEasyTextBox.Attributes.Add("onblur", "on_txtChange(this);");
                        // oEasyTextBox.Attributes.Add(EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString(), "onClick_SelectedRow(this);");
                        if (dr["IdAtributo"].ToString().Equals("18")
                            || dr["IdAtributo"].ToString().Equals("31")
                            || dr["IdAtributo"].ToString().Equals("20")
                            || dr["IdAtributo"].ToString().Equals("33")
                            || dr["IdAtributo"].ToString().Equals("64")
                            || dr["IdAtributo"].ToString().Equals("66")
                            || dr["IdAtributo"].ToString().Equals("67"))
                        {
                            oEasyTextBox.ReadOnly = true;
                        }
                        e.Row.Cells[1].Controls.Add(oEasyTextBox);

                        break;
                    case "EasyCheckBox":
                        //HtmlElement
                        CheckBox oCheckBox = new CheckBox();
                        oCheckBox.ID = IdCtrl;
                        // oCheckBox.Attributes.Add(EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString(), "onClick_SelectedRow(this);");
                        oCheckBox.Attributes.Add("onchange", "on_Checked(this);");
                        oCheckBox.Style.Add("width", "60px");
                        oCheckBox.Style.Add("height", "60px");
                        oCheckBox.Checked = ((dr["Valor"].ToString().Equals("True")) ? true : false);
                        e.Row.Cells[1].Controls.Add(oCheckBox);
                        e.Row.Cells[1].Attributes.Add("align", "left");
                        break;
                        /*case "EasyCheckBox":
                            HtmlTable tblBotom = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(1, 2);
                            HtmlImage img = new HtmlImage();
                            img.Src = EasyUtilitario.Constantes.ImgDataURL.IconConfigParam;
                            tblBotom.Style.Add("width", "40%");
                            tblBotom.Rows[0].Cells[0].Controls.Add(img);
                            tblBotom.Rows[0].Cells[1].InnerText = "Agregar parámetro";
                            tblBotom.Attributes.Add("class", "ItemObj");
                            tblBotom.Attributes.Add(EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString(), "AdministrarPropiedades.AgregarParametros(this.parentNode.parentNode,'" + dr["IdObjeto"].ToString() + "');");
                            e.Row.Cells[1].Controls.Add(tblBotom);
                            e.Row.Cells[1].Attributes.Add("align", "right");
                            break;*/
                }

            }
        }
    }
}