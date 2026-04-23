using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.Form.Controls;
using EasyControlWeb.InterConeccion;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.SIMANET.SeguridadPlanta
{
    public partial class AdministrarSCTR : SeguridadPlantaBase,IPaginaBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    this.LlenarGrilla("");
                }
            }
            catch (SIMAExceptionSeguridadAccesoForms ex)
            {
                this.LanzarException(ex);
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
            throw new NotImplementedException();
        }

        public void LlenarGrilla(string strFilter)
        {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/SIMANET/SeguridadPlanta/Contratista.asmx";
            odi.Metodo = "SCTR_lst";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdEntidad";
            oParam.Paramvalue = this.IdEntidad;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);


            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "Periodo";
            oParam.Paramvalue = this.Año;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "NroProg";
            oParam.Paramvalue = this.IdProgramacion;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);

            DataTable dt = odi.GetDataTable();

            EasyGRSCTR.DataInterconect = odi;
            EasyGRSCTR.LoadData();
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

        protected void EasyGRSCTR_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = (DataRowView)e.Row.DataItem;
                DataRow dr = drv.Row;
                if (dr["FechaInicio"].ToString().Length > 0)
                {
                    e.Row.Cells[3].Text = dr["FechaInicio"].ToString().Substring(0, 10);
                    e.Row.Cells[4].Text = dr["FechaVencimiento"].ToString().Substring(0, 10);
                }

                HtmlImage oImg = new HtmlImage();
                if (dr["IdEstado"].ToString() == "0")
                {
                    oImg.Src = EasyUtilitario.Constantes.ImgDataURL.ImportBaja;
                    foreach (TableCell itemCol in e.Row.Cells) {
                        itemCol.Attributes["style"] = "text-decoration: underline;text-decoration-color: red; text-decoration: line-through;";
                    }
                }
                else
                {
                    oImg.Src = EasyUtilitario.Constantes.ImgDataURL.IconDelete;
                    oImg.Attributes.Add(EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString(), "AdministrarSCTR.Eliminar(this)");
                }
                oImg.Style.Add("cursor", "pointer");
                e.Row.Cells[5].Controls.Add(oImg);


            }


        }
    }
}