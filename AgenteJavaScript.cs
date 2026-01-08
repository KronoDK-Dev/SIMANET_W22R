using EasyControlWeb;
using SIMANET_W22R.ClasesExtendidas;
using SIMANET_W22R.srvGestionCalidad;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace SIMANET_W22R
{
    public class AgenteJavaScript : PaginaBase
    {
        public void DataTableToXML(DataTable dt) {

            try
            {
                TransformsData(dt);
            }
            catch (Exception ex)
            {
                TransformsData(EasyUtilitario.Helper.Data.Error(this.GetPageName(), ex.Message));
            }
        }
        public void EntityToXML(object obj)
        {
            string returnCarr = EasyUtilitario.Constantes.Caracteres.RetornoCarr;
            string cmll = EasyUtilitario.Constantes.Caracteres.ComillaDoble;
            try
            {
                string Structura = "<DocumentElement>";
                if (obj == null)
                {
                    Structura += "<Error>";
                    Structura += returnCarr;
                    Structura += "<Number>0001</Number>";
                    Structura += returnCarr;
                    Structura += "<Descripcion>No DataFound</Descripcion>";
                    Structura += returnCarr;
                    Structura += "</Error>";
                    Structura += returnCarr;
                }
                else
                {
                    Type typeData = obj.GetType();
                    int idx = 0;
                    Structura += "<Entity Name='" + typeData.Name + "'>";
                    Structura += returnCarr;
                    foreach (var propertyInfo in typeData.GetProperties())
                    {
                        if (propertyInfo.GetValue(obj, propertyInfo.GetIndexParameters()) != null)
                        {
                            Structura += "<" + propertyInfo.Name.ToString() + ">" + propertyInfo.GetValue(obj, propertyInfo.GetIndexParameters()) + "</" + propertyInfo.Name.ToString() + ">";
                        }
                        else
                        {
                            Structura += "<" + propertyInfo.Name.ToString() + "/>";
                        }
                        Structura += returnCarr;
                    }
                    Structura += "</Entity>";
                }
                Structura += "</DocumentElement>";

                TransformsData(Structura);
            }
            catch (Exception ex)
            {
                TransformsData(EasyUtilitario.Helper.Data.Error(this.GetPageName(), ex.Message));
            }
        }

        void TransformsData(string StrSerializado)
        {
            Response.ClearContent();
            Response.Buffer = true;
            // Response.AddHeader("content-disposition", "attachment; filename=DemoExcel.xls");
            Response.ContentType = "text/xml"; ;
            Response.Charset = "";
            Response.Output.Write(StrSerializado);
            Response.Flush();
            Response.Close();

        }

        void TransformsData(DataTable dt)
        {
            string result;
            using (StringWriter sw = new StringWriter())
            {
                dt.WriteXml(sw);
                result = sw.ToString();
            }
            Response.ClearContent();
            Response.Buffer = true;
            // Response.AddHeader("content-disposition", "attachment; filename=DemoExcel.xls");
            Response.ContentType = "text/xml"; ;
            Response.Charset = "";
            Response.Output.Write(result);
            Response.Flush();
            Response.Close();

        }

   }
}