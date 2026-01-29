using SIMANET_W22R.InterfaceUI;
using System;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.HelpDesk.Sistemas
{
    public partial class AdministrarDocTimeLine : HelpDeskBase, IPaginaBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            this.LlenarJScript();

            this.RegistrarJScript();
           
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
            throw new NotImplementedException();
        }

        public void LlenarGrilla(string strFilter)
        {
            throw new NotImplementedException();
        }

        public void LlenarJScript()
        {
            Table tbl = new Table();
            tbl.Style.Add("width", "100%");
            TableRow row = new TableRow();
            TableCell cell = new TableCell();
            cell.Attributes.Add("id", "contentTime_" + this.IdTipoDocumentacion);
            cell.Style.Add("width", "100%");
            row.Controls.Add(cell);
            tbl.Controls.Add(row);
            Contenedor.Controls.Add(tbl);
            //Page.Controls.Add(tbl);
        }

        public void RegistrarJScript()
        {
          

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