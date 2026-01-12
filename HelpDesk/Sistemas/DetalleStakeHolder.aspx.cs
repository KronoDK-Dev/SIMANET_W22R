using EasyControlWeb.Filtro;
using EasyControlWeb.InterConeccion;
using EasyControlWeb;
using EasyControlWeb.InterConecion;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.HelpDesk.Sistemas
{
    public partial class DetalleStakeHolder : HelpDeskBase,IPaginaBase, IPaginaMantenimento
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                this.LlenarJScript();
                this.CargarModoPagina();
            }
            catch (Exception ex) {

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

        public void CargarModoModificar()
        {
            EasyBaseEntityBE oEasyBaseEntityBE = CargarDetalle();
            this.EasyAcBuscarInteresado.SetValue(oEasyBaseEntityBE.GetValue("ApellidosYNombres"), oEasyBaseEntityBE.GetValue("IdPersonal"));
            this.EasyTxtDescripcion.SetValue(oEasyBaseEntityBE.GetValue("Descripcion"));
            string NombreFile = oEasyBaseEntityBE.GetValue("NombreImg");
            this.imgUpLoad.Src = this.RutaHTTPFirmas + NombreFile;
            this.imgUpLoad.Attributes["NomFileOld"] = NombreFile;
            string ScriptImg = @"<script>
                                    Manager.Task.Excecute(function () {
                                                var oIemBE = new EasyUploadFileBE(file);
                                                    oIemBE.ClientID = '" + NombreFile + @"';
                                                    oEasyUpLoad.Clear();
                                                    oEasyUpLoad.FileCollections.Add(oIemBE);
                                            }, 1000, true);
                                </script>";
            this.Controls.Add(new LiteralControl(ScriptImg));
        }

        public void CargarModoNuevo()
        {
            throw new NotImplementedException();
        }

        public void CargarModoPagina()
        {
            if (this.ModoPagina == EasyControlWeb.EasyUtilitario.Enumerados.ModoPagina.M)
            {
                this.CargarModoModificar();
            }
        }
        EasyBaseEntityBE CargarDetalle()
        {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/HelpDesk/Sistemas/GestionSistemas.asmx";
            odi.Metodo = "ActividadElementos_StakeHolder_Det";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "IdStakeHolder";
            oParam.Paramvalue = this.IdStakeHolder;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);


            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);
            return odi.GetEntity();
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
            throw new NotImplementedException();
        }

        public void LlenarJScript()
        {
            this.lblNombreElemento.InnerText = "NOMBRE DE " + this.NombreElemento.ToUpper();
            this.EasyAcBuscarInteresado.DataInterconect.UrlWebService = this.PathNetCore + "/General/Busquedas.asmx";
            this.imgUpLoad.Src = EasyUtilitario.Constantes.ImgDataURL.ImgLoadUp;
            this.trFirma.Style.Add("visibility", (((this.IdTipoStakeHolder == "1")|| (this.IdTipoStakeHolder == "3")) ? "hidden" : "visible"));
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