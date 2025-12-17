using EasyControlWeb;
using EasyControlWeb.Form;
using EasyControlWeb.Form.Controls;
using iTextSharp.text.pdf.parser;
using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.srvGestionCalidad;
using SIMANET_W22R.srvSeguridad;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestiondeCalidad
{
    public partial class DetalleInspeccion : PaginaCalidadBase, IPaginaBase
    {
        //public string IdInspeccion { get { return this.Param(PaginaCalidadBase.KEYIDINSPECCION); } }
        EasyFormDataBE oFormDataBE  = new EasyFormDataBE();
        new EasyMessageBox oeasyMessageBox;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                this.LlenarDatos();
                this.LlenarJScript();

                /*  List<EasyNavigatorBE> oEasyNavigatorBElst = new List<EasyNavigatorBE>();
                try
                {
                    string s = "";
                    oEasyNavigatorBElst = (List<EasyNavigatorBE>)Session[EasyUtilitario.Constantes.Sessiones.Historial];
                    foreach (EasyNavigatorBE onbe in oEasyNavigatorBElst) {
                        s += onbe.LstCtrlValue;
                    }
                    Exception ex = new Exception(s);
                    ErrorDisplay(ex);
                }
                catch (Exception ex)
                {
                    this.LanzarException("Page_Load.LlenarDatos.CargarModoModificar", ex);
                }


               SIMANET_W22R.GestiondeCalidad.Proceso ows = new SIMANET_W22R.GestiondeCalidad.Proceso();
                 DataTable d = ows.BuscarActividad("Act", "erosales");*/


                ///List<EasyNavigatorBE> oHistorial = (List<EasyNavigatorBE>)Session["S_Historial"];
            }
        }

        protected void EasyForm1_CommitTransaccion(EasyButton oEasyButton, EasyControlWeb.Form.EasyFormDataBE oEasyFormDataBE)
        {
            oFormDataBE = oEasyFormDataBE;
            if (oEasyButton.Texto == "Aceptar")
            {
                switch (this.ModoPagina)
                {
                    case EasyUtilitario.Enumerados.ModoPagina.N:
                        Agregar();
                        break;
                    case EasyUtilitario.Enumerados.ModoPagina.M:
                        if (this.ModoEditable == 1)
                        {
                            Modificar();
                        }
                        else {
                            oeasyMessageBox = new EasyMessageBox();
                            oeasyMessageBox.ID = "msgb";
                            oeasyMessageBox.Titulo = "ACCIONES NO PERMITIDAS";
                            oeasyMessageBox.Contenido = "No esta permitido realizar modifificación a este registro de inspección coordinar con el responsable..";
                            oeasyMessageBox.Tipo = EasyUtilitario.Enumerados.MessageBox.Tipo.AlertType;
                            oeasyMessageBox.AlertStyle = EasyUtilitario.Enumerados.MessageBox.AlertStyle.modern;
                            Page.Controls.Add(oeasyMessageBox);
                        }
                        break;
                }
            }
            else {
                this.Atras();
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

        public void LlenarCombos()
        {
            throw new NotImplementedException();
        }

        public void LlenarDatos()
        {
            switch (this.ModoPagina) {
                case EasyUtilitario.Enumerados.ModoPagina.N:
                    CargarModoNuevo();
                    break;
                case EasyUtilitario.Enumerados.ModoPagina.M:
                    CargarModoModificar();
                    break;
            }
        }
        public void CargarModoNuevo()
        {
            
            try
            {
                if (this.IdInspeccion!="0")
                {
                    ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
                    InspeccionBE oInspeccionBE = oCalidad.Inspeccion_Detalle(this.IdInspeccion,this.UsuarioId, this.UsuarioLogin);
                    EasyForm1.SetValue("aucProyecto", oInspeccionBE.NombreProyecto, oInspeccionBE.IdProyecto.ToString());
                    EasyForm1.SetValue("txtNroProy", oInspeccionBE.NroProyecto);
                    EasyForm1.SetValue("txtLN", oInspeccionBE.LineadeNegocio);
                    EasyForm1.SetValue("txtCliente", oInspeccionBE.ClienteRazonSocial);

                    EasyForm1.SetReadOnly("aucProyecto");
                    EasyForm1.SetReadOnly("txtNroProy");
                    EasyForm1.SetReadOnly("txtLN");
                    EasyForm1.SetReadOnly("txtCliente");

                }

            }
            catch (Exception ex)
            {
                this.LanzarException("Page_Load.LlenarDatos.CargarModoNuevo", ex);
            }

        }
        public void CargarModoModificar()
        {
            try
            {
                ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
                InspeccionBE oInspeccionBE = oCalidad.Inspeccion_Detalle(this.IdInspeccion,this.UsuarioId, this.UsuarioLogin);
                EasyForm1.SetValue("aucProyecto", oInspeccionBE.NombreProyecto, oInspeccionBE.IdProyecto.ToString());
                EasyForm1.SetValue("txtNroProy", oInspeccionBE.NroProyecto);
                EasyForm1.SetValue("txtLN", oInspeccionBE.LineadeNegocio);
                EasyForm1.SetValue("txtCliente", oInspeccionBE.ClienteRazonSocial);
                EasyForm1.SetValue("TxtNroReporte", oInspeccionBE.NroReporte);
                EasyForm1.SetValue("dpFechaInspeccion", oInspeccionBE.FechaInspeccion.ToShortDateString());
                EasyForm1.SetValue("ddlTipoInpeccion", oInspeccionBE.IdTipoInspeccion.ToString());
                EasyForm1.SetValue("ddlTipoProceso", oInspeccionBE.IdTipoProceso.ToString());
                EasyForm1.SetValue("ddTipoSistema", oInspeccionBE.IdTipoSistema.ToString());
                EasyForm1.SetValue("ddlNorma", oInspeccionBE.IdNormaClausula.ToString());
                EasyForm1.SetValue("txtDescripcion", oInspeccionBE.Descripcion);
                EasyForm1.SetValue("txtRecomendaciones", oInspeccionBE.Recomendacion);
                EasyForm1.SetValue("ddlClasificacion", oInspeccionBE.IdTipoClasificacion.ToString());
                EasyForm1.SetValue("aucBuscaTallerContrat", oInspeccionBE.NombreAreaEntidad, "xx");//No me interesa establecer el valor de values por que los datos reelevatees estan en el recordser
                Dictionary<string, string> RecordSet = new Dictionary<string, string>();
                RecordSet["IdOrigen"] = oInspeccionBE.IdOrigen.ToString();
                RecordSet["IdEntidad"] = oInspeccionBE.IdEntidad.ToString();
                EasyForm1.SetDataRow("aucBuscaTallerContrat", RecordSet);

                //Cargar los archivos anexos
                DataTable dt = oCalidad.ListarInspeccionAnexos(this.IdInspeccion, this.UsuarioLogin);
                if(dt!=null){
                    List<EasyFileInfo> allEasyFileInfo = new List<EasyFileInfo>();
                    foreach (DataRow dr in dt.Rows)
                    {
                        EasyFileInfo oEasyFileInfo = new EasyFileInfo();
                        oEasyFileInfo.IdFile = dr["IdAnexo"].ToString();
                        oEasyFileInfo.Nombre = dr["Archivo"].ToString();
                        oEasyFileInfo.Temporal = false;
                        oEasyFileInfo.IdEstado = 1;
                        allEasyFileInfo.Add(oEasyFileInfo);
                    }
                    EasyForm1.SetValue("EasyUpLoad1", allEasyFileInfo);
                }
            }
            catch (Exception ex)
            {
                this.LanzarException("Page_Load.LlenarDatos.CargarModoModificar",ex);
            }
        }

        public int Agregar() {
            try
            {
                ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
                InspeccionBE oInspeccionBE = new InspeccionBE();
                oInspeccionBE.IdInspeccionPadre = this.IdInspeccion;//para el caso de nuevo reg este parametro contiene id de la inspeccion padre
                oInspeccionBE.IdProyecto = Convert.ToInt32(EasyForm1.GetValue("aucProyecto"));
                oInspeccionBE.FechaInspeccion  = Convert.ToDateTime(EasyForm1.GetValue("dpFechaInspeccion"));
                oInspeccionBE.IdTipoInspeccion =  Convert.ToInt32(EasyForm1.GetValue("ddlTipoInpeccion"));
                oInspeccionBE.IdTipoProceso = Convert.ToInt32(EasyForm1.GetValue("ddlTipoProceso"));
                oInspeccionBE.IdTipoSistema = Convert.ToInt32(EasyForm1.GetValue("ddTipoSistema"));
                oInspeccionBE.IdTipoClasificacion = Convert.ToInt32(EasyForm1.GetValue("ddlClasificacion"));

                oInspeccionBE.IdNormaClausula = Convert.ToInt32(EasyForm1.GetValue("ddlNorma"));
                oInspeccionBE.Descripcion = EasyForm1.GetValue("txtDescripcion").ToString();
                oInspeccionBE.Recomendacion =  EasyForm1.GetValue("txtRecomendaciones").ToString();
                Dictionary<string, string> RecordSet = (Dictionary<string, string>)EasyForm1.GetDataRow("aucBuscaTallerContrat");
                //EasyUtilitario.Helper.Pagina.DEBUG(RecordSet["IdOrigen"].ToString());
                oInspeccionBE.IdOrigen = Convert.ToInt32(RecordSet["IdOrigen"].ToString());
                oInspeccionBE.IdEntidad = Convert.ToInt32(RecordSet["IdCodigo"].ToString());
                oInspeccionBE.IdUsuario = this.UsuarioId;


               // return 1;

                string  IdInspeccionResult = oCalidad.Inspeccion_Insertar(oInspeccionBE);
                if (IdInspeccionResult != "-1") {
                    UsuarioBE oUsuarioBE = new UsuarioBE();
                    oUsuarioBE = (UsuarioBE)Session["UserBE"];

                    //Inserta al usuario logueado como Inspector por defecto------------------------------------------
                    InspectorBE oInspectorBE = new InspectorBE();
                        oInspectorBE.IdInspeccion = IdInspeccionResult;
                        oInspectorBE.IdInspector = "0";
                        oInspectorBE.IdPersonal = oUsuarioBE.IdPersonal;
                        oInspectorBE.Principal = 1;
                        oInspectorBE.IdUsuario = this.UsuarioId;
                        oInspectorBE.UserName = this.UsuarioLogin;
                        oInspectorBE.IdEstado = 1;
                    oCalidad.Inspeccion_ModificarInsertarInspector(oInspectorBE);

                    //Inserta Aprobador por default----------------------------------------------------------------------
                    
                    UsuarioFirmanteBE oUsuarioFirmanteBE = new UsuarioFirmanteBE();
                        oUsuarioFirmanteBE.IdInspeccion = IdInspeccionResult;
                        oUsuarioFirmanteBE.IdPersonaFirmante = oUsuarioBE.IdPersonal;
                        oUsuarioFirmanteBE.IdTipoFirmante = 1;//1 es Inspector
                        oUsuarioFirmanteBE.Descripcion = Descripcion;
                        oUsuarioFirmanteBE.Firma = "";
                        oUsuarioFirmanteBE.IdUsuario = this.UsuarioId;
                        oUsuarioFirmanteBE.UserName = this.UsuarioLogin;
                        oUsuarioFirmanteBE.IdEstado = 3;
                    oCalidad.ModificaInsertaUsuariosFirmantes(oUsuarioFirmanteBE);

                    //Inserta Lista de arcvhivos anexos
                    List<EasyFileInfo> allFiles = (List<EasyFileInfo>)EasyForm1.GetListItems("EasyUpLoad1");
                    int Orden = 0;
                    if (allFiles != null)
                    {
                        foreach (EasyFileInfo oEasyFileInfo in allFiles)
                        {
                            if (oEasyFileInfo.Nombre.Length > 0)
                            {
                                InspeccionAnexoBE oInspeccionAnexoBE = new InspeccionAnexoBE();
                                oInspeccionAnexoBE.IdInspeccion = IdInspeccionResult;
                                oInspeccionAnexoBE.IdUsuario = this.UsuarioId;
                                oInspeccionAnexoBE.Archivo = oEasyFileInfo.Nombre;
                                oInspeccionAnexoBE.IdAnexo = oEasyFileInfo.IdFile;
                                oInspeccionAnexoBE.Orden = Orden;
                                string ids = oCalidad.AdministrarInspeccionAnexos(oInspeccionAnexoBE);
                                Orden++;
                            }
                        }
                    }
                    this.Atras();
                }
            }
            catch (Exception ex)
            {
                this.LanzarException("EasyForm1_CommitTransaccion.Agregar", ex);
            }
            return 0;
        }
        public int Modificar() {
            try
            {
                ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();

                InspeccionBE oInspeccionBE = new InspeccionBE();
                oInspeccionBE.IdInspeccion= this.IdInspeccion;
                oInspeccionBE.FechaInspeccion = Convert.ToDateTime(EasyForm1.GetValue("dpFechaInspeccion"));
                oInspeccionBE.IdProyecto = Convert.ToInt32(EasyForm1.GetValue("aucProyecto"));                
                oInspeccionBE.IdTipoInspeccion = Convert.ToInt32(EasyForm1.GetValue("ddlTipoInpeccion"));
                oInspeccionBE.IdTipoProceso = Convert.ToInt32(EasyForm1.GetValue("ddlTipoProceso"));
                oInspeccionBE.IdTipoSistema = Convert.ToInt32(EasyForm1.GetValue("ddTipoSistema"));
                oInspeccionBE.IdTipoClasificacion = Convert.ToInt32(EasyForm1.GetValue("ddlClasificacion"));
                oInspeccionBE.IdNormaClausula = Convert.ToInt32(EasyForm1.GetValue("ddlNorma"));
                oInspeccionBE.Descripcion = EasyForm1.GetValue("txtDescripcion").ToString();
                oInspeccionBE.Recomendacion = EasyForm1.GetValue("txtRecomendaciones").ToString();
                Dictionary<string, string> RecordSet = (Dictionary<string, string>)EasyForm1.GetDataRow("aucBuscaTallerContrat");
                oInspeccionBE.IdOrigen = Convert.ToInt32(RecordSet["IdOrigen"]);
                oInspeccionBE.IdEntidad = Convert.ToInt32(RecordSet["IdEntidad"].ToString());
                oInspeccionBE.IdUsuario = this.UsuarioId;

                int Resultado = oCalidad.Inspeccion_Modificar(oInspeccionBE);

                if (Resultado != -1)
                {
                    List<EasyFileInfo> allFiles= (List<EasyFileInfo>)EasyForm1.GetListItems("EasyUpLoad1");
                    int Orden = 0;
                    foreach (EasyFileInfo oEasyFileInfo in allFiles) {
                        if (oEasyFileInfo.Nombre.Length > 0)
                        {
                            InspeccionAnexoBE oInspeccionAnexoBE = new InspeccionAnexoBE();
                            oInspeccionAnexoBE.IdInspeccion = this.IdInspeccion;
                            oInspeccionAnexoBE.IdUsuario = this.UsuarioId;
                            oInspeccionAnexoBE.Archivo = oEasyFileInfo.Nombre;
                            oInspeccionAnexoBE.IdAnexo = oEasyFileInfo.IdFile;
                            oInspeccionAnexoBE.IdEstado = oEasyFileInfo.IdEstado;
                            oInspeccionAnexoBE.Orden = Orden;
                            string ids = oCalidad.AdministrarInspeccionAnexos(oInspeccionAnexoBE);
                            Orden++;
                        }

                    }
                    this.Atras();
                }
            }
            catch (Exception ex)
            {
                this.LanzarException("EasyForm1_CommitTransaccion.Agregar", ex);
            }
            return 0;
        }

        void MoveraCarpetaFinal(string NombreArchivo) {
            string CarpetaTemporal = "c:\\tmp\\" + NombreArchivo;
            string CarpetaFinal = EasyUtilitario.Helper.Configuracion.Leer("ConfigModCalidad", "CalidadPathFiles") + NombreArchivo;

            if (File.Exists(CarpetaFinal)){
                File.Delete(CarpetaFinal);
            }
            System.IO.FileInfo f = new System.IO.FileInfo(CarpetaTemporal);
            f.MoveTo(CarpetaFinal);

        }


        public void LlenarJScript()
        {
           // txtDeleteFile.Style.Add("display", "none");
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
