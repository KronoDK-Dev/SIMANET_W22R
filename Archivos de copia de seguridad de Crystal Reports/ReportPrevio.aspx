<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportPrevio.aspx.cs" Inherits="SIMANET_W22R.GestionReportes.ReportPrevio" %>

<%@ Register Src="~/Controles/Header.ascx" TagPrefix="uc1" TagName="Header" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>

</head>
<body>
    <form id="form1" runat="server">
        <table id="tblRpt" style="width: 100%;" border="0">
            <tr>
                <td>
                    <uc1:header runat="server" id="Header" />
                </td>
            </tr>
            <tr>
                <td style="width: 100%; height: 100%">
                    <iframe runat="server" id="RptPrevio" src="" allowtransparency="true" style="background-color: transparent; solid #000000; bottom: 0px; right: 0px; width: 100%; height: 100%; border: none; margin: 0; padding: 0; overflow: hidden; z-index: 999999;" frameborder="0"></iframe>
                </td>
            </tr>

        </table>

        <div class="c0142"></div>
        <div class="c0138">
            <div style="position: relative;">
                <button id="print" class="c0174 c0189 c0179 c0188 c0163 c0166" data-element-focusable="true" title="Imprimir (Ctrl+P)"><span class="c0180">
                    <div class="c0168">
                        <div aria-hidden="false" class="c0169">
                            <svg width="20" height="20" viewBox="0 0 20 20" class="">
                                <path d="M5 4.5C5 3.67 5.67 3 6.5 3h7c.83 0 1.5.67 1.5 1.5V5h.5A2.5 2.5 0 0118 7.5v5c0 .83-.67 1.5-1.5 1.5H15v1.5c0 .83-.67 1.5-1.5 1.5h-7A1.5 1.5 0 015 15.5V14H3.5A1.5 1.5 0 012 12.5v-5A2.5 2.5 0 014.5 5H5v-.5zM6 5h8v-.5a.5.5 0 00-.5-.5h-7a.5.5 0 00-.5.5V5zm-1 8v-1.5c0-.83.67-1.5 1.5-1.5h7c.83 0 1.5.67 1.5 1.5V13h1.5a.5.5 0 00.5-.5v-5c0-.83-.67-1.5-1.5-1.5h-11C3.67 6 3 6.67 3 7.5v5c0 .28.22.5.5.5H5zm1.5-2a.5.5 0 00-.5.5v4c0 .28.22.5.5.5h7a.5.5 0 00.5-.5v-4a.5.5 0 00-.5-.5h-7z" fill-rule="nonzero"></path></svg></div>
                    </div>
                </span></button>
            </div>
        </div>

    </form>

    <script>
        jNet.get("tblRpt").css("height", window.innerHeight + "px");

    </script>



</body>

</html>
