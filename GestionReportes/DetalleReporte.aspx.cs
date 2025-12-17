using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.Form.Controls;
using EasyControlWeb.InterConeccion;
using iTextSharp.text;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.srvGestionReportes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestionReportes
{
    public partial class DetalleReporte : ReporteBase,IPaginaBase
    {
        EasyMessageBox oeasyMessageBox;
        DataTable dtTreeParams = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                this.LlenarJScript();
                this.LlenarCombos();
                this.LlenarDatos();
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
           
        }

        void ElaborarArbolProp(int _IdPadre, string IdNodo, int Nivel)
        {
            AdministrarReportesSoapClient ogReports = new AdministrarReportesSoapClient();
            DataTable dt = ogReports.ListarObjetos(_IdPadre.ToString() , this.UsuarioLogin);
            foreach (DataRow dr in dt.Rows)
            {
                DataRow drnew = dtTreeParams.NewRow();
                drnew["IdObjeto"] = dr["IdObjeto"].ToString();
                drnew["IdPadre"] = _IdPadre.ToString();
                drnew["Nombre"] = dr["Nombre"].ToString();
                drnew["Ref1"] = dr["Ref1"].ToString();
                drnew["Ref2"] = dr["Ref2"].ToString();
                drnew["Ref3"] = dr["Ref3"].ToString();
                drnew["IdTipo"] = dr["IdTipo"].ToString();
                drnew["Descripcion"] = dr["Descripcion"].ToString();
                drnew["ValorDefault"] = dr["ValorDefault"].ToString();
                drnew["IdTipoControl"] = dr["IdTipoControl"].ToString();
                drnew["TipoControl"] = dr["TipoControl"].ToString();
                drnew["imgCtrl"] = dr["imgCtrl"].ToString();

                //string strNodo = ((IdNodo == null) ? dr["IdObjeto"].ToString() : IdNodo + "." + dr["IdObjeto"].ToString()) + ".";
                string strNodo = ((IdNodo == null) ? dr["IdObjeto"].ToString() : IdNodo + "." + dr["IdObjeto"].ToString()) ;
                drnew["IdNodo"] = strNodo;
                drnew["NroHijos"] = dr["NroHijosReal"].ToString();

                drnew["Nivel"] = Nivel;
                dtTreeParams.Rows.Add(drnew);
                dtTreeParams.AcceptChanges();
                if (Convert.ToInt32(dr["NroHijosReal"]) > 0)
                {
                    ElaborarArbolProp(Convert.ToInt32(dr["IdObjeto"].ToString()), strNodo, (Nivel + 1));
                }
            }
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
           // throw new NotImplementedException();
        }

        public void LlenarDatos()
        {
            try
            {
                string Nombre = "";
                AdministrarReportesSoapClient ogReports = new AdministrarReportesSoapClient();
                DataTable dt = ogReports.ListarCabeceradeReporte(this.IdObjeto, this.UsuarioLogin);
                DataRow dr = dt.Rows[0];
                string[] PathFile = dr["Ref1"].ToString().Split(EasyUtilitario.Constantes.Caracteres.BackSlash);
                Nombre = PathFile[PathFile.Length - 1];
                PathFile = PathFile.Take(PathFile.Count() - 1).ToArray();
                string nPath = String.Join("/", PathFile);
                this.EasyFindFile.Text = Nombre;
                this.txtRuta.Text = nPath;
                //Obtiene datos del servicio
                PathFile = dr["Ref2"].ToString().Split('/');
                Nombre = PathFile[PathFile.Length - 1];
                this.EasyListaServicios.Text = Nombre;//, dr["Ref2"].ToString());
                //Obtener Datos del metodo
                this.EasyListarMetodos.Text=dr["Ref3"].ToString();
            }
            catch (Exception ex) {
                oeasyMessageBox = new EasyMessageBox();
                oeasyMessageBox.ID = "msgb";
                oeasyMessageBox.Titulo = "Detalle de Reporte";
                oeasyMessageBox.Contenido = ex.Message;
                oeasyMessageBox.Tipo = EasyUtilitario.Enumerados.MessageBox.Tipo.AlertType;
                oeasyMessageBox.AlertStyle = EasyUtilitario.Enumerados.MessageBox.AlertStyle.modern;
                Page.Controls.Add(oeasyMessageBox);

            }
        }

        public void LlenarGrilla()
        {
            try
            {
                EasyGridViewParam.DataSource = CargarTree(this.IdObjeto);
                EasyGridViewParam.DataBind();
            }
            catch (Exception ex)
            {
            }
        }
        public DataTable CargarTree(int _IdObjeto) {
            try
            {
                dtTreeParams.Columns.Add(new DataColumn("IdObjeto", typeof(string)));
                dtTreeParams.Columns.Add(new DataColumn("IdPadre", typeof(string)));
                dtTreeParams.Columns.Add(new DataColumn("Nombre", typeof(string)));
                dtTreeParams.Columns.Add(new DataColumn("Ref1", typeof(string)));
                dtTreeParams.Columns.Add(new DataColumn("Ref2", typeof(string)));
                dtTreeParams.Columns.Add(new DataColumn("Ref3", typeof(string)));
                dtTreeParams.Columns.Add(new DataColumn("IdTipo", typeof(string)));
                dtTreeParams.Columns.Add(new DataColumn("Descripcion", typeof(string)));
                dtTreeParams.Columns.Add(new DataColumn("ValorDefault", typeof(string)));
                dtTreeParams.Columns.Add(new DataColumn("IdTipoControl", typeof(string)));
                dtTreeParams.Columns.Add(new DataColumn("TipoControl", typeof(string)));
                dtTreeParams.Columns.Add(new DataColumn("IdNodo", typeof(string)));
                dtTreeParams.Columns.Add(new DataColumn("NroHijos", typeof(string)));
                dtTreeParams.Columns.Add(new DataColumn("Nivel", typeof(string)));
                dtTreeParams.Columns.Add(new DataColumn("imgCtrl", typeof(string)));

                ElaborarArbolProp(_IdObjeto, null, 1);
                return dtTreeParams;
            }
            catch (Exception ex)
            {
            }
            return null;
        }


        public void LlenarGrilla(string strFilter)
        {
            throw new NotImplementedException();
        }

        public void LlenarJScript()
        {          
            ObjetoBE oObjetoBE = new ObjetoBE(); 
            this.EntityInJavascriptFromServer(oObjetoBE.GetType());
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

        protected void EasyGridViewParam_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                DataRowView drv = (DataRowView)e.Row.DataItem;
                DataRow dr = drv.Row;
                HtmlTable tblNodo = new HtmlTable();
                int Nivel = Convert.ToInt32(dr["Nivel"]);
                tblNodo = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(2, (Nivel + 1));
                tblNodo.Attributes["width"] = "100%";
                // tblNodo.Attributes["border"]="2";
                tblNodo.Rows[0].Cells[Nivel].InnerText = dr["Nombre"].ToString();
                tblNodo.Rows[1].Cells[Nivel].InnerText = dr["Descripcion"].ToString();
                tblNodo.Rows[0].Cells[Nivel].Attributes["width"] = "100%";
                tblNodo.Rows[0].Cells[Nivel].Style.Add("padding-left", "10px");
                tblNodo.Rows[1].Cells[Nivel].Style.Add("padding-left", "10px");
                tblNodo.Rows[1].Cells[Nivel].Style.Add("color", "dimgray");
                HtmlImage oImg = new HtmlImage();
                if (Convert.ToInt32(dr["NroHijos"]) > 0)
                {
                    tblNodo.Rows[0].Cells[Nivel].Style.Add("font-weight", "bold");
                    tblNodo.Rows[0].Cells[Nivel].Style.Add("font-size", "14px");

                    oImg.Src = EasyUtilitario.Constantes.ImgDataURL.IconTreeMinus;
                   
                    tblNodo.Rows[0].Cells[Nivel - 1].Controls.Add(oImg);
                    tblNodo.Rows[0].Cells[Nivel - 1].RowSpan = 2;
                    tblNodo.Rows[1].Cells[Nivel - 1].Style.Add("display", "none");

                    for (int i = 0; i <= (Nivel - 2); i++)
                    {
                        oImg = new HtmlImage();
                        oImg.Src = EasyUtilitario.Constantes.ImgDataURL.IconTreeSpace;
                        tblNodo.Rows[0].Cells[i].Controls.Add(oImg);
                        tblNodo.Rows[1].Cells[i].Controls.Add(oImg);
                    }
                }
                else
                {
                    for (int i = 0; i <= (Nivel - 1); i++)
                    {
                        oImg = new HtmlImage();
                        oImg.Src = EasyUtilitario.Constantes.ImgDataURL.IconTreeSpace;
                        tblNodo.Rows[0].Cells[i].Controls.Add(oImg);
                        tblNodo.Rows[1].Cells[i].Controls.Add(oImg);
                    }
                }
                //establece atributos para su control
                e.Row.Attributes["IdNodo"] = dr["IdNodo"].ToString();

                e.Row.Cells[0].Controls.Add(tblNodo);

                //tipo de control
                HtmlImage oimg = new HtmlImage();
                //oimg.Attributes["src"] = LstIconsCtrl[Convert.ToInt32(dr["IdTipoControl"].ToString())];
                oimg.Attributes["src"] = dr["imgCtrl"].ToString();


                //string cmll = "\"";

                HtmlTable CtrlTbl = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(1, 2);
              
               // CtrlTbl.Rows[0].Attributes[EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString()] = "CallPropiedades('" + dr["IdObjeto"].ToString() + "','" + dr["IdTipoControl"].ToString() + "')";
               //struct.Serialized(DataCtrlSeleccionado));
                CtrlTbl.Rows[0].Cells[0].Controls.Add(oimg);
                CtrlTbl.Rows[0].Cells[1].InnerText = dr["TipoControl"].ToString();
                CtrlTbl.Rows[0].Cells[1].Attributes["align"] = "left";

                CtrlTbl.Attributes.Add("class", "BaseItem");
                CtrlTbl.Attributes.Add("width", "100%");

                e.Row.Cells[4].Controls.Add(CtrlTbl);

            }
        }
    }
}