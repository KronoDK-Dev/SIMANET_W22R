using EasyControlWeb;
using EasyControlWeb.Form.Controls;
using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.srvGestionReportes;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using static EasyControlWeb.EasyUtilitario.Enumerados;

namespace SIMANET_W22R.GestionReportes
{
    public partial class DetalleObjeto_Reporte : ReporteBase, IPaginaBase
    {
        string NombreDll = "SIMANET_W22R";
        EasyMessageBox oeasyMessageBox;
        DataTable dtTreeParams = new DataTable();
        string cmll = EasyUtilitario.Constantes.Caracteres.ComillaDoble.ToString();
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                this.LlenarJScript();
                this.LlenarDatos();
                this.LlenarGrilla();

            }
            catch (Exception ex)
            {
                int i = 0;
            }
        }
        public int Agregar()
        {
            throw new NotImplementedException();
        }

        public void CargarModoModificar()
        {
            try
            {
                string Nombre = "";
                AdministrarReportesSoapClient ogReports = new AdministrarReportesSoapClient();
                DataTable dt = ogReports.ListarCabeceradeReporte(this.IdObjeto, this.UsuarioLogin);
                DataRow dr = dt.Rows[0];

                this.txtNombreRpt.Text = dr["Nombre"].ToString();

                string[] PathFile = dr["Ref1"].ToString().Split(EasyUtilitario.Constantes.Caracteres.BackSlash);
                Nombre = PathFile[PathFile.Length - 1];
                PathFile = PathFile.Take(PathFile.Count() - 1).ToArray();
                string nPath = String.Join(EasyUtilitario.Constantes.Caracteres.BackSlash.ToString(), PathFile);
                this.EasyFindFileRpt.SetValue(Nombre, nPath);
                this.txtRutaRpt.Text = this.EasyFindFileRpt.GetValue();
                EasyUtilitario.Helper.Pagina.DEBUG(this.txtRutaRpt.Text);

                //Obtiene datos del servicio
                string PathService = dr["Ref2"].ToString();
                PathFile = PathService.Split('/');
                Nombre = PathFile[PathFile.Length - 1];
                this.EasyListaServiciosRpt.SetValue(Nombre, PathService);

                txtPathWebServiceSelected.Text = PathService.Substring(0, (PathService.Length - (Nombre.Length + 1)));
                //Obtener Datos del metodo
                this.EasyListarMetodosRpt.SetValue(dr["Ref3"].ToString(), "0");
            }
            catch (Exception ex)
            {
                oeasyMessageBox = new EasyMessageBox();
                oeasyMessageBox.ID = "msgb";
                oeasyMessageBox.Titulo = "Detalle de Reporte";
                oeasyMessageBox.Contenido = ex.Message;
                oeasyMessageBox.Tipo = EasyUtilitario.Enumerados.MessageBox.Tipo.AlertType;
                oeasyMessageBox.AlertStyle = EasyUtilitario.Enumerados.MessageBox.AlertStyle.modern;
                Page.Controls.Add(oeasyMessageBox);

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
            throw new NotImplementedException();
        }

        public void LlenarDatos()
        {
            //Copiar Dll
            ClonarAppDll();

            hPathRptConfig.Value = EasyUtilitario.Helper.Configuracion.Leer(EasyUtilitario.Enumerados.Configuracion.SeccionKey.Nombre.ConfigBase, "PathFileSourceRpts");
            switch (this.ModoPagina)
            {
                case EasyUtilitario.Enumerados.ModoPagina.N:
                    break;
                case EasyUtilitario.Enumerados.ModoPagina.M:
                    this.CargarModoModificar();

                    break;
            }
        }
        public void ClonarAppDll()
        {
            try
            {
                string NombreDLL = "bin\\" + NombreDll + ".dll";
                string PathOrigen = Page.Request.PhysicalApplicationPath.ToString() + NombreDLL;
                string PahtDestino = EasyUtilitario.Helper.Configuracion.Leer(EasyUtilitario.Enumerados.Configuracion.SeccionKey.Nombre.ConfigBase, "RutaFileDll");
                if (FileCompare(PathOrigen, PahtDestino) == false)
                {
                    if (File.Exists(PahtDestino))
                    {
                        File.SetAttributes(PahtDestino, FileAttributes.Normal);
                        File.Delete(PahtDestino);
                    }
                    File.Copy(PathOrigen, PahtDestino);
                }


            }
            catch { }
        }
        private bool FileCompare(string file1, string file2)
        {
            int file1byte = 0;
            int file2byte = 0;
            FileStream fs1 = null;
            FileStream fs2 = null;

            try
            {
                if (file1 == file2)
                {
                    return true;
                }
                fs1 = new FileStream(file1, FileMode.Open);
                fs2 = new FileStream(file2, FileMode.Open);
                if (fs1.Length != fs2.Length)
                {
                    fs1.Close();
                    fs2.Close();
                    return false;
                }
                do
                {
                    file1byte = fs1.ReadByte();
                    file2byte = fs2.ReadByte();
                }
                while ((file1byte == file2byte) && (file1byte != -1));
                fs1.Close();
                fs2.Close();
            }
            catch (Exception ex)
            {
                file2byte = 1;
                fs1.Close();
            }
            return ((file1byte - file2byte) == 0);
        }


        public void LlenarGrilla()
        {
            try
            {
                int id = ((this.ModoPagina == EasyUtilitario.Enumerados.ModoPagina.M) ? this.IdObjeto : -1);
                DataTable dt = CargarTree(id);
                EasyGridViewParamConfig.DataSource = dt;
                EasyGridViewParamConfig.DataBind();
            }
            catch (Exception ex)
            {
            }
        }

        public DataTable CargarTree(int _IdObjeto)
        {
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
                dtTreeParams.Columns.Add(new DataColumn("IdUsuarioAnalista", typeof(string)));
                dtTreeParams.Columns.Add(new DataColumn("IdUsuarioSolicitante", typeof(string)));




                ElaborarArbolProp(_IdObjeto, null, 1);
                return dtTreeParams;
            }
            catch (Exception ex)
            {
            }
            return null;
        }


        void ElaborarArbolProp(int _IdPadre, string IdNodo, int Nivel)
        {
            AdministrarReportesSoapClient ogReports = new AdministrarReportesSoapClient();
            DataTable dt = ogReports.ListarObjetos(_IdPadre.ToString(), this.UsuarioLogin);
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
                drnew["IdUsuarioAnalista"] = dr["IdUsuarioAnalista"].ToString();
                drnew["IdUsuarioSolicitante"] = dr["IdUsuarioAnalista"].ToString();

                //string strNodo = ((IdNodo == null) ? dr["IdObjeto"].ToString() : IdNodo + "." + dr["IdObjeto"].ToString()) + ".";
                string strNodo = ((IdNodo == null) ? dr["IdObjeto"].ToString() : IdNodo + "." + dr["IdObjeto"].ToString());
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


        public void LlenarGrilla(string strFilter)
        {
            throw new NotImplementedException();
        }

        public void LlenarJScript()
        {
            this.imgFnc.Attributes.Add("src", EasyUtilitario.Constantes.ImgDataURL.IconoFnc);
            this.imgConfig.Attributes.Add("src", EasyUtilitario.Constantes.ImgDataURL.IconConfig);
            this.ImgAdd.Attributes.Add("src", EasyUtilitario.Constantes.ImgDataURL.ArrowRight);
            this.ImgAdd.Attributes.Add(EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString(), "DetalleObjeto_Reporte.AddParam();");
            this.ImgRemove.Attributes.Add("src", EasyUtilitario.Constantes.ImgDataURL.ArrowLeft);
            this.ImgRemove.Attributes.Add(EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString(), "DetalleObjeto_Reporte.RemoveParam();");
            ObjetoBE oObjetoBE = new ObjetoBE();
            this.EntityInJavascriptFromServer(oObjetoBE.GetType());


            string Pagina = GetPageName();
            string FormReplicateConst = @" setTimeout(function(){
                                                    " + Pagina + @".PhysicalApplicationPath='" + Page.Request.PhysicalApplicationPath.ToString().Replace("\\", ".") + @"';
                                                    " + Pagina + @".NameSpaceBaseDll='" + NombreDll + @"';
                                            }, 500);";

            Page.RegisterClientScriptBlock("ValDef", "<script>\n" + FormReplicateConst + "\n" + "</script>");
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

        protected void EasyGridViewParamConfig_RowDataBound(object sender, GridViewRowEventArgs e)
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

                if (dr["IdTipo"].ToString().Equals("9"))
                {
                    string strData = "{Metodo:" + cmll + EasyListarMetodosRpt.GetText() + cmll + ",Parametro:" + cmll + dr["Ref1"].ToString() + cmll + ",Nombre:" + cmll + dr["Nombre"].ToString() + cmll + ",Descripcion:" + cmll + dr["Descripcion"].ToString() + cmll + ",Posicion:" + cmll + dr["Ref3"].ToString() + cmll + ",Tipo:" + cmll + dr["Ref2"].ToString() + cmll + ",TipoObj:" + cmll + dr["IdTipo"].ToString() + cmll + "}";
                    tblNodo.Attributes.Add("Data", strData);
                    tblNodo.Attributes.Add(EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString(), "DetalleObjeto_Reporte.ModifyParam(this);");
                }

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
                oimg.Attributes["src"] = dr["imgCtrl"].ToString();

                HtmlTable CtrlTbl = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(1, 3);
                CtrlTbl.Attributes.Add("id", "Ctrl_Link_" + dr["IdTipoControl"].ToString());


                // CtrlTbl.Rows[0].Attributes[EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString()] = "CallPropiedades('" + dr["IdObjeto"].ToString() + "','" + dr["IdTipoControl"].ToString() + "')";
                //struct.Serialized(DataCtrlSeleccionado));
                CtrlTbl.Rows[0].Cells[0].Controls.Add(oimg);
                CtrlTbl.Rows[0].Cells[1].InnerText = dr["TipoControl"].ToString();
                CtrlTbl.Rows[0].Cells[1].Attributes["align"] = "left";

                CtrlTbl.Attributes.Add("class", "BaseItem");
                CtrlTbl.Attributes.Add("width", "100%");

                HtmlImage oImgDel = new HtmlImage();
                oImgDel.Attributes.Add("src", EasyUtilitario.Constantes.ImgDataURL.ImgClose);
                oImgDel.Attributes.Add(EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString(), "EliminarCtrlLink(this);");
                oImgDel.Attributes.Add("CODIGO", dr["IdTipoControl"].ToString());
                if (dr["IdTipoControl"].ToString() != "1")
                {
                    CtrlTbl.Rows[0].Cells[2].Controls.Add(oImgDel);
                }

                e.Row.Cells[4].Controls.Add(CtrlTbl);
            }

        }
    }
}