using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.InterConeccion;
using SIMANET_W22R.ClasesExtendidas;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using static EasyControlWeb.Form.Estilo.Bootstrap;

namespace SIMANET_W22R.SIMANET.SeguridadPlanta
{
    public partial class ListaTrabajadorEnFeriado : SeguridadPlantaBase, IPaginaBase
    {
        protected void Page_Load(object sender, EventArgs e)
        { 
            
            try
            {
                this.LlenarDatos();
                this.LlenarJScript();

            }
            catch (Exception ex)
            {
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
            if (this.LstNroDNI != null)
            {
                if (ViewState["DataTrab"] == null)
                {
                    DataTable dtv = new DataTable();
                    dtv.Columns.Add(new DataColumn("NroDNI", System.Type.GetType("System.String")));
                    dtv.Columns.Add(new DataColumn("ApellidosyNombres", System.Type.GetType("System.String")));

                    foreach (string dtTrab in this.LstNroDNI)
                    {
                        string[] trabajador = dtTrab.Split(',');
                        DataRow drv = dtv.NewRow();
                        DataTable dt = BuscarTrabajadorPorDNI(trabajador[0]);
                        if (dt != null)
                        {
                            DataRow dr = dt.Rows[0];
                            drv["NroDNI"] = trabajador[0];
                            drv["ApellidosyNombres"] = dr["ApellidosNombres"].ToString(); ;
                        }
                        dtv.Rows.Add(drv);
                        dtv.AcceptChanges();
                    }
                    ViewState["DataTrab"] = dtv;
                }
                PaintItemTrabajador();
            }



            //this.txtTrabajador.Text=this.ApellidosyNombres;
            //			this.Calendar1.SelectedDate = DateTime.Now;
            this.Calendar1.SelectedDate = DateTime.Now; //this.FechaVigente;
            this.Calendar1.SelectedDayStyle.BackColor = System.Drawing.Color.Beige;

            /*//Cragar Datos
            this.txtAño.Text = this.FechaVigente.Year.ToString();
            this.txtMes.Text = this.FechaVigente.Month.ToString();*/
            ViewState["Calendario"] = CalendariodeTrabajo("", DateTime.Now.Year.ToString(), DateTime.Now.Month.ToString());

        }
        void PaintItemTrabajador()
        {
            DataTable dtt = (DataTable)ViewState["DataTrab"];
            cellLstTrab.Controls.Clear();
            foreach (DataRow drt in dtt.Rows)
            {
                if (drt["NroDNI"].ToString().Length > 0)
                {
                    // cellLstTrab.Controls.Add(ItemTrabajkador(drt["NroDNI"].ToString(), drt["ApellidosyNombres"].ToString()));
                    cellLstTrab.Controls.Add(ItemTrabajkador(drt));
                }
            }
        }
        //HtmlTable ItemTrabajkador(string NroDNI, string ApellidosyNombres)
        HtmlTable ItemTrabajkador(DataRow dra)
        {
            HtmlTable tblLst = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(1, 3);
            tblLst.Attributes.Add("Data", EasyUtilitario.Helper.Genericos.DataRowToStringJson(dra));
            tblLst.ID = "tb_" + dra["NroDNI"].ToString();
            tblLst.Attributes["class"] = "BaseItemInGrid";
            tblLst.Rows[0].Cells[0].InnerText = dra["NroDNI"].ToString();
            tblLst.Rows[0].Cells[1].InnerText = dra["ApellidosyNombres"].ToString();
            tblLst.Rows[0].Cells[1].Attributes.Add("noWrap", "");
            HtmlImage img = new HtmlImage();
            img.Src = EasyUtilitario.Constantes.ImgDataURL.IconDelete;
            img.Attributes[EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString()] = "QuitarTrabajador(this);";
            tblLst.Rows[0].Cells[2].Controls.Add(img);

            return tblLst;
        }



        private DataTable BuscarTrabajadorPorDNI(string NroDNI)
        {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/SIMANET/SeguridadPlanta/Contratista.asmx";
            odi.Metodo = "BuscarTrabajadorxDNI_lst";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "NroDNI";
            oParam.Paramvalue = NroDNI;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);
            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);

            return odi.GetDataTable();

        }
        private DataTable CalendariodeTrabajo(string NroDNI, string Año, string Mes)
        {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.MetodoConexion = EasyDataInterConect.MetododeConexion.WebServiceExterno;
            odi.UrlWebService = this.PathNetCore + "/SIMANET/SeguridadPlanta/Contratista.asmx";
            odi.Metodo = "CalendarioTrabajo_lst";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "NroDNI";
            oParam.Paramvalue = NroDNI;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "Año";
            oParam.Paramvalue = Año;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "Mes";
            oParam.Paramvalue = Mes;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);


            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            oParam.TipodeDato = EasyUtilitario.Enumerados.TiposdeDatos.String;
            odi.UrlWebServicieParams.Add(oParam);

