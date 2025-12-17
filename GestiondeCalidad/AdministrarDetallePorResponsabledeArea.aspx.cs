using EasyControlWeb;
using EasyControlWeb.Form.Controls;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.srvGestionCalidad;
using SIMANET_W22R.srvGestionPersonal;
using SIMANET_W22R.srvSeguridad;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestiondeCalidad
{
    public partial class AdministrarDetallePorResponsabledeArea : PaginaCalidadBase,IPaginaBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                this.LlenarDatos();
                this.LlenarJScript();
                this.LlenarGrilla();
            }
            catch (SIMAExceptionSeguridadAccesoForms ex)
            {
                this.LanzarException(ex);
            }
        }

        public int Agregar()
        {
            throw new NotImplementedException();
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
            //this.IdPersonal
            PersonalSoapClient oPersonal = new PersonalSoapClient();
            PersonalUbicacionBE oPersonalUbicacionBE= oPersonal.DetallePersonaUbicacion(this.IdPersonal, this.UsuarioLogin);

            EasyCardPerfil1.PathFoto = EasyUtilitario.Helper.Configuracion.Leer(EasyUtilitario.Enumerados.Configuracion.SeccionKey.Nombre.ConfigBase, "PathFotos") + oPersonalUbicacionBE.DocIdentidad + ".jpg";
            EasyCardPerfil1.ApellidosyNombres = oPersonalUbicacionBE.ApellidosyNombres;
            EasyCardPerfil1.Area = oPersonalUbicacionBE.NombreArea;
            EasyCardPerfil1.Email= oPersonalUbicacionBE.EMail;
        }

        public void LlenarGrilla()
        {
            try
            {
                ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
                DataTable dtMsgResArea = oCalidad.ListarDetallePorReponsabledeArea(this.IdInspeccion, this.IdPersonal, this.UsuarioLogin);

                DataView dv = dtMsgResArea.DefaultView;
                dv.RowFilter = "IdEstado in (2,3)";//Lista los regiastros disponibles para su lectura

                EasyGridViewAnotacion.DataSource = dv;
                EasyGridViewAnotacion.DataBind();
            }
            catch (Exception ex)
            {
            }
        }

        public void LlenarGrilla(string strFilter)
        {
            throw new NotImplementedException();
        }

        public void LlenarJScript()
        {
            string IdCtrlGrid = "EasyGridViewAnotacion";
            string CambioEstado = @"<script>
                                        var Hilo=0;
                                        function " + IdCtrlGrid + @"_ConfirmaLectura(){
                                                 " + IdCtrlGrid + @".ItemsforEach(function(orow,i){
                                                                                        var oDataRow =orow.GetData();
                                                                                        var oImg = jNet.get(orow.cells[3].childNodes[0]);
                                                                                        var IdEstado =oDataRow['IdEstado'];
                                                                                            if(IdEstado=='2'){
                                                                                                oImg.attr('src','" + EasyUtilitario.Constantes.ImgDataURL.IconLeido + @"');

                                                                                                var oParamCollections  = new SIMA.ParamCollections();
                                                                                                var oParam = new SIMA.Param('IdDetalleResponsableArea', oDataRow['IdDetalleResponsableArea']);
                                                                                                     oParamCollections.Add(oParam);
                                                                                                     oParam = new SIMA.Param('IdEstado', '3');
                                                                                                     oParamCollections.Add(oParam);
                                                                                                     oParam = new SIMA.Param('UserName',AdministrarDetallePorResponsabledeArea.Params['UserName']);
                                                                                                     oParamCollections.Add(oParam);

                                                                                                var oEasyDataInterConect = new EasyDataInterConect();
                                                                                                    oEasyDataInterConect.MetododeConexion = ModoInterConect.WebServiceInterno;
                                                                                                    oEasyDataInterConect.UrlWebService = '/GestiondeCalidad/Proceso.asmx';
                                                                                                    oEasyDataInterConect.Metodo = 'ActualizaEstadoDetalleResponsable';
                                                                                                    oEasyDataInterConect.ParamsCollection = oParamCollections;

                                                                                                    var oEasyDataResult = new EasyDataResult(oEasyDataInterConect);
                                                                                                    oEasyDataResult.sendData();
                                                                                            }
                                            
                                                                                });
                                            }

                                            Hilo = setTimeout(function(){" + IdCtrlGrid + @"_ConfirmaLectura();}, 900);
                                        
                                   </script>";
            Page.Controls.Add(new LiteralControl(CambioEstado));
            
        }

        public int Modificar()
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

        protected void EasyGridViewAnotacion_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string cmll = EasyUtilitario.Constantes.Caracteres.ComillaDoble;
                DataRowView drv = (DataRowView)e.Row.DataItem;
                DataRow dr = drv.Row;
                EasyTextBox otbox = new EasyTextBox();
               
                HtmlImage oimg = new HtmlImage();
                oimg.Attributes["src"] = dr["var5"].ToString();
                oimg.Attributes["title"] = dr["NombreEstado"].ToString();
                e.Row.Cells[3].Controls.Add(oimg);

            }
        }
    }
}