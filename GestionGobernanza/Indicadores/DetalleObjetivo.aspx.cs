using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.InterConeccion;
using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.srvGeneral;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestionGobernanza.Indicadores
{
    public partial class DetalleObjetivo : GobernanzaBase,IPaginaMantenimento
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                this.CargarModoPagina();
            }
            catch (Exception ex)
            {
                int i = 0;
            }

        }
        public void Agregar()
        {
            throw new NotImplementedException();
        }

        public void CargarModoConsulta()
        {
            throw new NotImplementedException();
        }

        public DataTable ListarTodos(string IdTblRel,string IdItemRel,string UserName)
        {
            
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/GestionGobernanza/Indicadores.asmx";
            odi.Metodo = "ListarObjetivosoAcciones";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdTblObjetivo";
            oParam.Paramvalue = IdTblRel;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdObjetivo";
            oParam.Paramvalue = IdItemRel;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.Int;
            odi.UrlWebServicieParams.Add(oParam);



            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = UserName;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);
            return odi.GetDataTable();
        }
        public void CargarModoModificar()
        {
            DataTable DT = ListarTodos("80","1", this.UsuarioLogin);//Tabla Padre de versionaes
            foreach (DataRow dr in DT.Rows)
            {
                if ((dr["IDTBL"].ToString() == this.IdTablaGeneral.ToString()) && (dr["IDITEM"].ToString() == this.IdTablaGeneralItems.ToString())) {
                    this.SetData(dr);
                    this.txtCodigo.Text = dr["CODIGO"].ToString();
                    this.txtNombre.Text = dr["NOMBRE"].ToString();
                    this.txtDescripcion.Text = dr["DESCRIPCION"].ToString();
                }
            }
        }

        public void CargarModoNuevo()
        {
            throw new NotImplementedException();
        }

        public void CargarModoPagina()
        {
            switch (this.ModoPagina)
            {
                case EasyUtilitario.Enumerados.ModoPagina.N:
                    CargarModoNuevo();
                    break;
                case EasyUtilitario.Enumerados.ModoPagina.M:
                    CargarModoModificar();
                    break;

            }
        }

        public void Eliminar()
        {
            throw new NotImplementedException();
        }

        public void Modificar()
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

      
    }
}