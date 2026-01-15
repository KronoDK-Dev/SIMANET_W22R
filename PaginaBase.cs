using EasyControlWeb;
using EasyControlWeb.Errors;
using EasyControlWeb.Filtro;
using EasyControlWeb.Form.Controls;
using EasyControlWeb.InterConeccion;
using EasyControlWeb.InterConecion;
//using NPOI.SS.Formula.Functions;
using SIMANET_W22R.ClasesExtendidas;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.HelpDesk.ITIL;
using SIMANET_W22R.srvSeguridad;
using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Runtime.Remoting.Contexts;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using static EasyControlWeb.EasyUtilitario;
using static EasyControlWeb.EasyUtilitario.Enumerados;
using static EasyControlWeb.EasyUtilitario.Helper;
using static iTextSharp.text.pdf.codec.TiffWriter;
using static SIMANET_W22R.Controles.Header;

namespace SIMANET_W22R
{
    public class PaginaBase : System.Web.UI.Page
    {
        #region Controles 
            EasyUsuario oUsuario = new EasyUsuario();
            EasyNavigatorHistorial oEasyNavigatorHistorial = new EasyNavigatorHistorial();
            EasyMessageBox oeasyMessageBox;

        #endregion
        #region  Constantes que se deberan de usuar en todos los modulos
            public static string KEYIDGENERAL = "idGen";
        

        public static string KEYMODOPAGINA= "Modo";
        public static string KEYTOKEN = "ToKN";
        public static string KEYQCENTROOPERATIVO = "IdCeo";
        public static string KEYQAÑO = "Anio";
        public static string KEYQIDMES = "IdMes";
        public static string KEYQFECHA = "Fecha";
        public static string KEYQIDPROCESO = "IdPrc";
        public static string KEYQIDESTADO = "IdEst";
        public static string KEYQDESCRIPCION = "Descrip";
        public static string KEYQAPELLIDOSNOMBRES = "ApellidosyNombres";

        public static string KEYQIDTABLAGENERAL = "IdTblGen";
        public static string KEYQIDITEMTABLAGENERAL = "IdItemTblGen";

        public static string KEYQIDTABLAGENERALREL = "IdTblGenRel";
        public static string KEYQIDITEMTABLAGENERALREL = "IdItemTblGenRel";


        public static string KEYQRAZONSOCIALCLIENTE = "RazonSocialCliente";

        public static string KEYQQUIENLLAMA = "QLlama";
        public static string KEYQEDITABLE = "mEdit";

        public const string KEYCODAREA = "CodArea";
        public const string KEYCODEMP = "CodEmp";
        public const string KEYCODSUC = "CodSuc";
        public static string KEYCLIENTEID = "V_CLIENTE_ID"; // 12.01.2026


        #endregion

        #region Propiedades Publicas
        public string IdGeneral // 12.01.2026
        {
            get { return Page.Request.Params[KEYIDGENERAL]; }
        }
        public string IDCLIENTE
        {
            get { return (((Page.Request.Params[KEYCLIENTEID] == "") || (Page.Request.Params[KEYCLIENTEID] == null)) ? "0" : Page.Request.Params[KEYCLIENTEID]); }
        }
        public string TokenId { get { return Page.Request.Params[KEYTOKEN]; } }
        public int IdProceso { get { return Convert.ToInt32(Page.Request.Params[KEYQIDPROCESO]); } }
        public string IdCentroOperativo{
                get { return Page.Request.Params[KEYQCENTROOPERATIVO]; }
            }
            public string Año
            {
                get { return Page.Request.Params[KEYQAÑO]; }
            }
            public string IdMes
            {
                get { return Page.Request.Params[KEYQIDMES]; }
            }
            public string Fecha
            {
                get { return Page.Request.Params[KEYQFECHA]; }
            }
            public EasyUtilitario.Enumerados.ModoPagina ModoPagina
                                                                    {
                                                                        get
                                                                        {
                                                                            try
                                                                            {
                                                                                return ((Page.Request.Params[EasyUtilitario.Constantes.Pagina.KeyParams.Modo] == null) ? EasyUtilitario.Enumerados.ModoPagina.C : (EasyUtilitario.Enumerados.ModoPagina)System.Enum.Parse(typeof(EasyUtilitario.Enumerados.ModoPagina), Page.Request.Params[EasyUtilitario.Constantes.Pagina.KeyParams.Modo].ToString()));
                                                                            }
                                                                            catch (Exception ex)
                                                                            {
                                                                                return EasyUtilitario.Enumerados.ModoPagina.C;
                                                                            }
                                                                        }
                                                                    }
            public int IdEstado { get { return Convert.ToInt32(Page.Request.Params[KEYQIDESTADO]); } }
            public string Descripcion
            {
                get { return Page.Request.Params[KEYQDESCRIPCION]; }
            }

