<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleIncidnecia.aspx.cs" Inherits="SIMANET_W22R.HelpDesk.Incidencia.DetalleIncidnecia" %>



<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc1" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Filtro" TagPrefix="cc2" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb" TagPrefix="cc3" %>

<%@ Register assembly="EasyControlWeb" namespace="EasyControlWeb.Form.Base" tagprefix="cc4" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    

<style>

.containerFile {
  background-color: #ffffff;
  width: 100%;
  max-width: 80.37em;
  position: relative;
  margin: 3.12em auto;
  padding: 3.12em 1.25em;
  border-radius: 0.43em;
  box-shadow: 0 1.25em 2.18em rgb(1, 28, 71, 0.3);
}
input[type="file"] {
  display: none;
}
label {
  display: block;
  position: relative;
  background-color: #025bee;
  color: #ffffff;
  font-size: 1.12em;
  /*font-weight: 100;*/
  text-align: center;
  width: 3.75em;
  padding: 1.12em 0;
  margin: auto;
  border-radius: 0.31em;
  cursor: pointer;
}
#num-of-files {
  font-weight: 400;
  text-align: center;
  margin: 1.25em 0 1.87em 0;
}
.ulFile {
  list-style-type: none;
}
.containerFile li {
  font-weight: 500;
  background-color: #eff5ff;
  color: #025bee;
  margin-bottom: 1em;
  padding: 1.1em 1em;
  border-radius: 0.3em;
  display: flex;
  justify-content: space-between;
}
</style>
   
    


