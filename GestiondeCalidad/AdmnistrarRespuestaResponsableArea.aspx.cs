using CrystalDecisions.ReportAppServer.DataDefModel;
using EasyControlWeb;
using EasyControlWeb.Filtro;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.General;
using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.srvGestionCalidad;
using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestiondeCalidad
{
    public partial class AdmnistrarRespuestaResponsableArea : PaginaCalidadBase, IPaginaBase
    {
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
                    this.LlenarGrilla("");
                  

                }
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
            txtIdPersonal.Text = this.DatosUsuario.IdPersonal.ToString();
        }

        public void LlenarGrilla()
        {
           
        }

        public void LlenarGrilla(string strFilter)
        {
            try
            {
                ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
                DataTable dt = oCalidad.Inspeccion_ListarPorResponsableArea(this.DatosUsuario.IdPersonal.ToString(), this.UsuarioLogin);
                DataView dv = dt.DefaultView;
                if (strFilter.Length > 0)
                {
                    dv.RowFilter = strFilter;
                }
                EasyGridRpta.DataSource = dv;
                EasyGridRpta.DataBind();
            }
            catch (Exception ex)
            {
                StackTrace stack = new StackTrace();
                string NombreMetodo = stack.GetFrame(1).GetMethod().Name + "/" + stack.GetFrame(0).GetMethod().Name;
                this.LanzarException(NombreMetodo, ex);
            }

        }

        public void LlenarJScript()
        {
            string ScriptArrayEstados = "";
            DataTable dt = (new TablasGenerales()).ListarItems("687", this.UsuarioLogin);
            foreach (DataRow dr in dt.Rows)
            {
                ScriptArrayEstados += "    arrEstadoRPT[" + dr["Codigo"].ToString() + "]='" + dr["var5"].ToString() + "';\n";
            }
            ScriptArrayEstados = @"var arrEstadoRPT = [" + dt.Rows.Count.ToString() + "];\n" + ScriptArrayEstados;

            Page.Controls.Add(new LiteralControl("<script>\n" + ScriptArrayEstados + "</script>\n"));
            this.txtIdPersonal.Style.Add("display", "none");

            btnRefresh.Style.Add("display", "none");
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

        protected void EasyGridRpta_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = (DataRowView)e.Row.DataItem;
                DataRow dr = drv.Row;
                HtmlTable tbl = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(4, 1);
                tbl.Style["width"] = "100%";
                tbl.Attributes["border"] = "0";
                tbl.Rows[0].Cells[0].Style["width"] = "100%";
                tbl.Rows[0].Cells[0].InnerHtml = "PROYECTO:";
                tbl.Rows[0].Cells[0].Attributes["style"] = "font-size: 10px;font-family:Arial;Color:blue";
                tbl.Rows[1].Cells[0].InnerText = dr["NombreProyecto"].ToString();
                tbl.Rows[2].Cells[0].InnerHtml = "CLIENTE:";
                tbl.Rows[2].Cells[0].Attributes["style"] = "font-size: 10px;font-family:Arial;Color:blue";
                tbl.Rows[3].Cells[0].InnerText = dr["ClienteRazonSocial"].ToString();
                e.Row.Cells[2].Controls.Add(tbl);
                //Items de respuesta
                int idx = 1;
                ControlInspeccionesSoapClient oCalidad = new ControlInspeccionesSoapClient();
                DataTable dtMsgResArea = oCalidad.ListarDetallePorReponsabledeArea(dr["IdInspeccion"].ToString(), this.DatosUsuario.IdPersonal, this.UsuarioLogin);
                foreach(DataRow drRPT in dtMsgResArea.Rows){
                    HtmlTable tblItem = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(1, 4);
                    tblItem.Attributes["class"] = "BaseItem";
                    tblItem.Attributes["Border"] = "0px";
                    tblItem.Style.Add("margin-bottom", "5px");
                    tblItem.Style.Add("Width", "100%");
                    tblItem.Rows[0].Cells[0].InnerText = idx.ToString();
                    string ImgDelete = EasyUtilitario.Constantes.ImgDataURL.IconTreeSpace;
                    string EventEstado = "";
                    string IdEstado = drRPT["IdEstado"].ToString();

                    //tblItem.Rows[0].Attributes["exec"] = "SI";
                    tblItem.Rows[0].Cells[0].Attributes[EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString()] = "DetalleDeAnotacion(this,'" + drRPT["IdDetalleResponsableArea"].ToString() + "');";
                    tblItem.Rows[0].Cells[0].Style.Add("text-decoration", "underline");
                    tblItem.Rows[0].Cells[0].Style.Add("color", "blue");

                    if ((IdEstado != "3") && (IdEstado != "4"))
                    {
                        if (IdEstado == "1") {
                            EventEstado = "EstablecerParaLectura(this,'2');";
                        }
                        ImgDelete = EasyUtilitario.Constantes.ImgDataURL.IconDeItem;
                    }

                    tblItem.Rows[0].Cells[0].Align = "center";
                    tblItem.Rows[0].Cells[0].Style.Add("Width", "5%");
                    
                    tblItem.Rows[0].Cells[0].Style.Add("cursor", "hand");

                    /*tblItem.Rows[0].Cells[1].InnerText = drRPT["FechaRpta"].ToString();
                    tblItem.Rows[0].Cells[1].Style.Add("Width", "10%");*/
                    tblItem.Rows[0].Cells[1].InnerText = drRPT["Observacion"].ToString();
                    tblItem.Rows[0].Cells[1].Style.Add("Width", "70%");
                    HtmlImage oimg = new HtmlImage();   
                    oimg.Attributes["src"]= drRPT["var5"].ToString();
                    oimg.Attributes["title"] = drRPT["NombreEstado"].ToString();
                    oimg.Attributes["Width"] = "35px";
                    oimg.Attributes["IdDetalleResponsableArea"] = drRPT["IdDetalleResponsableArea"].ToString();
                    oimg.Attributes[EasyUtilitario.Enumerados.EventosJavaScript.ondblclick.ToString()] = EventEstado;
                    tblItem.Rows[0].Cells[2].Controls.Add(oimg);
                    tblItem.Rows[0].Cells[2].Style.Add("Width", "5%");

                    oimg = new HtmlImage();
                    oimg.Attributes["src"] = ImgDelete;
                    tblItem.Rows[0].Cells[3].Controls.Add(oimg);
                    tblItem.Rows[0].Cells[3].Style.Add("Width", "5%");

                    e.Row.Cells[5].Controls.Add(tblItem);

                    idx++;
                }

            }
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            this.LlenarGrilla("");
        }
    }
}