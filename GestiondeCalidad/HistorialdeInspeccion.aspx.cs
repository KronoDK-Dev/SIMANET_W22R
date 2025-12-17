using EasyControlWeb;
using EasyControlWeb.Form.Controls;
using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.srvGeneral;
using SIMANET_W22R.srvGestionCalidad;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestiondeCalidad
{
    public partial class HistorialdeInspeccion : PaginaBase, IPaginaBase
    {
        EasyUsuario oUsuario = new EasyUsuario();
        EasyMessageBox oeasyMessageBox = new EasyMessageBox();

        const string KEYIDTABLANORMACALIDAD = "659";

        protected void Page_Load(object sender, EventArgs e)
        {
            oUsuario = EasyUtilitario.Helper.Sessiones.Usuario.get();
            try
            {
                if (!Page.IsPostBack)
                {
                    this.LlenarGrilla("");
                }
            }
            catch (HttpException exp)
            {
                ViewStateException vse = (ViewStateException)exp.InnerException;
                String logMessage;

                logMessage = "ViewStateException.Path: " + vse.Path + Environment.NewLine;
                logMessage += "PersistedState: " + vse.PersistedState + Environment.NewLine;
                logMessage += "Referer: " + vse.Referer + Environment.NewLine;
                logMessage += "UserAgent: " + vse.UserAgent + Environment.NewLine;


                if (vse.IsConnected)
                {
                    HttpContext.Current.Response.Redirect("ErrorPage.aspx");
                }
                else
                {
                    throw exp;
                }
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
        public void CargarModoNuevo()
        {
        }
        public void CargarModoModificar()
        {
        }
        public int Agregar()
        {
            return 0;
        }
        public int Modificar()
        {
            return 0;
        }

        public void LlenarGrilla()
        {
            throw new NotImplementedException();
        }

        public void LlenarGrilla(string strFilter)
        {
            try
            { 

                ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
                DataTable dt = oCalidad.ListarInspeccionesxInspector("2022-19", "erosales");

                EasyGridViewInspeciones.DataSource = dt;
                EasyGridViewInspeciones.DataBind();
            }
            catch (Exception ex)
            {
                string dd = "ss";
            }
        }

        public void LlenarJScript()
        {
            throw new NotImplementedException();
        }

        public void RegistrarJScript()
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

        protected void EasyGridViewInspeciones_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = (DataRowView)e.Row.DataItem;
                DataRow dr = drv.Row;
                EasyDatepicker oeasyDatepicker = new EasyDatepicker();
                oeasyDatepicker.ID = "FIni";
                oeasyDatepicker.CssClass = EasyUtilitario.Enumerados.Stylos.Control;
                oeasyDatepicker.Text = dr["Fecha"].ToString();

                oeasyDatepicker.EasyStyle.Ancho = EasyControlWeb.Form.Estilo.Bootstrap.Tamaño.Dos;
                e.Row.Cells[0].Controls.Add(oeasyDatepicker);

                TextBox otxt = new TextBox();
                otxt.ID = "txtDescrip";
                otxt.TextMode = TextBoxMode.MultiLine;
                otxt.Style["Width"] = "100%";
                otxt.Style["Height"] = "100%";
                otxt.CssClass= "form-control";
                otxt.Text = dr["Descripcion"].ToString();

                e.Row.Cells[1].Controls.Add(otxt);


                otxt = new TextBox();
                otxt.ID = "txtObs";
                otxt.TextMode = TextBoxMode.MultiLine;
                otxt.Style["Width"] = "100%";
                otxt.Style["Height"] = "100%";
                otxt.CssClass = EasyUtilitario.Enumerados.Stylos.Control;
                otxt.Text = dr["Descripcion"].ToString();
                

                e.Row.Cells[2].Controls.Add(otxt);

                GeneralSoapClient oGeneralSoapClient = new GeneralSoapClient();
                DataTable dtg = oGeneralSoapClient.ListarItemTablas(KEYIDTABLANORMACALIDAD, "erosales");
                DropDownList ddlNorma = new DropDownList();
                ddlNorma.DataValueField = "Codigo";
                ddlNorma.DataTextField= "Descripcion";
                ddlNorma.DataSource = dtg;
                ddlNorma.DataBind();
                ddlNorma.CssClass = EasyUtilitario.Enumerados.Stylos.Control;
                e.Row.Cells[3].Controls.Add(ddlNorma);
                //Datos complementarios
                e.Row.Attributes["Modo"] = "M";
                e.Row.Attributes["IdDetalleInspeccion"] = dr["IdDetalleInspeccion"].ToString();
                e.Row.Attributes["IdInspector"] = dr["IdInspector"].ToString();
                e.Row.Attributes["IdEstado"] = dr["IdEstado"].ToString();


                /*Para subir archivs a cada registro*/
                EasyUpLoad easyUpLoad = new EasyUpLoad();
                easyUpLoad.ID = "EasyUpLoad1";
                easyUpLoad.PaginaProceso = "General/UpLoadMaster.aspx";
                easyUpLoad.DisplayButtons = true;
                easyUpLoad.ItemFileClass = "BaseItem";
                easyUpLoad.Titulo = "Subir archivos por responsable";
                easyUpLoad.fncOnComplete = "onCompletado";
                easyUpLoad.fncListViewItemClick = "onListViewGeneric";
                easyUpLoad.Width = 300;

                easyUpLoad.PathLocalyWeb.CarpetaTemporal = @"C:\tmp\";
                easyUpLoad.PathLocalyWeb.CarpetaFinal = "";


                easyUpLoad.PathLocalyWeb.UrlFinal = "http://localhost/ArchivosTmp/";
                easyUpLoad.PathLocalyWeb.UrlTemporal = "http://localhost/ArchivosTmp/";


                e.Row.Cells[4].Controls.Add(easyUpLoad);



            }
        }
    }
}