using EasyControlWeb;
using EasyControlWeb.Form.Controls;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using static EasyControlWeb.EasyUtilitario.Enumerados.Configuracion.SeccionKey;

namespace SIMANET_W22R
{
    public partial class Default : PaginaBase
    {
        EasyMessageBox oeasyMessageBox = new EasyMessageBox();
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                List<EasyNavigatorBE> oEasyNavigatorBElst = new List<EasyNavigatorBE>();
                oEasyNavigatorBElst = (List<EasyNavigatorBE>)Session["S_Historial"];

                ListarImagenes();

            }
            catch (Exception oException) {
                oeasyMessageBox = new EasyMessageBox();
                oeasyMessageBox.ID = "msgb";
                oeasyMessageBox.Titulo = "Nombre Aplicarivo";
                oeasyMessageBox.Contenido = oException.Message;
                oeasyMessageBox.Tipo = EasyUtilitario.Enumerados.MessageBox.Tipo.AlertType;
                oeasyMessageBox.AlertStyle = EasyUtilitario.Enumerados.MessageBox.AlertStyle.modern;
                Page.Controls.Add(oeasyMessageBox);
            }
        }

        void ListarImagenes() {
            string[] Ext = {".jpg", ".png"};
            string RutaImgLocal = EasyUtilitario.Helper.Configuracion.Leer("ConfigBase", "SliderIMG");
            string NombrePathSite = EasyUtilitario.Helper.Pagina.PathSite() + "/Recursos/img/Splash/";

            string[,] ClassSpeed = new string[19,2]{
                                                    {"item -normal","2"}
                                                    ,{"item -big","1"}
                                                    ,{"item -small -horizontal","4"}
                                                    ,{"item -normal","3"}
                                                    ,{"item -normal -horizontal","2"}
                                                    ,{"item -big -horizontal","4"}
                                                    ,{"item -small","2"}
                                                    ,{"item -normal -horizontal","1"}
                                                    ,{"item -small -horizontal","3"}
                                                    ,{"item -small -horizontal","1"}
                                                    ,{"item -normal -horizontal","2"}
                                                    ,{"item -normal -horizontal","1"}
                                                    ,{"item -small -horizontal","4"}
                                                    ,{"item -big","3"}
                                                    ,{"item -normal -horizontal","2"}
                                                    ,{"item -small -horizontal","4"}
                                                    ,{"item -big","2"}
                                                    ,{"item -normal -horizontal","1"}
                                                    ,{"item -small -horizontal","3"}
                                                     };



                    string[] archivos = Directory.GetFiles(RutaImgLocal).Where(f => Ext.Contains(new FileInfo(f).Extension.ToLower())).ToArray();
            int i = 0;
            foreach (string archivo in archivos)
            {
                if (i <= 19)
                {
                    string NomFile = archivo.Replace(RutaImgLocal, "");
                    string Clase = ClassSpeed[i, 0].ToString();

                    HtmlImage img = new HtmlImage();
                    img.Attributes["class"] = "image";
                    img.Attributes["src"] = NombrePathSite + NomFile;


                    HtmlGenericControl divFrag = EasyUtilitario.Helper.HtmlControlsDesign.CrearControl("div", Clase);
                    divFrag.Attributes["data-scroll data-scroll-speed"] = ClassSpeed[i,1].ToString();
                    divFrag.Controls.Add(img);

                    SliderContent.Controls.Add(divFrag);
                    i++;
                }
            }
        }

    }
}