            public string ApellidosyNombres
            {
                get { return Page.Request.Params[KEYQAPELLIDOSNOMBRES]; }
            }
            public string RazonSocialCliente
            {
                get { return Page.Request.Params[KEYQRAZONSOCIALCLIENTE]; }
            }
            public int ModoEditable { get { return Convert.ToInt32(Page.Request.Params[KEYQEDITABLE]); } }


        public string IdTablaGeneral { get { return Page.Request.Params[KEYQIDTABLAGENERAL]; } }
        public string IdTablaGeneralItems { get { return Page.Request.Params[KEYQIDITEMTABLAGENERAL]; } }

        public string IdTablaGeneralRel { get { return Page.Request.Params[KEYQIDTABLAGENERALREL]; } }
        public string IdTablaGeneralItemsRel { get { return Page.Request.Params[KEYQIDITEMTABLAGENERALREL]; } }


        public string PathFotosPersonal { get { return EasyUtilitario.Helper.Configuracion.PathFotos; } }

        public string CodArea
        {
            get { return Page.Request.Params[KEYCODAREA].ToString(); }
        }

        public string CodEmpresa
        {
            get { return Page.Request.Params[KEYCODEMP].ToString(); }
        }
        public string CodSucursal
        {
            get { return Page.Request.Params[KEYCODSUC].ToString(); }
        }

        public string PathNetCore
        {
            get { return EasyUtilitario.Helper.Configuracion.Leer("ConfigBase", "PathBaseWSCore"); }
        }
        #endregion
        #region Propiedades de entrega de datos
        public string UsuarioLogin{
                get {
                    try
                    {
                        Session["UserName"] = ((EasyUsuario)EasyUtilitario.Helper.Sessiones.Usuario.get()).Login;
                        return ((EasyUsuario)EasyUtilitario.Helper.Sessiones.Usuario.get()).Login;
                    }
                    catch (Exception ex) {
                        return "Udefault";
                    }
                }
            }
            public int UsuarioId { 
                get {
                        try
                        {
                            Session["IdUsuario"] = ((EasyUsuario)EasyUtilitario.Helper.Sessiones.Usuario.get()).IdUsuario;

                            return ((EasyUsuario)EasyUtilitario.Helper.Sessiones.Usuario.get()).IdUsuario;
                        }
                        catch (Exception ex) {
                                SIMAExceptionSeguridadAccesoForms oex = new SIMAExceptionSeguridadAccesoForms(ex.Message);
                                this.LanzarException(oex);
                            return 0;
                        }
                }
            }
        #endregion

        #region datos usuario Logueado
        public UsuarioBE DatosUsuario { 
            get {
                    return (UsuarioBE)Session["UserBE"];
                }
        }
        #endregion


        public PaginaBase() {
           // this.Load += new EventHandler(this.Page_Load);
        }

       protected override void OnLoad(EventArgs e)
       {
            
            if (!Page.IsPostBack)
            {
                oUsuario = EasyUtilitario.Helper.Sessiones.Usuario.get();
                try
                {
                    
                    if (!Page.IsPostBack)
                    {
                        oEasyNavigatorHistorial.getAllCtrlMemoryValue();
                    }
                    
                    this.ValidarPagina("");

                }
                catch (SIMAExceptionSeguridadAccesoForms ex)
                {

                    LanzarException(ex);
                }
                base.OnLoad(e);
            }
            this.ListarConstantesPagina();
        }
       


        public void IrA(EasyControlWeb.Form.Controls.EasyNavigatorBE oEasyNavigatorBE,params object[] LstCtrl) {
            if (LstCtrl.Length > 0)
            {
                oEasyNavigatorHistorial.SavePageCtrlStatus(LstCtrl);
            }
            oEasyNavigatorHistorial.IrA(oEasyNavigatorBE);
            
        }
        public void Atras()
        {
            oEasyNavigatorHistorial.Atras();
        }


        public string Param(string Nombre) {
            return Page.Request.Params[Nombre];
        }

