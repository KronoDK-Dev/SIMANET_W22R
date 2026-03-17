using EasyControlWeb;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestionGobernanza.Indicadores
{
    public partial class ViewGraphMeta : GobernanzaBase,IPaginaBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try{
                this.LlenarDatos();
            }
            catch (Exception ex) {
                int i = 0;
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
            string cmll = EasyUtilitario.Constantes.Caracteres.ComillaDoble;
            string htmlCanvas = "<canvas id=" + cmll + "Chart_" + this.IdAreaInfo + cmll + " width =" + cmll + "600" + cmll + " height =" + cmll + "100" + cmll + ">demo</canvas>";
            Page.Form.Controls.Add(new LiteralControl(htmlCanvas));
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

       
    }
}