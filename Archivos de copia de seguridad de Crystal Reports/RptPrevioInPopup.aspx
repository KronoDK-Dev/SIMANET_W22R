<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RptPrevioInPopup.aspx.cs" Inherits="SIMANET_W22R.GestionReportes.RptPrevioInPopup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
       <table id= "tblRpt" style="width:100%;" border="3">
            <tr>
                <td style="width:100%;height:100%">
                     <iframe runat="server" id="RptPrevio" src="" allowtransparency="true" style="background-color:transparent; solid #000000; bottom:0px; right:0px; width:100%; height:100%; border:none; margin:0; padding:0; overflow:hidden; z-index:999999;"  frameborder="0" > </iframe>
                </td>
            </tr>
        </table>
    </form>

</body>
    <script>
        jNet.get("tblRpt").css("height", window.innerHeight + "px");
    </script>
</html>
