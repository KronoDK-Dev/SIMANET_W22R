using EasyControlWeb;
using EasyControlWeb.Filtro;
using EasyControlWeb.InterConeccion;
using SIMANET_W22R.InterfaceUI;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using static EasyControlWeb.EasyUtilitario.Enumerados;
using static EasyControlWeb.InterConeccion.EasyDataInterConect;

namespace SIMANET_W22R.GestionGobernanza.Indicadores
{
    public partial class ListarIndicadoresPorArea : GobernanzaBase, IPaginaBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                this.LlenarCombos();
                this.LlenarDatos(); 
            }
            catch (Exception ex)
            {

            }
        }

        DataTable LstIndicadoresPorArea()
        {
            EasyDataInterConect odi = new EasyDataInterConect();
            odi.ConfigPathSrvRemoto = "PathBaseWSCore";
            odi.MetodoConexion = MetododeConexion.WebServiceExterno;
            odi.UrlWebService = "GestionGobernanza/Indicadores.asmx";
            odi.Metodo = "ListarIndicadoresPorArea";

            EasyFiltroParamURLws oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "CodArea";
            oParam.Paramvalue = this.CodArea;

            oParam.TipodeDato = TiposdeDatos.String;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);

            oParam = new EasyFiltroParamURLws();
            oParam.ParamName = "UserName";
            oParam.Paramvalue = this.UsuarioLogin;
            oParam.ObtenerValor = EasyFiltroParamURLws.TipoObtenerValor.Fijo;
            odi.UrlWebServicieParams.Add(oParam);
            return odi.GetDataTable();
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
            this.ddlPeriodo.DataInterconect.UrlWebService = this.PathNetCore + "/General/General.asmx";
            this.ddlPeriodo.LoadData();
            this.ddlPeriodo.ID="ddl_" + this.CodArea;
        }

        public void LlenarDatos()
        {
            //Establece los nombres de controles segun area
            LsIndicadores.ID = "LstInd_" + this.CodArea;
            DetIndicador.ID = "DetInd_" + this.CodArea;

            int i = 0;
            string imgIndica = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC4AAAApCAMAAAB9Yuu9AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAHvUExURQAAAODg4MPDw5mZmd3d3aKiooKCgoqKisDAwM3NzdbW1nR0dFBQUHt7e2xsbE5OTrGxsZubm29vb9jY2LCwsEtLS6Ghoe/v79ra2nZ2dklJSdTU1OHh4ZycnHh4eL29vaenp01NTcfHx/v7+/Hx8Y+Pjzc3N4mJiYuLi42Njerq6ldXV8jIyMbGxnp6eoSEhE9PT6+vr4SEg1ZWVqysrLe3t7q6upqamkpKSnd3d9DQ0GVlZYODg7i4uKOjo5eXl8/Pz8zMzMXFxYaGhry8vIyMjNfX1z09PZiYmKSkpGNjY5KSko6OjltbW9XV1dzc3FxcXL+/v4GBgZ2dnV5eXmFhYWBgYNHR0bu7u2pqapOTk4WFhWRkZKmpqVNTU7a2tsvLy7S0tMHBwb6+vtnZ2XV1dVlZWcrKylhYWFpaWl9fX9LS0jk5OXBwcFJSUlFRUaCgoGhoaExMTDo6OsnJyaurqzw8PIiIiGlpac7OzrKysp6enn5+fkhISD8/P3FxcW5ubtPT04eHhz4+Pq2trZCQkH19fTs7O0VFRcLCwqWlpbm5uUdHR7W1tfb29unp6UBAQERERP7+/vPz8zMzM1RUVFVVVWZmZtvb25SUlDY2Nmtra0FBQUNDQ6ioqICAgO3t7bOzs0JCQq6urgAAAIvbXT8AAACldFJOU///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////ACB7zgQAAAAJcEhZcwAADsMAAA7DAcdvqGQAAALiSURBVEhLzZRrWxJBFIA3RNQkIRSLNTQsJMNripGaghEVhhcUUgmxSERJMsi7pGQWopRd7KZ2PT+0mZ1BVkEf+tb7Yc97DoflsDM7DGTGCRIYEGQJiR6DMFuUk4uFgTwuHkJ4kgqHMF98qkAiRXbEMKdlhdQwRfLiM2cVbAlpP0eKfJSlZdQw51XlFy6qK/KOvLtGdIkaJpetvJyn1SJjoCqb1PhU19TW1VPHXKloUMkbkaC/qiMlPk2VV/XXqGOaW7St17GkH6at3aBQGWmC6LhhIpK+PeumWXrrNk0QdyzlRNK3d94FsMqMXd00z++hwkAv/gsHMdvQnfvYfruD/IJZrOEibr83QDWJcbAY7ZIhtfO+3oXz8mE3Vz80zAjdDw+sD4lAC+tBV6nzEUkPto96x7g45KMbEMbGJwTdBs3+0qD2/T3g73ls42TSwQWMJ/BE4ZBM0Qy1u55SBY8kGHqGot9aSwoY6bhPOzpCE9Te0UkVOr3TM7Mojs1Nk0Iq/NktpSAangdYqEGX9PDa54OL0BxET3ipP7E8KfDaF/Voj7eGBx3PZbSSCgMmEdXlOvR0R2pWViaLaIWHgbyNDJS0cQKROgWRNAgGw+IXWJLDeFZfUkvB4NCuvXq9hizZ7oxSAeU6FYgtcGFjM/7mrU2FDpj9dvN4Yrk0W/YqYhvvvNw+r5d3vP9Q+ZE7CeIF3EeucIyLkLM6uF3Kmf9TdPszlq5tWVmMtSJjwKjEFfD1A3xpEvTaKmzw9RtXW5oxNa7ib0YmQqGQJYIsMUx7IA7zO7sqdk8NULjTg8b/vomWLGd3KTZl8fW5XHg3JdrXxT9+GuxepXvhF05LAnPOWbEday0rUWkXsWFo+7LeHQkGm0iCiA3Low0CmvCOXAY8aHWqw7+1Uf2Rzz0JelfRE/Gr1a2z9Cg5luQyZcR/1i6sN8Uz4Q8+qRmQsuGtTNgLoDcYDaMb0OncGYAX8Z9mB/gLhJoM+WWVTm0AAAAASUVORK5CYII=";
            DataTable dt = LstIndicadoresPorArea();
            if (dt != null)
            {
                HtmlTable tblBase = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(dt.Rows.Count, 1);
                tblBase.ID = "tbl_" + this.CodArea;

                foreach (DataRow dr in dt.Rows)
                {
                        HtmlTable tblInd = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(3, 3);
                       // tblInd.Attributes.Add("Loading", "0");
                        tblInd.Style.Add("width", "100%");
                        tblInd.Border =0;
                        tblInd.ID = "tbl_" + this.CodArea +"_" + dr["IDINDICADOR"].ToString();

                        HtmlImage oimg = new HtmlImage();
                        oimg.Src = imgIndica;

                        tblInd.Rows[0].Cells[0].Controls.Add(oimg);
                        tblInd.Rows[0].Cells[1].InnerText = dr["NOMBRE"].ToString();
                        tblInd.Rows[0].Cells[1].Style.Add("width", "100%");
                        tblInd.Rows[0].Cells[1].Attributes.Add("class", "Titulo");



                        oimg = new HtmlImage();
                        oimg.Src = EasyUtilitario.Constantes.ImgDataURL.IconConfig;
                        oimg.Attributes.Add("style", "cursor:pointer");
                        oimg.Attributes.Add(EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString(), "ListarIndicadoresPorArea.CondigIndicador(jNet.get(this.parentNode.parentNode.parentNode.parentNode),'" + dr["IDITEMINFOCOMPLE"].ToString() + "','" + dr["IDINDICADOR"].ToString() + "');");
                        oimg.Attributes.Add(EasyUtilitario.Enumerados.EventosJavaScript.onmouseover.ToString(), "jNet.get(this.parentNode.parentNode.parentNode.parentNode).attr('bloqueado','1')");
                        oimg.Attributes.Add(EasyUtilitario.Enumerados.EventosJavaScript.onmouseout.ToString(), "jNet.get(this.parentNode.parentNode.parentNode.parentNode).attr('bloqueado','0')");

                    tblInd.Rows[0].Cells[2].Controls.Add(oimg);

                        tblInd.Rows[1].Cells[0].InnerText = dr["DESCRIPCION"].ToString();
                        tblInd.Rows[1].Cells[0].Style.Add("width", "100%");

                        tblInd.Rows[1].Cells[0].Attributes.Add("colSpan", "3");
                        tblInd.Rows[1].Cells[1].Style.Add("DISPLAY", "NONE");
                        tblInd.Rows[1].Cells[2].Style.Add("DISPLAY", "NONE");

                        var IdProgress = "Prog_" + this.CodArea + "_" + dr["IDINDICADOR"].ToString();
                        string HtmlProgress = "  <div id='" + IdProgress + "_ContentProgress' class='progress progress-striped active' style='margin-left:0;margin-bottom:0;display:none;width: 100%;height: 100%;'>"
                            + "     <div  id='" + IdProgress + "_Progress' class='progress-bar' style='width: 100%;height: 100%;'>Load..</div>"
                            + " </div>";

                    
                        HtmlTable tblprogress = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(1, 1);
                        tblprogress.Style.Add("width", "20%");
                        tblprogress.Rows[0].Cells[0].Controls.Add(new LiteralControl(HtmlProgress));

                        tblInd.Rows[2].Cells[0].Attributes.Add("align", "right");

                        tblInd.Rows[2].Cells[0].Controls.Add(tblprogress);
                        tblInd.Rows[2].Cells[0].Attributes.Add("colSpan", "3");
                        tblInd.Rows[2].Cells[1].Style.Add("DISPLAY", "NONE");
                        tblInd.Rows[2].Cells[2].Style.Add("DISPLAY", "NONE");


                        tblInd.Attributes.Add("Data", EasyUtilitario.Helper.Genericos.DataRowToStringJson(dr));
                        tblInd.Attributes.Add(EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString(), "ListarIndicadoresPorArea.AdministraIndicador(jNet.get(this),'" + this.CodArea + "');");
                        tblInd.Attributes.Add("bloqueado", "0");
                


                    tblBase.Rows[i].Cells[0].Controls.Add(tblInd);
                    tblBase.Attributes.Add("class", "ItemObj");

                    i++;
                }
                //LsIndicadores.ID = "LstInd_" + this.CodArea; 
                LsIndicadores.Controls.Add(tblBase);
            }
           // DetIndicador.ID = "DetInd_" + this.CodArea;
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