        public EasyDataInterConect TablaGeneralItem(string IdTabla,string OrigenDB) {
            EasyDataInterConect oEasyDataInterConect = new EasyDataInterConect();
            oEasyDataInterConect.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            oEasyDataInterConect.UrlWebService = this.PathNetCore + "General/General.asmx";
            oEasyDataInterConect.Metodo = "ListarTodosOracle";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdtblModulo";
            oParam.Paramvalue = IdTabla;
            oParam.TipodeDato = EasyControlWeb.EasyUtilitario.Enumerados.TiposdeDatos.Int;
            oEasyDataInterConect.UrlWebServicieParams.Add(oParam);

            oParam =new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oParam.TipodeDato = EasyControlWeb.EasyUtilitario.Enumerados.TiposdeDatos.String;
            oEasyDataInterConect.UrlWebServicieParams.Add(oParam);

            return oEasyDataInterConect;
        }
        public HtmlTable NodoTree(string GridViewID, int Nivel, string Id, string IdPadre, string Texto, bool Children)
        {
            return NodoTree(GridViewID,null,0 ,Nivel, Id, IdPadre, Texto, Children, null);
        }
        public HtmlTable NodoTree(string GridViewID,DataRow Rdata,int rowIndex, int Nivel,string Id,string IdPadre, string Texto, bool Children,string onClickFnc)
        {
            string cmll = "\"";
            HtmlTable tblNodo = new HtmlTable();
            //  int Nivel = Convert.ToInt32(dr["NIVEL"]);
            tblNodo = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(1, (Nivel + 1));
            tblNodo.Attributes["DataBE"] = "{Id:'" + Id + "',IdPadre:'" + IdPadre + "',Texto:'" + Texto + "',IdNivel:'" + Id + "." + "',Nivel:'" + Nivel.ToString() + "',IsFather:'" + ((Children==true)? "true":"false") + "'}";
            tblNodo.Attributes["width"] = "100%";
            //  tblNodo.Attributes["border"]="2";
            tblNodo.Rows[0].Cells[Nivel].InnerText = Texto;
            if (Rdata != null) {
                tblNodo.Rows[0].Cells[Nivel].Attributes.Add("Data",EasyUtilitario.Helper.Genericos.DataRowToStringJson(Rdata).Replace(cmll,"'"));
            }
            if (onClickFnc != null)
            {
                tblNodo.Rows[0].Cells[Nivel].Attributes.Add(EasyUtilitario.Enumerados.EventosJavaScript.ondblclick.ToString(), GridViewID +"_" + rowIndex.ToString() + "_CellText(this)");
            }

            tblNodo.Rows[0].Cells[Nivel].Align = "left";
            tblNodo.Rows[0].Cells[Nivel].Attributes["style"] = "padding-left: 5px;";

            tblNodo.Rows[0].Cells[Nivel].Style.Add("white-space", "nowrap");
            tblNodo.Rows[0].Cells[Nivel].Attributes["width"] = "100%";

            HtmlImage oImg = new HtmlImage();
            if (Children == true)
            {
                tblNodo.Rows[0].Cells[Nivel].Style.Add("font-weight", "bold");
                tblNodo.Rows[0].Cells[Nivel].Style.Add("font-size", "14px");

                //oImg.Src = EasyUtilitario.Constantes.ImgDataURL.IconTreeMinus;
                oImg.Src = EasyUtilitario.Constantes.ImgDataURL.IconTreePlus;
                oImg.Attributes["style"] = "cursor:pointer";
                oImg.Attributes[EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString()]= "(new GridViewTree('" + GridViewID + "')).ExpandeCollapse(this)";
                oImg.Attributes["id"] = Id;
                oImg.Attributes["LoadChild"] = "false";

                tblNodo.Rows[0].Cells[Nivel - 1].Controls.Add(oImg);
                tblNodo.Rows[0].Cells[Nivel - 1].Style.Add("cursor","pointer");

                for (int i = 0; i <= (Nivel - 2); i++)
                {
                    oImg = new HtmlImage();
                    oImg.Src = EasyUtilitario.Constantes.ImgDataURL.IconTreeSpace;
                    tblNodo.Rows[0].Cells[i].Controls.Add(oImg);
                }
            }
            else
            {
                for (int i = 0; i <= (Nivel - 1); i++)
                {
                    oImg = new HtmlImage();
                    oImg.Src = EasyUtilitario.Constantes.ImgDataURL.IconTreeSpace;
                    tblNodo.Rows[0].Cells[i].Controls.Add(oImg);
                }
            }
            //Crear el Script Relacionado a la 
            string CellTextOnClick = @"<script>
                                            function " + GridViewID +"_" + rowIndex.ToString() + @"_CellText(e){
                                             var CellText = jNet.get(e); 
                                             var Data = CellText.attr('Data').toString().SerializedToObject();
                                             " + onClickFnc + @"(Data);
                                            }
                                       </script>";

            Page.Controls.Add(new LiteralControl(CellTextOnClick));
            return tblNodo;
        }

