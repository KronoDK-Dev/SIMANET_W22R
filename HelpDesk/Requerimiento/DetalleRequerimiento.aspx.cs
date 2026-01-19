using EasyControlWeb.Filtro;
using EasyControlWeb;
using EasyControlWeb.Form.Controls;
using EasyControlWeb.InterConeccion;
using EasyControlWeb.InterConecion;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using SIMANET_W22R.HelpDesk.ITIL;
using Newtonsoft.Json.Linq;
using System.Net.Http;
using System.Net;
using System.Text;
using SIMANET_W22R.HelpDesk.Sistemas;
using SIMANET_W22R.srvHelpDesk;


namespace SIMANET_W22R.HelpDesk.Requerimiento
{
    public partial class DetalleRequerimiento : HelpDeskBase,IPaginaBase,IPaginaMantenimento
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            try {
                this.LlenarJScript();
                this.LlenarDatos();               
                this.CargarModoPagina();
            }
            catch(Exception ex) {
                int i = 0;
            }

        }

        public void CargarModoModificar()
        {
            EasyBaseEntityBE oEasyBaseEntityBE = CargarDetalle(this.UsuarioId.ToString(), this.IdRequerimiento);
            this.EasytxtTicket.SetValue(oEasyBaseEntityBE.GetValue("NroTicket"));

            string[] PathItem = oEasyBaseEntityBE.GetValue("PathServicio").ToString().Split('|');
            List<string> list = PathItem.ToList();
            list.Reverse();
            foreach (string str in list)
            {
                EasyPathItem oEasyPathItem = new EasyPathItem();
                oEasyPathItem.Id = str.Replace(" ", "");
                oEasyPathItem.ClassName = "fa fa-venus-mars";
                oEasyPathItem.Descripcion = "";
                oEasyPathItem.Titulo = str;

                this.EasyPathHistory1.PathCollections.Add(oEasyPathItem);
            }
            this.EasyPathHistory1.PathHome = true;
            this.EasyPathHistory1.TipoPath = PathStyle.Tradicional;
            this.EasyTxtDescripcion.SetValue(oEasyBaseEntityBE.GetValue("Descripcion"));
            this.txtIdServicioArea.SetValue(oEasyBaseEntityBE.GetValue("IdServicioArea"));
            


        }
        public EasyBaseEntityBE CargarDetalle(string IdUsuarioReq, string IdReq)
        {
            return CargarDetalle(IdUsuarioReq, IdReq, this.UsuarioLogin);
        }
       public  EasyBaseEntityBE CargarDetalle(string IdUsuarioReq,string IdReq,string UserName)
        {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/HelpDesk/AdministrarHD.asmx";
            odi.Metodo = "Requerimientos_Det";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdUsuario";
            oParam.Paramvalue = IdUsuarioReq;//this.UsuarioId.ToString();
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdRequerimiento";
            oParam.Paramvalue = IdReq;// this.IdRequerimiento;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = UserName;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);
            return odi.GetEntity();
        }

        public DataTable ListarAprobadores(string _IdRequerimiento)
        {
            return ListarAprobadores(_IdRequerimiento, this.UsuarioLogin);
        }
        public DataTable ListarAprobadores(string _IdRequerimiento, string UserName) {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/HelpDesk/AdministrarHD.asmx";
            odi.Metodo = "Requerimientos_Aprobador_Lst";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdRequerimiento";
            oParam.Paramvalue = _IdRequerimiento;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = UserName; 
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);
            return odi.GetDataTable();
        }
        DataTable ListarArchivos()
        {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/HelpDesk/AdministrarHD.asmx";
            odi.Metodo = "Requerimientos_File_Lst";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdRequerimiento";
            oParam.Paramvalue = this.IdRequerimiento;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);
            return odi.GetDataTable();
        }


        public void CargarModoNuevo()
        {
            this.EasyPathHistory1.PathHome = true;
            this.EasyPathHistory1.TipoPath = PathStyle.Tradicional;
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
            foreach (DataRow dr in ListarAprobadores(this.IdRequerimiento).Rows)
            {
                string Item = EasyUtilitario.Helper.Genericos.DataRowToStringJson(dr);
               // string Item = "{ApellidosyNombres:'" + dr["ApellidosyNombres"].ToString() +"',IdPersonalO7:'" + dr["IdPersonalO7"].ToString() + "',NroDocIdentidad:'" + dr["NroDocIdentidad"].ToString() + "'}";
                Dictionary<string, string> oData = EasyUtilitario.Helper.Data.SeriaizedDiccionario(Item);
                
                EasyListItem LItem = new EasyListItem("", oData[this.EasyAcBuscarPersonal.DisplayText], oData[this.EasyAcBuscarPersonal.ValueField]);
                LItem.DataComplete = oData;
                this.EasyAcBuscarPersonal.ListItems.Add(LItem);

            }
            //Listar Archivos            
            foreach (DataRow dr in ListarArchivos().Rows)
            {
                //string Item = EasyUtilitario.Helper.Genericos.DataRowToStringJson(dr);
                string NombreFile = dr["nombre"].ToString();
                string []DFile = NombreFile.Split('.');
                string ext = DFile[DFile.Length - 1];
                EasyFileInfo oEasyFileInfo = new EasyFileInfo();
                oEasyFileInfo.IdFile=dr["id_attach"].ToString();
                oEasyFileInfo.Nombre = dr["nombre"].ToString();
                oEasyFileInfo.Tipo = ext;
                this.EasyUpLoadMultiple1.FileCollections.Add(oEasyFileInfo);

            }
        }

        public void LlenarDatos()
        {
            //this.EasyAcBuscarPersonal.DataInterconect.ConfigPathSrvRemoto = "PathBaseWSCore";
            this.EasyAcBuscarPersonal.DataInterconect.UrlWebService = this.PathNetCore + "General/Busquedas.asmx";

            EasyTabItem oTab = new EasyTabItem();
                oTab.Id = "TabDet1";
                oTab.Text = "Principa";
                oTab.TipoDisplay = TipoTab.ContentCtrl;
                oTab.Selected = true;
                oTab.AccionRefresh = false;
                oTab.Value = "Principal";
                EasyTabHDDetale.TabCollections.Add(oTab);

                oTab = new EasyTabItem();
                oTab.Id = "TabDet2";
                oTab.Text = "Anexos";
                oTab.TipoDisplay = TipoTab.ContentCtrl;
                oTab.Selected = false;
                oTab.AccionRefresh = false;
                oTab.Value = "tblUpLoad";
                EasyTabHDDetale.TabCollections.Add(oTab);


            

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
            this.txtIdServicioArea.Style.Add("display", "none");
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

        public void Agregar()
        {
            throw new NotImplementedException();
        }

        public void Modificar()
        {
            throw new NotImplementedException();
        }

        public void Eliminar()
        {
            throw new NotImplementedException();
        }

      
        public void CargarModoConsulta()
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

        public void CargarModoPagina()
        {
            switch (this.ModoPagina) {
                case EasyUtilitario.Enumerados.ModoPagina.N:
                    CargarModoNuevo();
                    break;
                case EasyUtilitario.Enumerados.ModoPagina.M:
                case EasyUtilitario.Enumerados.ModoPagina.C:
                    this.LlenarCombos();
                    this.CargarModoModificar();
                    if (this.ModoPagina == EasyUtilitario.Enumerados.ModoPagina.C)
                    {
                        ContentTool.Attributes["style"] = "display:none";
                    }
                    break;

            }
        }

        protected void EasyToolBarButtons1_onClick(EasyButton oEasyButton)
        {
            switch (oEasyButton.Id) {
                case "btnAceptar":

                    RequerimientoBE oRequerimientoBE =  new RequerimientoBE();
                    oRequerimientoBE.IdRequerimiento = this.IdRequerimiento;
                    oRequerimientoBE.IdRequerientoPadre = this.IdRequerimientPadre;
                    oRequerimientoBE.IdServicioArea = txtIdServicioArea.GetValue();
                    oRequerimientoBE.NroTicket = "";
                    oRequerimientoBE.IdPrioridadSolicitada = 1;
                    oRequerimientoBE.IdPersonal = this.DatosUsuario.CodPersonal;
                    oRequerimientoBE.Descripcion = EasyTxtDescripcion.GetValue();
                    oRequerimientoBE.IdUsuario = this.UsuarioId;
                    oRequerimientoBE.UserName = this.UsuarioLogin;
                    

                    AdministrarHDSoapClient oHelpDesk = new AdministrarHDSoapClient();
                    string IdRqr= oHelpDesk.Requerimientos_ins(oRequerimientoBE);

                    List<EasyListItem> lstPersonaAprob = this.EasyAcBuscarPersonal.GetCollection();
                    //  if (lstPersonaAprob.Count() > 0) {

                    foreach (EasyListItem olItem in lstPersonaAprob)
                    {
                        Dictionary<string, string> cData = olItem.DataComplete;

                        AprobadorBE oAprobadorBE = new AprobadorBE();
                        
                        oAprobadorBE.IdRequerimiento = IdRqr;
                            try
                            {
                                oAprobadorBE.IdResponsable = cData["ID_RESPONSABLE"];
                            }
                            catch (Exception ex)
                            {
                                oAprobadorBE.IdResponsable = "0";
                            }
                        oAprobadorBE.IdPersonal = cData["IDPERSONALO7"];
                        oAprobadorBE.IdUsuario = this.UsuarioId;
                        oAprobadorBE.UserName = this.UsuarioLogin;
                        oHelpDesk.RequerimientosAprobador_ins(oAprobadorBE);
                    }
                    // }

                    List<EasyFileInfo> lItemsFile = this.EasyUpLoadMultiple1.GetCollection();
                    //   if (lItemsFile.Count() > 0) {
                    //foreach (EasyFileInfo oEasyFileInfo in lItemsFile.FindAll(x => x.Temporal == true))
                    foreach (EasyFileInfo oEasyFileInfo in lItemsFile)
                    {
                        ArchivoAdjuntoBE oArchivoAdjuntoBE = new ArchivoAdjuntoBE();
                        oArchivoAdjuntoBE.IdFile = oEasyFileInfo.IdFile;
                        oArchivoAdjuntoBE.Nombre = oEasyFileInfo.Nombre;
                        oArchivoAdjuntoBE.Descripcion = "";
                        oArchivoAdjuntoBE.IdRequerimiento = IdRqr;
                        oArchivoAdjuntoBE.UserName = this.UsuarioLogin;
                        oArchivoAdjuntoBE.IdUsuario = this.UsuarioId;
                        int p = 0;
                        if ((oEasyFileInfo.Temporal == true) && (oEasyFileInfo.IdEstado != 0))
                        {
                            //Grabar solo los que dearon
                            oArchivoAdjuntoBE.IdEstado = 1;

                        }
                        else if ((oEasyFileInfo.Temporal == false) && (oEasyFileInfo.IdEstado == 0))
                        {
                            //Eliminar los existentes
                            oArchivoAdjuntoBE.IdEstado = 0;
                        }
                        if ((oEasyFileInfo.Existe == false) && (oEasyFileInfo.Enviado == true)) {
                            //Pasar del area Temporal al fnal
                            oHelpDesk.RequerimientosArhivo_ins(oArchivoAdjuntoBE);
                        }
                        //Pasa los archivos de la Carpeta temporal la Carpeta final
                        this.EasyUpLoadMultiple1.TemporalToFinal(oEasyFileInfo);

                    }
                    //   }


                    this.Atras();
                    break;
                case "btnCancelar":
                    this.Atras();
                    break;

            }

        }





        private  string PostRequest(string url)
        {
            HttpWebRequest httpWebRequest = (HttpWebRequest)WebRequest.Create(url);
            httpWebRequest.ContentType = "application/json; charset=utf-8";
            httpWebRequest.Method = "POST";
            httpWebRequest.Accept = "application/json; charset=utf-8";
            string sContentType = "application/json";

            JObject oJsonObject = new JObject();

            oJsonObject.Add("ReferenceId", "a123");

            HttpClient oHttpClient = new HttpClient();
            var oTaskPostAsync = oHttpClient.PostAsync(url, new StringContent(oJsonObject.ToString(), Encoding.UTF8, sContentType));

            return "";
        }


    }
}