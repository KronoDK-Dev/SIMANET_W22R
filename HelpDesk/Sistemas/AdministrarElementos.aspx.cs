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

namespace SIMANET_W22R.HelpDesk.Sistemas
{
    public partial class AdministrarElementos : HelpDeskBase,IPaginaBase
    {

        protected void Page_Load(object sender, EventArgs e)
        {

            try
            {
                this.EasyGridView1.ID="Grid"+ this.IdTipoElemento.ToString();
                this.LlenarGrilla();

            }
            catch (Exception ex)
            {
                StackTrace stack = new StackTrace();
                string NombreMetodo = stack.GetFrame(1).GetMethod().Name + "/" + stack.GetFrame(0).GetMethod().Name;

                this.LanzarException(NombreMetodo, ex);
            }
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
            throw new NotImplementedException();
        }

        public void LlenarGrilla()
        {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/HelpDesk/Sistemas/GestionSistemas.asmx";
            odi.Metodo = "ActividadElementos_Listar";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdActividad";
            oParam.Paramvalue = this.IdActividad;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);


            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdTipoElemento";
            oParam.Paramvalue = this.IdTipoElemento;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);


            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);

            EasyGridView1.TituloHeader = this.NombreElemento;
            EasyGridView1.DataInterconect = odi;
            EasyGridView1.LoadData();
        }

        public void LlenarGrilla(string strFilter)
        {
            throw new NotImplementedException();
        }

        public void LlenarJScript()
        {
          
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

        protected void EasyGridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = (DataRowView)e.Row.DataItem;
                DataRow dr = drv.Row;

                HtmlImage oimg = new HtmlImage();
                oimg.Attributes["src"] = EasyUtilitario.Constantes.ImgDataURL.IconDelete;
                oimg.Attributes[EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString()] = "AdministrarElementos.Eliminar(this);";
                e.Row.Cells[3].Controls.Add(oimg);

            }
        }
    }
}