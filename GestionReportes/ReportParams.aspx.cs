using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.Form;
using EasyControlWeb.Form.Controls;
using EasyControlWeb.Form.Estilo;
using EasyControlWeb.InterConeccion;
using SIMANET_W22R.Controles;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.srvGestionReportes;

using System;
using System.Collections.Generic;

using System.Data;
using System.Linq;
using System.Net.Http.Headers;
using System.Runtime.CompilerServices;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestionReportes
{
    public partial class ReportParams : ReporteBase
    {
        // public EasyForm oEasyForm = new EasyForm();
        const string PrefCtrl = "Ctrl";

        public string NombreObjeto
        {
            get { return Page.Request.Params["NomObjeto"].ToString(); }
        }

        public string QuienLlama
        {
            get { return Page.Request.Params["QLlama"].ToString(); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    //Copiar Dll
                    (new DetalleObjeto_Reporte()).ClonarAppDll();
                    CrearControles();
                }
            }
            catch (SIMAExceptionSeguridadAccesoForms ex)
            {
                this.LanzarException(ex);
            }

        }

        string scriptBody = "";
        void CrearControles()
        {
            Header oHeader = new Header();
            //string Login = "erosales";//this.UsuarioLogin;
            string NomFrm = "EasyForm";

            AdministrarReportesSoapClient ogReports = new AdministrarReportesSoapClient();
            string MetodoTextooValor = "";
            DataTable dtSeccion = ogReports.ListarObjetos(this.IdObjeto.ToString(), this.UsuarioLogin);
            foreach (DataRow drSeccion in dtSeccion.Rows)
            {
                EasyFormSeccion oEasyFormSeccion = new EasyFormSeccion();
                oEasyFormSeccion.Titulo = drSeccion["Nombre"].ToString();
                DataTable dtParametros = ogReports.ListarObjetos(drSeccion["IdObjeto"].ToString(), this.UsuarioLogin);
                foreach (DataRow drParam in dtParametros.Rows)
                {
                    string NomCtrl = PrefCtrl + drParam["IdObjeto"].ToString();
                    string TipoCtrl = drParam["TipoControl"].ToString();
                    switch (TipoCtrl)
                    {
                        case "EasyAutocompletar":
                            EasyAutocompletar oEasyAutocompletar = new EasyAutocompletar();
                            oEasyAutocompletar = (new EasyAutocompletar()).SetAttrValue(drParam["IdObjeto"].ToString(), Convert.ToInt32(drParam["IdTipoControl"]));
                            oEasyAutocompletar.ID = NomCtrl;
                            oEasyAutocompletar.Etiqueta = ((drParam["Descripcion"].ToString().Length > 0) ? drParam["Descripcion"].ToString() : drParam["Nombre"].ToString());
                            oEasyFormSeccion.ItemsCtrl.Add(oEasyAutocompletar);
                            MetodoTextooValor = ".GetText()";
                            break;
                        case "EasyListAutocompletar":
                            EasyListAutocompletar oEasyListAutocompletar = new EasyListAutocompletar();
                            oEasyListAutocompletar = (new EasyListAutocompletar()).SetAttrValue(drParam["IdObjeto"].ToString(), Convert.ToInt32(drParam["IdTipoControl"]));
                            oEasyListAutocompletar.ID = NomCtrl;
                            oEasyListAutocompletar.Etiqueta = ((drParam["Descripcion"].ToString().Length > 0) ? drParam["Descripcion"].ToString() : drParam["Nombre"].ToString());
                            oEasyFormSeccion.ItemsCtrl.Add(oEasyListAutocompletar);
                            MetodoTextooValor = ".GetListText()";
                            oEasyListAutocompletar.CssClass = "ContentLisItem";
                            oEasyListAutocompletar.ClassItem = "LstItem";
                            break;
                        case "EasyDropdownList":
                            string EventOnChange = NomFrm + "_" + NomCtrl + "onSelectedChange";
                            EasyDropdownList oEasyDropdownList = new EasyDropdownList();
                            oEasyDropdownList = (new EasyDropdownList()).SetAttrValue(drParam["IdObjeto"].ToString(), Convert.ToInt32(drParam["IdTipoControl"]));
                            oEasyDropdownList.ID = NomCtrl;
                            oEasyDropdownList.Etiqueta = ((drParam["Descripcion"].ToString().Length > 0) ? drParam["Descripcion"].ToString() : drParam["Nombre"].ToString());
                            oEasyDropdownList.LoadData();
                            oEasyFormSeccion.ItemsCtrl.Add(oEasyDropdownList);
                            MetodoTextooValor = ".GetText()";
                            break;
                        case "EasyTextBox":
                            EasyTextBox oEasyTextBox = new EasyTextBox();
                            oEasyTextBox.ID = NomCtrl;
                            oEasyTextBox.Etiqueta = ((drParam["Descripcion"].ToString().Length > 0) ? drParam["Descripcion"].ToString() : drParam["Nombre"].ToString());
                            oEasyFormSeccion.ItemsCtrl.Add(oEasyTextBox);
                            MetodoTextooValor = ".GetValue()";
                            break;
                        case "EasyNumericBox":
                            EasyNumericBox oEasyNumericBox = new EasyNumericBox();
                            oEasyNumericBox = (new EasyNumericBox()).SetAttrValue(drParam["IdObjeto"].ToString(), Convert.ToInt32(drParam["IdTipoControl"]));
                            oEasyNumericBox.ID = NomCtrl;
                            oEasyNumericBox.Etiqueta = ((drParam["Descripcion"].ToString().Length > 0) ? drParam["Descripcion"].ToString() : drParam["Nombre"].ToString());
                            oEasyFormSeccion.ItemsCtrl.Add(oEasyNumericBox);
                            MetodoTextooValor = ".GetValue()";
                            break;
                        case "EasyDatepicker":
                            EasyDatepicker oEasyDatepicker = new EasyDatepicker();
                            oEasyDatepicker.ID = NomCtrl;
                            oEasyDatepicker.Etiqueta = ((drParam["Descripcion"].ToString().Length > 0) ? drParam["Descripcion"].ToString() : drParam["Nombre"].ToString());
                            oEasyFormSeccion.ItemsCtrl.Add(oEasyDatepicker);
                            MetodoTextooValor = ".GetText()";//Para el filtro
                            break;
                        case "EasyVarEntorno":
                            DataTable dtValor = ogReports.ListarObjetoAttributoValor(Convert.ToInt32(drParam["IdObjeto"].ToString()), Convert.ToInt32(drParam["IdTipoControl"]), 0, this.UsuarioLogin);
                            string Valor = dtValor.Rows[0]["Valor"].ToString();
                            switch (Valor)
                            {
                                case "@UserName"://desede la session
                                case "@IdUsuario"://desede la session
                                case "@IdCentro"://desede la session
                                    Valor = Valor.Replace("@", "");
                                    Valor = Session[Valor].ToString();
                                    break;
                                case "@IdObjeto":
                                    Valor = Page.Request.Params[ReporteBase.KEYQIDOBJETO.ToString()];
                                    break;
                            }
                            EasyTextBox oEasyTextBoxHide = new EasyTextBox();
                            oEasyTextBoxHide.ID = NomCtrl;
                            oEasyTextBoxHide.Text = Valor;
                            oEasyTextBoxHide.Style.Add("display", "none");
                            MetodoTextooValor = ".GetText()";//Para el filtro
                            oEasyFormSeccion.ItemsCtrl.Add(oEasyTextBoxHide);
                            //MetodoTextooValor = ".GetValue()";
                            break;
                    }
                    string NomCtrlReal = NomFrm + "_" + NomCtrl;

                    string _GetValues = ((TipoCtrl == "EasyListAutocompletar") ? ".GetListValue()" : ".GetValue()");

                    scriptBody += @" ParamBE =new  ParamReportBE('" + drParam["Ref1"].ToString() + "'," + NomCtrlReal + _GetValues + ",'" + drParam["Nombre"].ToString() + "'," + NomCtrlReal + MetodoTextooValor + ",'" + drParam["Ref2"].ToString() + "','" + drParam["Ref3"].ToString() + @"');
                                        ColletionParamsReport.Add(ParamBE);";

                    /*   scriptBody += @" ParamBE =new  ParamReportBE('" +  drParam["Ref1"].ToString() + "'," + NomCtrlReal + ".GetValue(),'" + drParam["Nombre"].ToString() + "'," + NomCtrlReal + MetodoTextooValor + ",'" + drParam["Ref2"].ToString() + "','" + drParam["Ref3"].ToString() + @"');
                                           ColletionParamsReport.Add(ParamBE);
                                       ";*/
                }
                EasyForm.Secciones.Add(oEasyFormSeccion);
            }
            scriptBody = "function LoadArray(){" + scriptBody + "}";

            //EasyUtilitario.Helper.Pagina.DEBUG(scriptBody);

            string[,] ScriptBase = new string[1, 1] { { scriptBody } };
            oHeader.RegistrarLibs(Page.Header, Controles.Header.TipoLib.ScriptFrag, ScriptBase);
        }
    }
}