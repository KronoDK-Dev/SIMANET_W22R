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
    public partial class ListarEquipos : SeguridadPlantaBase,IPaginaBase
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
            
        }

        public void LlenarDatos()
        {
            throw new NotImplementedException();
        }

        public void LlenarGrilla()
        {
            this.grvEquipos.DataInterconect = ListadodeEquipos(this.Año, this.IdProgramacion,"0");
            grvEquipos.LoadData();
        }
        public EasyDataInterConect ListadodeEquipos(string  Periodo,string IdProg,string IdEquipo)
        {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.ConfigPathSrvRemoto = "PathBaseWSCore";
            odi.MetodoConexion = MetododeConexion.WebServiceExterno;
            odi.UrlWebService = "SIMANET/SeguridadPlanta/Contratista.asmx";
            odi.Metodo = "ProgramacionEquipos_lst";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "Periodo";
            oParam.Paramvalue = Periodo;
            oParam.TipodeDato = TiposdeDatos.Int;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdProgramacion";
            oParam.Paramvalue = IdProg;
            oParam.TipodeDato = TiposdeDatos.Int;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);


            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdEquipo";
            oParam.Paramvalue = "0";
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

        protected void grvEquipos_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = (DataRowView)e.Row.DataItem;
                DataRow dr = drv.Row;
              
                HtmlImage oImg = new HtmlImage();
                oImg.Src = EasyUtilitario.Constantes.ImgDataURL.IconDelete;
                oImg.Attributes.Add(EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString(), "ListarEquipos.Eliminar(this)");
                oImg.Style.Add("cursor", "pointer");
                e.Row.Cells[5].Controls.Add(oImg);

            }
        }
    }
}