        public void ValidarPagina(string Origen) {
            EasyUsuario oEasyUsuario = new EasyUsuario();
                if (oEasyUsuario.ValidaPagina()==false) {
                //throw new Exception("Ud. No cuenta con accesos a esta pagina");
                    throw new SIMAExceptionSeguridadAccesoForms("Ud. No cuenta con accesos a esta pagina");
            }
        }
        //public void LanzarException(Exception ex)
        public void LanzarException(SIMAExceptionSeguridadAccesoForms ex)
        {
            StackTrace stack = new StackTrace();
            string NombreMetodo = stack.GetFrame(0).GetMethod().Name;
            LanzarException(NombreMetodo, ex);
        }
        public void LanzarException(string Event, Exception ex)
        {
            EasyErrorControls oEasyErrorControls = new EasyErrorControls();
            string[] PagSplit = Page.Request.Url.AbsolutePath.Split('/');
            string Pagina = PagSplit[PagSplit.GetUpperBound(0)];
                string Autorizado = EasyUtilitario.Helper.Configuracion.Leer("FormsFree", Pagina);
                if ((Autorizado == null) || (Autorizado == "0"))
                {
                   
                    oEasyErrorControls.Origen = ex.TargetSite.Name;
                    string msg = ex.Message.Replace("'", "").Replace("'", "").Replace("\n", "");
                    oEasyErrorControls.Mensaje = msg;
                    oEasyErrorControls.Pagina = Pagina;
                    oEasyErrorControls.LanzarException(Event);
                }
        }
        public string GetPageName() {
            //string[] PagSplit = Page.Request.Url.AbsolutePath.Split('/');
            string[] PagSplit = HttpContext.Current.Request.Url.AbsolutePath.Split('/');
            string Pagina = PagSplit[PagSplit.GetUpperBound(0)].Replace(".aspx", "");
            return Pagina;
        }

       
        public void ErrorDisplay(SIMAExceptionSeguridadAccesoForms ex) {
            string cmll = EasyUtilitario.Constantes.Caracteres.ComillaDoble;
            oeasyMessageBox = new EasyMessageBox();
            oeasyMessageBox.ID = "Msg";
            oeasyMessageBox.Titulo = "Error";
            string msg = ex.Message.Replace("'", "").Replace("'", "").Replace("\n","");
            oeasyMessageBox.Contenido = msg;
            oeasyMessageBox.Tipo = EasyUtilitario.Enumerados.MessageBox.Tipo.AlertType;
            oeasyMessageBox.AlertStyle = EasyUtilitario.Enumerados.MessageBox.AlertStyle.modern;
            Page.Controls.Add(oeasyMessageBox);
        }

