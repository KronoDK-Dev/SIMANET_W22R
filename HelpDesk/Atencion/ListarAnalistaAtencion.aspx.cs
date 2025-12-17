using EasyControlWeb.Form.Controls;
using EasyControlWeb;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SIMANET_W22R.HelpDesk.BandejaEntrada;
using System.Web.UI.HtmlControls;
using SIMANET_W22R.GestionTesoreria.Balance;
using EasyControlWeb.Form.Base;

namespace SIMANET_W22R.HelpDesk.Atencion
{
    public partial class ListarAnalistaAtencion : HelpDeskBase, IPaginaBase
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {

                if (!Page.IsPostBack)
                {
                    this.LlenarDatos();
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
            throw new NotImplementedException();
        }

        public void LlenarDatos()
        {
            DataTable odt = (new AdministrarAtencion()).ListarResponsableAtencion(this.IdRequerimiento);
            HtmlTable HtmlTbl = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(odt.Rows.Count,2);
            HtmlTbl.Style.Add("Width", "100%");
            HtmlTbl.Attributes["border"] = "0";
            int r =0;
            foreach (DataRow dr in odt.Rows)
            {
                HtmlImage oimg = EasyUtilitario.Helper.HtmlControlsDesign.CrearImagen(this.PathFotosPersonal + dr["NRODOCDNI"].ToString() + ".jpg","ms-n2 rounded-circle img-fluid");
                oimg.Attributes["Width"] = "45px";
                HtmlTbl.Rows[r].Cells[0].Controls.Add(oimg);
                HtmlTbl.Rows[r].Cells[0].Style["Width"] = "20%";
                HtmlTbl.Rows[r].Cells[0].Style["padding-left"] = "20px";
                EasyProgressbarBase oEasyProgressBar = new EasyProgressbarBase();
                oEasyProgressBar.Progreso = Convert.ToInt32(dr["AVANCE"].ToString());
                HtmlTbl.Rows[r].Cells[1].Controls.Add(oEasyProgressBar);
                HtmlTbl.Rows[r].Cells[1].Style["Width"] = "80%";
                r++;
            }
            UserAtencion.Controls.Add(HtmlTbl);
        }

        public void CargarModoNuevo()
        {
            throw new NotImplementedException();
        }

        public void CargarModoModificar()
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