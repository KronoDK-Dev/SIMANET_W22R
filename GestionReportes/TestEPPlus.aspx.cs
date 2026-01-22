using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SIMANET_W22R.GestionReportes
{
    public partial class TestEPPlus : System.Web.UI.Page
    {



        protected void Page_Load(object sender, EventArgs e)
        {
            OfficeOpenXml.ExcelPackage.LicenseContext = OfficeOpenXml.LicenseContext.NonCommercial;

            Response.Clear();
            Response.ClearHeaders();
            Response.ClearContent();

            Response.Buffer = true;
            Response.BufferOutput = true;
            Response.Charset = "";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("Content-Disposition", "attachment; filename=test.xlsx");

            using (var pck = new OfficeOpenXml.ExcelPackage())
            {
                var ws = pck.Workbook.Worksheets.Add("Prueba");
                ws.Cells["A1"].Value = "OK";

                using (var ms = new MemoryStream())
                {
                    pck.SaveAs(ms);
                    ms.Position = 0;
                    ms.WriteTo(Response.OutputStream);
                }
            }

            try
            {
                Response.Flush();
                Response.End();
            }
            catch
            {
                HttpContext.Current.ApplicationInstance.CompleteRequest();
            }
        }

    }
}