        public void ListarConstantesPagina()
        {
            string Pagina = GetPageName();
            string cmll = EasyUtilitario.Constantes.Caracteres.ComillaDoble;
            string ScriptConatantes = "";

        //ws://localhost:4649/Chat?name=erosales&Plataforma=WebID&FormId=
            /************************************************************************************************************************************/
            string DatosUsuario = "IdUsuario=" + oUsuario.IdUsuario.ToString() + "&" + "UserName=" + oUsuario.Login;
            string strParam = ((Page.ClientQueryString.Length > 0) ? Page.ClientQueryString + "&" + DatosUsuario : DatosUsuario);

            string FormCreate = @"var " + Pagina + @"={};
                                      " + Pagina + @".Name='" + Pagina + @"';
                                      " + Pagina + @".Params =  FormParams('" + strParam + @"');
                                      var GlobalEntorno={};
                                          GlobalEntorno =  " + Pagina + @";
                                          GlobalEntorno.PageName =  '" + Pagina + @"';
                                          GlobalEntorno.UserName =  '" + oUsuario.Login + @"';
                                          GlobalEntorno.PathFotosPersonal= " + cmll + this.PathFotosPersonal + cmll + @"
                                      " + Pagina + @".PathFotosPersonal = GlobalEntorno.PathFotosPersonal;
            ";
            Page.RegisterClientScriptBlock("ParamPag", "<script>\n" + FormCreate + "\n" + "</script>");

            /*Registrar Ref path webservice-------------------------------------------------------------------------------------------------------*/
            string PathWSCore = this.PathNetCore;
            string WebServiceCliente = @"var ConnectService={};
                                          ConnectService.PathNetCore='" + PathWSCore + @"'
                                          ConnectService.ControlInspeccionesSoapClient='" + PathWSCore +  @"GestionCalidad/ControlInspecciones.asmx';
                                          ConnectService.GeneralSoapClient='" + PathWSCore + @"General/General.asmx';
                                    ";
            Page.RegisterClientScriptBlock("WebService", "<script>\n" + WebServiceCliente + "\n" + "</script>");
            /*-------------------------------------------------------------------------------------------------------------------------------------*/
           

            string LogCliente =  Pagina + @".Trace= {};
                             " + Pagina + @".Trace.Log  = {};
                             " + Pagina + @".Trace.Log.Find = function (_Key,NodoId) {
                                                                                var NodoEncontrado = null;
                                                                                var NodoCollection = new Array();
                                                                                var DataLog = localStorage.getItem(UsuarioBE.UserName +_Key)
                                                                                var ArrLog = new Array();
                                                                                var Encontrado = false;

                                                                                if (DataLog!=null) {
                                                                                    ArrLog = DataLog.split('@');
                                                                                    ArrLog.forEach(function (item, p) {
                                                                                        var NodoBE = item.toString().SerializedToObject();
                                                                                        if (NodoBE.id.toString().Equal(NodoId)) {
                                                                                            Encontrado = true;
                                                                                            NodoEncontrado = NodoBE;
                                                                                        }
                                                                                        else {
                                                                                            NodoCollection.Add(NodoBE);
                                                                                        }
                                                                                    });
                                                                                    return { NodoBE: NodoEncontrado, DBLog: NodoCollection };
                                                                                }
                                                                                return { NodoBE: null, DBLog: NodoCollection };
                                                                            }
                                        " + Pagina + @".Trace.Log.Save = function (_Key,LogBECollections) {
                                                                                var strLog = '';
                                                                                LogBECollections.DBLog.forEach(function (item, i) {
                                                                                    strLog += ((i == 0) ? '' : '@') + item.Serialized(item,false);
                                                                                });
                                                                                localStorage.setItem(UsuarioBE.UserName + _Key, strLog);
            
                                                                                }
                                        " + Pagina + @".Trace.Log.Clear = function (_Key) {
                                                                                    localStorage.removeItem(UsuarioBE.UserName + _Key);
                                                                                }
                                        GlobalEntorno.Storage = " + Pagina + @".Trace;

                                        ";
            Page.RegisterClientScriptBlock("LogLocal", "<script>\n" + LogCliente + "\n" + "</script>");
            /*-------------------------------------------------------------------------------------------------------------------------------------*/

            /* List<FieldInfo> fl = this.GetType().GetFields(BindingFlags.Public | BindingFlags.Static | BindingFlags.FlattenHierarchy)
                                 .Where(fi => fi.IsLiteral && !fi.IsInitOnly && fi.IsSecurityTransparent == false).ToList();*/

            List<FieldInfo> fl = this.GetType().GetFields(BindingFlags.Public | BindingFlags.Static | BindingFlags.FlattenHierarchy)
                                                        .Where(fi =>fi.IsSecurityTransparent == false).ToList();
            foreach (FieldInfo fi in fl)
            {
                //ScriptConatantes += Pagina + EasyUtilitario.Constantes.Caracteres.Punto + fi.Name + EasyUtilitario.Constantes.Caracteres.SignoIgual + cmll + fi.GetRawConstantValue().ToString().Trim() + cmll + EasyUtilitario.Constantes.Caracteres.PuntoyComa + "\n";
                ScriptConatantes += Pagina + EasyUtilitario.Constantes.Caracteres.Punto + fi.Name + EasyUtilitario.Constantes.Caracteres.SignoIgual + cmll + fi.GetValue(this) + cmll + EasyUtilitario.Constantes.Caracteres.PuntoyComa + "\n";
            }
             ScriptConatantes += Pagina + EasyUtilitario.Constantes.Caracteres.Punto + "ModoEdit= " + cmll + this.ModoPagina + cmll + ";";

            // ScriptConatantes += Pagina + EasyUtilitario.Constantes.Caracteres.Punto + "PathFotosPersonal = " + cmll + EasyUtilitario.Helper.Configuracion.PathFotos + cmll;

            Page.RegisterClientScriptBlock("ConstPag", "<script>\n" + ScriptConatantes + "\n" + "</script>");

            //Registra Usuario logueado
            //  UsuarioBE oUsuarioBE = (new SeguridadSoapClient()).GetDatosUsuario(this.UsuarioId);

            UsuarioBE oUsuarioBE = (UsuarioBE)Session["UserBE"];

            string ScriptUser = @" var UsuarioBE ={};
                                        UsuarioBE.IdUsuario =  " + this.UsuarioId + @";
                                        UsuarioBE.UserName  = '" + this.UsuarioLogin + @"';
                                        UsuarioBE.IdPersonal =  " + oUsuarioBE.IdPersonal + @";
                                        UsuarioBE.ApellidosyNombres = '" + oUsuarioBE.ApellidosyNombres + @"';
                                        UsuarioBE.IdCentrOperativo = '" + oUsuarioBE.IdCentroOperativo + @"';
                                        UsuarioBE.NroDocumento = '" + oUsuarioBE.NroDocumento + @"';
                                        UsuarioBE.CodPersonal = '" + oUsuarioBE.CodPersonal + @"'; 
                                        UsuarioBE.IdContacto = '" + oUsuarioBE.IdContacto.ToString() +"'; ";

            Page.RegisterClientScriptBlock("UserInfo", "<script>\n" + ScriptUser + "\n" + "</script>");




        }

