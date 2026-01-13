using EasyControlWeb;
using EasyControlWeb.Filtro;
using SIMANET_W22R.Exceptiones;
using SIMANET_W22R.GestionReportes;
using SIMANET_W22R.InterfaceUI;
using SIMANET_W22R.srvGestionCalidad;
using SIMANET_W22R.srvSeguridad;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.IO.Packaging;
using System.Linq;

using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using static SIMANET_W22R.GestionReportes.GenerarPdf;

namespace SIMANET_W22R.GestiondeCalidad
{
    public partial class EnviarPorCorreo : PaginaCalidadBase,IPaginaBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    this.LlenarDatos();
                    this.LlenarJScript();

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
            UsuarioBE oUsuarioBE = this.DatosUsuario;
            //Card Perfil
            this.EasyCardPerfil1.PathFoto = EasyUtilitario.Helper.Configuracion.Leer(EasyUtilitario.Enumerados.Configuracion.SeccionKey.Nombre.ConfigBase, "PathFotos") + oUsuarioBE.NroDocumento + ".jpg";
            this.EasyCardPerfil1.ApellidosyNombres = oUsuarioBE.ApellidosyNombres;
            this.EasyCardPerfil1.Area= oUsuarioBE.Area;
            this.EasyCardPerfil1.Email = oUsuarioBE.Email;
            //

            this.tblEmail.Style.Add("padding-top", "5px");
            this.tblEmail.Style.Add("padding-left", "5px");

            HtmlTable otblMsg = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(1, 2);
            otblMsg.Attributes["class"] = "ItemContact";
            otblMsg.Attributes[EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString()] = "EasyDisplay('RowMsg');";

            HtmlImage oimgMsg = new HtmlImage(); 
            oimgMsg.Attributes["Width"] = "30px";
            oimgMsg.Attributes["src"] = EasyUtilitario.Constantes.ImgDataURL.IconMSG;

            otblMsg.Rows[0].Cells[0].Controls.Add(oimgMsg);
            otblMsg.Rows[0].Cells[0].Style.Add("padding-left", "5px");

            otblMsg.Rows[0].Cells[1].InnerText = "Mensaje";
            otblMsg.Rows[0].Cells[1].Style.Add("padding-right", "15px");
            this.tblEmail.Rows[4].Cells[0].Controls.Add(otblMsg);

            //Generar l Archivo de Reporte

            Dictionary<string, string> InfoRptBE = GenerarRI(this.IdInspeccion, this.IdReporteInspeccion,this.NroFichaTecnica,this.NombreProyecto, this.UsuarioId, this.UsuarioLogin);
            string HttpPathNameReporte = InfoRptBE["HttpPathNameReporte"].ToString();
            string NombreNuevo = InfoRptBE["NombreNuevo"].ToString();


            HtmlTable otblFileAdjunto = EasyUtilitario.Helper.HtmlControlsDesign.CrearTabla(1, 2);
            otblFileAdjunto.Attributes["class"] = "ItemContact";
            otblFileAdjunto.Attributes["title"] = HttpPathNameReporte;
            otblFileAdjunto.Attributes[EasyUtilitario.Enumerados.EventosJavaScript.onclick.ToString()] = "EasyDisplay('RowPrevio');";
            
            HtmlImage oimgFile = new HtmlImage(); 
            oimgFile.Attributes["Width"] = "30px";
            oimgFile.Attributes["src"] = EasyUtilitario.Constantes.ImgDataURL.IconPdf;

            otblFileAdjunto.Rows[0].Cells[0].Controls.Add(oimgFile);
            otblFileAdjunto.Rows[0].Cells[0].Style.Add("padding-left", "5px");

            otblFileAdjunto.Rows[0].Cells[1].InnerText = NombreNuevo;
            otblFileAdjunto.Rows[0].Cells[1].Style.Add("padding-right", "15px");

            this.tblEmail.Rows[4].Cells[0].Style.Add("padding-top", "5px");
            this.tblEmail.Rows[4].Cells[0].Style.Add("padding-left", "5px");
            this.tblEmail.Rows[4].Cells[0].Controls.Add(otblFileAdjunto);

            string RutaDefault = EasyUtilitario.Helper.Configuracion.Leer("ConfigBase", "PathFileRpt").Replace(EasyUtilitario.Constantes.Caracteres.BackSlash.ToString(), EasyUtilitario.Constantes.Caracteres.SignoArroba);
            RutaDefault = InfoRptBE["PathLocal"].ToString().Replace(EasyUtilitario.Constantes.Caracteres.BackSlash.ToString(), EasyUtilitario.Constantes.Caracteres.SignoArroba);
            string script = "var RutaFileAjunto= '" + RutaDefault +  EasyUtilitario.Constantes.Caracteres.SignoArroba + NombreNuevo + "';";
            
            Page.Controls.Add(new LiteralControl("<script>" + script + "</script>"));

            //Muestra el Reporte
            iPrevio.Src = HttpPathNameReporte;
        }


        public Dictionary<string,string> GenerarRI(string IdInspeccion,int IdReporteInspeccion,string NroReporte,string NombreProyecto,int IdUsuario,string UsuarioLogin) {
            string HttpPathNameReporte = "";
            string NombreNuevo = "RI-" + NombreProyecto + "-" + NroReporte + ".pdf";
            Dictionary<string, string> InfoRptBE= new Dictionary<string, string>();
            if (this.RI_Bloqueado == 0)
            {
                DataSet ds = (new Proceso()).ReporteFichaTecnica(IdInspeccion, IdReporteInspeccion, IdUsuario, UsuarioLogin);
                InfoRptBE = (new GenerarPdf()).CrearArchivo(IdReporteInspeccion, UsuarioLogin, ds);
                string RutaArchivoActual = InfoRptBE["PathLocal"].ToString() + "\\" + InfoRptBE["NombreGenerado"].ToString();
                HttpPathNameReporte = InfoRptBE["PathHTTPBaseUsr"] + "//" + NombreNuevo;
                string PathLocalNameReporte = InfoRptBE["PathLocal"].ToString() + "\\" + NombreNuevo;
                if (File.Exists(PathLocalNameReporte))
                {
                    File.Delete(PathLocalNameReporte);
                }
                System.IO.File.Move(RutaArchivoActual, PathLocalNameReporte);
            }
            else {//EnableTheming caso el archivo se encuentre bloqueado
                HttpPathNameReporte = EasyUtilitario.Helper.Configuracion.Leer("ConfigModCalidad", "HttpRIFinal") + UsuarioLogin + "/" + NombreNuevo;
                InfoRptBE["PathLocal"] = EasyUtilitario.Helper.Configuracion.Leer("ConfigModCalidad", "LocalRIFinal") + UsuarioLogin;
            }

            Dictionary<string, string> FileFIBE = new Dictionary<string, string>();
            FileFIBE.Add("HttpPathNameReporte", HttpPathNameReporte);
            FileFIBE.Add("NombreNuevo", NombreNuevo);
            FileFIBE.Add("PathLocal", InfoRptBE["PathLocal"].ToString());

            return FileFIBE;
        }

        string CrearHomeFinal(string UserName) {
            string PathBase = EasyUtilitario.Helper.Configuracion.Leer("ConfigModCalidad", "LocalRIFinal");
            string path = PathBase + UserName;
            string PathHome = "";
            try
            {
                if (Directory.Exists(path)==false)
                {
                    DirectoryInfo di = Directory.CreateDirectory(path);
                }
                PathHome = path;
            }
            catch (Exception e)
            {
                Console.WriteLine("The process failed: {0}", e.ToString());
            }
            finally { }

            return PathHome;
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

      
    }
}