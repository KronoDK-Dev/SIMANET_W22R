using EasyControlWeb;
using EasyControlWeb.Filtro;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static SIMANET_W22R.GestionReportes.GenerarPdf;

namespace SIMANET_W22R.GestionReportes
{
    public partial class ReportPrevio : PaginaBase, IPaginaBase
    {
        const string KEYCONFIG_SECCION = "kQSeccion";
        const string KEYCONFIG_PATH = "kQPathRpt";

        public string KeySeccionRpt { get { return Page.Request.Params[KEYCONFIG_SECCION].ToString(); } }
        public string KeyPathHttpSource { get { return Page.Request.Params[KEYCONFIG_PATH].ToString(); } }

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
            string FileRpt = Page.Request.Params["RutaWebRpt"].Replace("[.]", "/");
            //string PathUrl = EasyUtilitario.Helper.Configuracion.Leer(EasyUtilitario.Enumerados.Configuracion.SeccionKey.Nombre.ConfigBase, "PathFileRptHttp") + "/" + FileRpt;
            string PathUrl = EasyUtilitario.Helper.Configuracion.Leer(this.KeySeccionRpt, this.KeyPathHttpSource) + "/" + FileRpt;
            this.RptPrevio.Src = PathUrl;

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
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    this.LlenarDatos();
                    this.LlenarJScript();
                    //Graba en el Log la acción ejecutada
                    /*   LogAplicativo.GrabarLogAplicativoArchivo(new LogAplicativo(CNetAccessControl.GetUserName(), "Secretaria - Directorio", this.ToString(), "Se consultó las Actas de Sesión de Directorio.", Enumerados.NivelesErrorLog.I.ToString()));
                    */

                }
            }
            catch (SIMAExceptionSeguridadAccesoForms ex)
            {
                this.LanzarException(ex);
            }
        }
    }
}