        public string UpperCaseFirstChar(string text)
        {
            return Regex.Replace(text, " ^ [a-z]", m => m.Value.ToUpper());
        }

        public  void EntityInJavascriptFromServer(System.Type t)
        {
            string LstProperty = "";
            string LstParametros = "";
            string NombreBE = t.Name;

            string PropertyBase = "";
            string NomField = "";

            BindingFlags flags = BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Instance;
            foreach (FieldInfo F in t.GetFields(flags)) // Aqui ocurre la magia :)           
            {
                NomField = F.Name.Substring(0, (F.Name.Length - 5));
                NomField = this.UpperCaseFirstChar(NomField);
                LstParametros += "_" + NomField + EasyUtilitario.Constantes.Caracteres.Coma;
                LstProperty += "this." + NomField + EasyUtilitario.Constantes.Caracteres.SignoIgual + "_" + NomField + EasyUtilitario.Constantes.Caracteres.PuntoyComa + "\n";
            }

            //Prpiedades de la clase heredada
            flags = BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public |BindingFlags.NonPublic | BindingFlags.FlattenHierarchy |BindingFlags.DeclaredOnly;
            //FieldInfo[] fl = t.BaseType.GetFields(flags);
           
            foreach (FieldInfo F in t.BaseType.GetFields(flags))
            {
                NomField = F.Name.Substring(0, (F.Name.Length - 5));
                NomField = this.UpperCaseFirstChar(NomField);
                LstParametros += "_" + NomField + EasyUtilitario.Constantes.Caracteres.Coma;
                LstProperty += "this." + NomField + EasyUtilitario.Constantes.Caracteres.SignoIgual + "_" + NomField + EasyUtilitario.Constantes.Caracteres.PuntoyComa + "\n";

            }

            string ScriptBE = "function " + NombreBE + "(" + LstParametros.Substring(0, LstParametros.Length - 1) + @"){" + "\n" + @"
                                     " + LstProperty + @"
                                }" + "\n";

            EasyUtilitario.Helper.Pagina.DEBUG(ScriptBE);

            Page.RegisterClientScriptBlock("Entity", "<script>\n" + ScriptBE + "\n" + "</script>");
        }

        #region Agentes JavaScript
                public void DataTableToXML(DataTable dt)
                {

                    try
                    {
                        TransformsData(dt);
                    }
                    catch (Exception ex)
                    {
                        TransformsData(EasyUtilitario.Helper.Data.Error(this.GetPageName(), ex.Message));
                    }
                }
                public void EntityToXML(object obj)
                {
                    string returnCarr = EasyUtilitario.Constantes.Caracteres.RetornoCarr;
                    string cmll = EasyUtilitario.Constantes.Caracteres.ComillaDoble;
                    try
                    {
                        string Structura = "<DocumentElement>";
                        if (obj == null)
                        {
                            Structura += "<Error>";
                            Structura += returnCarr;
                            Structura += "<Number>0001</Number>";
                            Structura += returnCarr;
                            Structura += "<Descripcion>No DataFound</Descripcion>";
                            Structura += returnCarr;
                            Structura += "</Error>";
                            Structura += returnCarr;
                        }
                        else
                        {
                            Type typeData = obj.GetType();
                            int idx = 0;
                            Structura += "<Entity Name='" + typeData.Name + "'>";
                            Structura += returnCarr;
                            foreach (var propertyInfo in typeData.GetProperties())
                            {
                                if (propertyInfo.GetValue(obj, propertyInfo.GetIndexParameters()) != null)
                                {
                                    Structura += "<" + propertyInfo.Name.ToString() + ">" + propertyInfo.GetValue(obj, propertyInfo.GetIndexParameters()) + "</" + propertyInfo.Name.ToString() + ">";
                                }
                                else
                                {
                                    Structura += "<" + propertyInfo.Name.ToString() + "/>";
                                }
                                Structura += returnCarr;
                            }
                            Structura += "</Entity>";
                        }
                        Structura += "</DocumentElement>";

                        TransformsData(Structura);
                    }
                    catch (Exception ex)
                    {
                        TransformsData(EasyUtilitario.Helper.Data.Error(this.GetPageName(), ex.Message));
                    }
                }
                public void DiccionaryToEntityJS(string strEntity)
                {
                    string returnCarr = EasyUtilitario.Constantes.Caracteres.RetornoCarr;
                    string cmll = EasyUtilitario.Constantes.Caracteres.ComillaDoble;
                    try
                    {
                        string Structura = "<DocumentElement>";
                                Structura += returnCarr;
                                Structura += "<DictionaryBE Name='objJava'>";
                                Structura += returnCarr;
                                Structura += "<Esquema>" + strEntity + "</Esquema>";
                                Structura += returnCarr;
                                Structura += "</DictionaryBE>";
                                Structura += returnCarr;
                                Structura += "</DocumentElement>";

                        TransformsData(Structura);
                    }
                    catch (Exception ex)
                    {
                        TransformsData(EasyUtilitario.Helper.Data.Error(this.GetPageName(), ex.Message));
                    }
                }