            return odi.GetDataTable();

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
            acJefe.DataInterconect.UrlWebService = this.PathNetCore + "SIMANET/SeguridadPlanta/Contratista.asmx";
            acTrab.DataInterconect.UrlWebService = this.PathNetCore + "SIMANET/SeguridadPlanta/Contratista.asmx";
            this.btnReload.Style.Add("display", "none");
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

        protected void Calendar1_DayRender(object sender, DayRenderEventArgs e)
        {
            if (!e.Day.IsOtherMonth && !e.Day.IsWeekend)
            {
                //e.Cell.BackColor=System.Drawing.Color.Yellow;
                if (e.Day.Date.Day != DateTime.Now.Day)
                {
                    e.Cell.BackColor = System.Drawing.ColorTranslator.FromHtml("#FFFFC0");
                }
                else
                {
                    //Calendar1.TodayDayStyle.CssClass = "BaseItemInGrid";
                    e.Cell.Attributes["class"] = "BaseItemInGrid";
                    e.Cell.Style.Add("Color", "blue");
                    e.Cell.Style.Add("font-size", "12px");
                    e.Cell.Style.Add("font-weight", "bold");
                }

            }


            //e.Day.IsWeekend
            /*if (e.Day.Date.Day == 18)
				e.Cell.BackColor = Color.LightBlue;*/

            e.Cell.Controls.Clear();

            /*HtmlTable tbl = Utilitario.Helper.CrearHtmlTabla(1,2,true);
			tbl.Rows[0].Cells[0].InnerText=e.Day.Date.Day.ToString();
*/
            e.Cell.Text = e.Day.Date.Day.ToString();
            if (ViewState["Calendario"] != null)
            {
                DataTable dt = (DataTable)ViewState["Calendario"];
                if (dt != null)
                {
                    string filtro = "Num_Dia=" + e.Day.Date.Day.ToString() + " and ((Ind_Hab='F')or (Ind_Hab='N')) and Mes=" + e.Day.Date.Month.ToString() + " and Ano=" + e.Day.Date.Year.ToString();
                    DataRow[] dr = dt.Select(filtro);
                    if ((dr != null) && (dr.Length > 0))
                    {
                        HtmlTable tbl = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(1, 2);
                        tbl.Rows[0].Cells[0].InnerText = e.Day.Date.Day.ToString();


                        CheckBox chk = new CheckBox();
                        chk.ID = "chk" + e.Day.Date.Day.ToString();
                        chk.Attributes["Fecha"] = e.Day.Date.ToShortDateString();
                        string IdEstado = dr[0]["IdEstado"].ToString();
                        chk.Checked = ((IdEstado == "1") ? true : false);
                        switch (dr[0]["Ind_Hab"].ToString())
                        {
                            case "F":
                                e.Cell.BackColor = System.Drawing.Color.Red;
                                tbl.Rows[0].Cells[1].Controls.Add(chk);
                                tbl.Rows[0].Cells[0].Style.Add("Color", "white");
                                tbl.Rows[0].Cells[0].Style.Add("font-weight", "bold");

                                break;
                            case "N":
                                string DiaSemana = e.Day.Date.DayOfWeek.ToString();
                                if ((DiaSemana.Equals(DayOfWeek.Sunday.ToString())))
                                {
                                    e.Cell.BackColor = System.Drawing.Color.Red;
                                    tbl.Rows[0].Cells[1].Controls.Add(chk);
                                    tbl.Rows[0].Cells[0].Style.Add("Color", "white");
                                    tbl.Rows[0].Cells[0].Style.Add("font-weight", "bold");
                                }

                                break;
                        }

                        e.Cell.Controls.Add(tbl);

                    }
                }
            }
        }

        protected void Calendar1_VisibleMonthChanged(object sender, MonthChangedEventArgs e)
        {

            /* string[] MesAño = e.NewDate.ToString("MM, yyyy").Split(',');
             this.txtAño.Text = MesAño[1];
             this.txtMes.Text = MesAño[0];*/
            ViewState["Calendario"] = CalendariodeTrabajo("", e.NewDate.Year.ToString(), e.NewDate.Month.ToString());
            // ViewState["Calendario"] = (new CCCTT_ProgramacionTrabajadoresContratista()).ListarCalendarioLaborable(this.txtNroDNI.Text, Convert.ToInt32(this.txtAño.Text), Convert.ToInt32(this.txtMes.Text));

        }

        protected void btnReload_Click(object sender, EventArgs e)
        {
            string ParamArgument = Page.Request.Params["__EVENTARGUMENT"]; ;
            if (ParamArgument.Length > 0)
            {
                string[] datos = ParamArgument.Split(',');
                DataTable dt = (DataTable)ViewState["DataTrab"];
                DataRow[] drs = dt.Select("NroDNI='" + datos[0] + "'");
                if (drs.Length == 0)
                {
                    DataRow drv = dt.NewRow();
                    drv["NroDNI"] = datos[0];
                    drv["ApellidosyNombres"] = datos[1];
                    dt.Rows.Add(drv);
                    dt.AcceptChanges();
                    ViewState["DataTrab"] = dt;
                }
                PaintItemTrabajador();
                this.LlenarJScript();
            }
        }
    }
}