</head>
<body>
    <form id="form1" runat="server">
      
            <table style="width:100%;border="2" >
                <tr>
                    <td class="Etiqueta" reference="txtIdServicioArea">
                        AYUDA/SERVICIO-DESK:
                    </td>
                </tr>
                <tr>
                    <td align="left" style="border-color:red;">
                        <cc1:EasyPathHistory ID="EasyPathServiceDet" runat="server" fncPathOnClick="PathClick"></cc1:EasyPathHistory>
                    </td>
                </tr>
                <tr>
                    <td class="Etiqueta" reference="EasyTxtDescripcion">
                        DESCRIPCION 
                    </td>
                </tr>
                <tr>
                    <td>
                        <cc1:EasyTextBox ID="EasyTxtDescripcion" runat="server"  required TextMode="MultiLine" Height="50px" Width="100%"></cc1:EasyTextBox>
                    </td>
                </tr>          
                <tr>
                    <td>
                         <cc1:EasyUpLoadMultiple ID="EasyUpLoadMultiple2" runat="server" PaginaProceso="General/UpLoadMaster.aspx" fncItemComplete="ItemCargado" fncTempleteFile="CardUpload" Height="100px" Width="100%" >
                                <PathLocalyWeb CarpetaFinal="C:\AppWebs\AppTest\Archivos\HelpDesk\AllFiles\Final\"  CarpetaTemporal="C:\AppWebs\AppTest\Archivos\HelpDesk\AllFiles\Temporal\"/>
                         </cc1:EasyUpLoadMultiple>
                    </td>
                </tr>
        </table>


        <cc1:EasyPopupBase ID="EasyPopupUpLoad" runat="server" Titulo="Subir Archivos" RunatServer="false" DisplayButtons="true" >
        </cc1:EasyPopupBase>


    </form>

    <script>

        function ItemCargado(NombreItemSend, ItemsFiles) {
            // alert('Cargado al espacio temporal ' +NombreItemSend);
        }
        function CardUpload(oFileBE) {
            var cmll = "\"";
            return '<div class="cardFile">'
                + '      <div class="icon">'
                + '          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><g stroke-width="0" id="SVGRepo_bgCarrier"></g><g stroke-linejoin="round" stroke-linecap="round" id="SVGRepo_tracerCarrier"></g><g id="SVGRepo_iconCarrier"> <path stroke-linejoin="round" stroke-linecap="round" stroke-width="1.5" stroke="#ffffff" d="M20 14V17.5C20 20.5577 16 20.5 12 20.5C8 20.5 4 20.5577 4 17.5V14M12 15L12 3M12 15L8 11M12 15L16 11"></path> </g></svg>'
                + '      </div>'
                + '      <div class="icon">'
                + '          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-square-pen h-6 w-6 text-white" aria-hidden="true"><path d="M12 3H5a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path><path d="M18.375 2.625a1 1 0 0 1 3 3l-9.013 9.014a2 2 0 0 1-.853.505l-2.873.84a.5.5 0 0 1-.62-.62l.84-2.873a2 2 0 0 1 .506-.852z"></path></svg>'
                + '      </div>'

                + '      <div class="content">'
                + '        <span class="title">' + oFileBE.Nombre + '</span>'
                + '        <div class="desc">SIze:' + oFileBE.Size + ' Tipo:' + oFileBE.Tipo + '.</div>'
                + '      </div>'
                + '      <button type="button" class="closeX"  id="btnDel" idFile="' + oFileBE.Nombre + '" onclick="ItemFileToolBar(this)">'
                + '        <svg aria-hidden="true" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>'
                + '      </button>'
                + '</div> ';
        }


        DetalleIncidnecia.UpLoad = function () {
            EasyPopupUpLoad.Titulo = "Subir archivos de sustento";
            EasyPopupUpLoad.Show();
        }

    </script>


    

        <style>
            .cardFile {
                max-width: 420px;
                display: flex;
                align-items: flex-start;
                justify-content: space-between;
                border-radius: 0.5rem;
                background: #606c88;
                background: -webkit-linear-gradient(to right, #3f4c6b, #606c88);
                background: linear-gradient(to right top, #3f4c6b, #606c88);
                padding: 1rem;
                color: rgb(107, 114, 128);
               /* box-shadow: 0px 87px 78px -39px rgba(0,0,0,0.4);*/
                margin-bottom: 5px;
            }

        .icon {
          height: 2rem;
          width: 2rem;
          flex-shrink: 0;
          display: flex;
          align-items: center;
          justify-content: center;
          border-radius: 0.5rem;
          background-color: #153586;
          color: rgb(59, 130, 246);
           margin-right: 5px;
        }

        .icon svg {
          height: 1.25rem;
          width: 1.25rem;
        }

        .content {
          margin-left: 0.75rem;
          font-size: 0.875rem;
          line-height: 1.25rem;
          font-weight: 400;
        }

        .title {
          margin-bottom: 0.25rem;
          font-size: 0.875rem;
          line-height: 1.25rem;
          font-weight: 600;
          color: rgb(255, 255, 255);
        }

        .desc {
          margin-bottom: 0.5rem;
          font-size: 0.875rem;
          line-height: 1.25rem;
          font-weight: 400;
          color: rgb(202, 200, 200);
        }

        .actions {
          display: grid;
          grid-template-columns: repeat(2, minmax(0, 1fr));
          grid-gap: 0.5rem;
          gap: 0.5rem;
        }

        .download, .notnow {
          width: 100%;
          display: inline-flex;
          justify-content: center;
          border-radius: 0.5rem;
          padding: 0.375rem 0.5rem;
          text-align: center;
          font-size: 0.75rem;
          line-height: 1rem;
          color: rgb(255, 255, 255);
          outline: 2px solid transparent;
          border: 1px solid rgba(253, 253, 253, 0.363);
        }

        .download {
          background-color: #284385;
          font-weight: 600;
        }

        .download:hover {
          background-color: #153586;
        }

        .notnow {
          background-color: #606c88;
          font-weight: 500;
        }

        .notnow:hover {
          background-color: #3f4c6b;
        }

        .closeX {
          margin: -0.375rem -0.375rem -0.375rem auto;
          height: 2rem;
          width: 2rem;
          display: inline-flex;
          border-radius: 0.5rem;
          background-color: #606c88;
          padding: 0.375rem;
          color: rgba(255, 255, 255, 1);
          border: none;
        }

        .closeX svg {
          height: 1.25rem;
          width: 1.25rem;
        }

        .closeX:hover {
          background-color: rgb(58, 69, 83);
        }
    </style>

</body>
</html>