        public void SetData(DataRow drData) {
            string cmll = "\"";
            string strData = EasyUtilitario.Helper.Genericos.DataRowToStringJson(drData).Replace(cmll, "'");
            strData = strData.Replace(((char)10).ToString(), "");
            strData = strData.Replace(((char)13).ToString(), "");

            string DataBE = "<script>\n" +  GetPageName() +".Data=" + strData +  "\n </script>";
            Page.Controls.Add(new LiteralControl(DataBE));
        }

                public void EntityServerToEntityJS(object objResultBE) {
                    string returnCarr = EasyUtilitario.Constantes.Caracteres.RetornoCarr;
                    string Structura = "<Esquema>";
                           Structura += returnCarr;
                            Structura += "<Entity>";
                            Structura += returnCarr;

                                Type tModelType = objResultBE.GetType();
                                FieldInfo[] thisFieldInfo = objResultBE.GetType().GetFields(BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Instance);
                                foreach (FieldInfo property in thisFieldInfo)
                                {
                                    try
                                    {
                                        if (property.GetValue(objResultBE) != null)
                                        {
                                            Structura += "<" + property.Name + ">" + property.GetValue(objResultBE).ToString() + "</" + property.Name + ">";
                                            Structura += returnCarr;
                                        }
                                        else {
                                            Structura += "<" + property.Name + ">" + "" + "</" + property.Name + ">";
                                            Structura += returnCarr;

                                        }

                                    }
                                    catch (System.NullReferenceException  Nullex) {
                                        Structura += "<" + property.Name + ">" + "" + "</" + property.Name + ">";
                                        Structura += returnCarr;

                                    }
                                }
                        Structura += "</Entity>";
                        Structura += returnCarr;
                        Structura += "</Esquema>";

                        TransformsData(Structura);

                    }




                public void ResultNonQuery(string strValue)
                {
                    string returnCarr = EasyUtilitario.Constantes.Caracteres.RetornoCarr;
                    string cmll = EasyUtilitario.Constantes.Caracteres.ComillaDoble;
                    try
                    {
                        string Structura = "<DocumentElement>";
                        Structura += returnCarr;
                        Structura += "<NonQuery Name='objJava'>";
                        Structura += returnCarr;
                        Structura += "<Result>" + strValue + "</Result>";
                        Structura += returnCarr;
                        Structura += "</NonQuery>";
                        Structura += returnCarr;
                        Structura += "</DocumentElement>";

                        TransformsData(Structura);
                    }
                    catch (Exception ex)
                    {
                        TransformsData(EasyUtilitario.Helper.Data.Error(this.GetPageName(), ex.Message));
                    }
                }

        public void ErrorToXML(string ErroNumber,string Origen,Exception ex)
                {
                    string returnCarr = EasyUtilitario.Constantes.Caracteres.RetornoCarr;
                    string Structura = "<DocumentElement>";
                            Structura += "<Error>";
                            Structura += returnCarr;
                            Structura += "<Number>" + ErroNumber  + "</Number>";
                            Structura += returnCarr;
                            Structura += "<Origen>" + Origen + "</Origen>";
                            Structura += returnCarr;
                            Structura += "<Descripcion>" +ex.Message + "</Descripcion>";
                            Structura += returnCarr;
                            Structura += "</Error>";
                            Structura += returnCarr;
                    Structura += "</DocumentElement>";
                    TransformsData(Structura);
                }

                 void TransformsData(string StrSerializado)
                {
                    HttpContext.Current.Response.ClearContent();
                    HttpContext.Current.Response.Buffer = true;
                    // Response.AddHeader("content-disposition", "attachment; filename=DemoExcel.xls");
                    HttpContext.Current.Response.ContentType = "text/xml"; ;
                    HttpContext.Current.Response.Charset = "";
                    HttpContext.Current.Response.Output.Write(StrSerializado);
                    HttpContext.Current.Response.Flush();
                    HttpContext.Current.Response.Close();

                }

                void TransformsData(DataTable dt)
                {
                    string result;
                    using (StringWriter sw = new StringWriter())
                    {
                        if (dt != null)
                        {
                            dt.WriteXml(sw);
                            result = sw.ToString();
                        }
                        else {
                            result = "NoDataFound";
                        }
                    }
                    HttpContext.Current.Response.ClearContent();
                    HttpContext.Current.Response.Buffer = true;
                    // Response.AddHeader("content-disposition", "attachment; filename=DemoExcel.xls");
                    HttpContext.Current.Response.ContentType = "text/xml"; ;
                    HttpContext.Current.Response.Charset = "";
                    HttpContext.Current.Response.Output.Write(result);
                    HttpContext.Current.Response.Flush();
                    HttpContext.Current.Response.Close();
        }
        #endregion



        #region Registrar Lib script style etc
        public enum TipoLibreria
        {
            Style,
            Script,
            ScriptFrag,
        }

        string[,] TagCtrl = new string[2, 5] {{ "link","href" ,"rel","stylesheet","Estylos Base"}
                                                  ,{ "script","src" ,"type", "text/javascript","Scripts Base"}
                                                 };




        public void RegistrarLib(HtmlHead oPagina, TipoLibreria oTipoLib, string[,] LibRef, bool Secuencia)
        {
            Type csType = this.GetType();
            ClientScriptManager cs = Page.ClientScript;
            int idxTag = ((oTipoLib == TipoLibreria.Style) ? 0 : 1);
            string cmll = EasyUtilitario.Constantes.Caracteres.ComillaDoble;
            for (int i = 0; i < LibRef.GetLength(0); i++)
            {
                if (!cs.IsClientScriptBlockRegistered(csType, LibRef[i, 0]))
                {
                    StringBuilder csText = new StringBuilder();
                    csText.Append("<" + TagCtrl[idxTag, 0] + " " + TagCtrl[idxTag, 2] + "=" + cmll + TagCtrl[idxTag, 3] + cmll + " " + TagCtrl[idxTag, 1] + "=" + cmll + LibRef[i, 1] + cmll + "> </" + TagCtrl[idxTag, 0] + ">\n");
                    cs.RegisterClientScriptBlock(csType, LibRef[i, 0], csText.ToString());
                }

            }
        }

        public void RegistrarLib(HtmlHead oPagina, TipoLibreria oTipoLib, string[,] LibRef)
        {

            int idxTag = ((oTipoLib == TipoLibreria.Style) ? 0 : 1);
            try
            {
                if (oPagina != null)
                {
                    switch (oTipoLib)
                    {
                        case TipoLibreria.Style:
                        case TipoLibreria.Script:
                            oPagina.Controls.Add(new LiteralControl("\n"));
                            oPagina.Controls.Add(new LiteralControl("<!--Registros de " + TagCtrl[idxTag, 4] + "-->\n"));
                            for (int i = 0; i < LibRef.GetLength(0); i++)
                            {
                                HtmlGenericControl CtrlLib = new HtmlGenericControl(TagCtrl[idxTag, 0]);
                                CtrlLib.Attributes["id"] = LibRef[i, 0];
                                CtrlLib.Attributes[TagCtrl[idxTag, 1]] = LibRef[i, 1];
                                CtrlLib.Attributes[TagCtrl[idxTag, 2]] = TagCtrl[idxTag, 3];
                                oPagina.Controls.Add(CtrlLib);

                                oPagina.Controls.Add(new LiteralControl("\n"));
                            }
                            break;
                        case TipoLibreria.ScriptFrag:
                            oPagina.Controls.Add(new LiteralControl("<script>\n"));
                            for (int i = 0; i < LibRef.GetLength(0); i++)
                            {
                                oPagina.Controls.Add(new LiteralControl(LibRef[i, 0] + "\n"));
                            }
                            oPagina.Controls.Add(new LiteralControl("</script>\n"));
                            break;
                    }
                }
            }
            catch (Exception ex)
            {

            }

       
        }


        #endregion


    }

}