<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TetDate.aspx.cs" Inherits="SIMANET_W22R.GestiondeCalidad.TetDate" %>

<%@ Register Assembly="EasyControlWeb" Namespace="EasyControlWeb.Form.Controls" TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>


      <!--******************************************STYLES****************************************************-->

        <link href="http://localhost/SIMANET_W22R/Recursos/css/bootstrap.min.css" rel="stylesheet" />

        <link href="http://localhost/SIMANET_W22R/Recursos/css/1.10.4.jquery-ui.css" rel="stylesheet" />
        <!--Control de fecha --->
        <link href="http://localhost/SIMANET_W22R/Recursos/css/1.4.1.bootstrap-datepicker3.css" rel="stylesheet" />

        <!--autobusqueda de l control de filtros-->
        <!--<link href="http://localhost/SIMANET_W22R/Recursos/css/jquery.inputpicker.css" rel="stylesheet" />-->

        <link href="http://localhost/SIMANET_W22R/Recursos/css/jquery-confirm.min.css" rel="stylesheet" />
        <link href="http://localhost/SIMANET_W22R/Recursos/css/font-awesome.min.css" rel="stylesheet" />
    
        <!--STYLOS SIIMA -->
        <link href="http://localhost/SIMANET_W22R/Recursos/css/StyleEasy.css" rel="stylesheet" />

        <!--******************************************SCRIIPTS****************************************************-->
        <script src="http://localhost/SIMANET_W22R/Recursos/Js/jquery-3.5.1.min.js"></script><!--se habilito para el ontrol de fecha  se encontraba deshabilitado por un tema de compatibilidad con otros controles-->

        <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>27/12/2022-->
        <script src="http://localhost/SIMANET_W22R/Recursos/Js/4.5.2.bootstrap.min.js"></script>
      
        <!--Confirm-->
        <script src="http://localhost/SIMANET_W22R/Recursos/Js/jquery-confirm.min.js"></script>

       

      

        <!-- PDFs y Tablas  -->
        <script src="http://localhost/SIMANET_W22R/Recursos/Js/1.5.3-jspdf.min.js"></script>
        <script src="http://localhost/SIMANET_W22R/Recursos/Js/3.5.6-jspdf.plugin.autotable.js"></script>
        <!--LIB SIMA-->
        <script src="http://localhost/SIMANET_W22R/Recursos/LibSIMA/Objetcs.js"></script>
        <script src="http://localhost/SIMANET_W22R/Recursos/LibSIMA/AccesoDatosBase.js"></script>
        <script src="http://localhost/SIMANET_W22R/Recursos/LibSIMA/SIMA.GidView.Entended.js"></script>
        <script src="http://localhost/SIMANET_W22R/Recursos/LibSIMA/HtmlToCanvas.js"></script>

        <!--Autobusqueda -->        
       <link href="http://code.jquery.com/ui/1.10.4/themes/ui-lightness/jquery-ui.css" rel="stylesheet"/>  


        <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type = "text/javascript"></script> 

        <!--datepicker-->
        <script src="http://localhost/SIMANET_W22R/Recursos/Js/1.4.1.bootstrap-datepicker.min.js"></script>

        <!--Librerias  para el control de menu-->
        <link href="http://localhost/SIMANET_W22R/Recursos/css/jqx.base.css" rel="stylesheet" />
        <link href="http://localhost/SIMANET_W22R/Recursos/css/jqx.light.css" rel="stylesheet" />

        <script src="http://localhost/SIMANET_W22R/Recursos/Js/jqxcore.js"></script>
        <script src="http://localhost/SIMANET_W22R/Recursos/Js/jqxmenu.js"></script>
        
	    <script>
            $.jqx.theme = 'light';
        </script>   

</head>
<body>
    <form id="form1" runat="server">
  
         <div id="EasyPopupInspeciones_LoadPage" style="height: 100%; width: 100%;">
             <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
             <title></title>    
             <form method="post" action="./HistorialdeInspeccion.aspx" id="formInspecciones">
                 <div class="aspNetHidden">
                     <input type="hidden" name="__EVENTTARGET" id="__EVENTTARGET" value="">
                     <input type="hidden" name="__EVENTARGUMENT" id="__EVENTARGUMENT" value="">
                     <input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwUKMTUxNzQ0MjM3Ng9kFgICAw9kFgICAQ88KwARAwAPFgoeC18hRGF0YUJvdW5kZx4LZHRDb2xlY2Npb24yohQAAQAAAP////8BAAAAAAAAAAwCAAAATlN5c3RlbS5EYXRhLCBWZXJzaW9uPTQuMC4wLjAsIEN1bHR1cmU9bmV1dHJhbCwgUHVibGljS2V5VG9rZW49Yjc3YTVjNTYxOTM0ZTA4OQUBAAAAFVN5c3RlbS5EYXRhLkRhdGFUYWJsZQMAAAAZRGF0YVRhYmxlLlJlbW90aW5nVmVyc2lvbglYbWxTY2hlbWELWG1sRGlmZkdyYW0DAQEOU3lzdGVtLlZlcnNpb24CAAAACQMAAAAGBAAAAKsKPD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTE2Ij8+DQo8eHM6c2NoZW1hIHhtbG5zPSIiIHhtbG5zOnhzPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1hNTFNjaGVtYSIgeG1sbnM6bXNkYXRhPSJ1cm46c2NoZW1hcy1taWNyb3NvZnQtY29tOnhtbC1tc2RhdGEiPg0KICA8eHM6ZWxlbWVudCBuYW1lPSJUYWJsZSI+DQogICAgPHhzOmNvbXBsZXhUeXBlPg0KICAgICAgPHhzOnNlcXVlbmNlPg0KICAgICAgICA8eHM6ZWxlbWVudCBuYW1lPSJJZERldGFsbGVJbnNwZWNjaW9uIiB0eXBlPSJ4czpzdHJpbmciIG1zZGF0YTp0YXJnZXROYW1lc3BhY2U9IiIgbWluT2NjdXJzPSIwIiAvPg0KICAgICAgICA8eHM6ZWxlbWVudCBuYW1lPSJGZWNoYSIgdHlwZT0ieHM6c3RyaW5nIiBtc2RhdGE6dGFyZ2V0TmFtZXNwYWNlPSIiIG1pbk9jY3Vycz0iMCIgLz4NCiAgICAgICAgPHhzOmVsZW1lbnQgbmFtZT0iRGVzY3JpcGNpb24iIHR5cGU9InhzOnN0cmluZyIgbXNkYXRhOnRhcmdldE5hbWVzcGFjZT0iIiBtaW5PY2N1cnM9IjAiIC8+DQogICAgICAgIDx4czplbGVtZW50IG5hbWU9IlJlY29tZW5kYWNpb25lcyIgdHlwZT0ieHM6c3RyaW5nIiBtc2RhdGE6dGFyZ2V0TmFtZXNwYWNlPSIiIG1pbk9jY3Vycz0iMCIgLz4NCiAgICAgICAgPHhzOmVsZW1lbnQgbmFtZT0iSWRDbGF1c3VsYSIgdHlwZT0ieHM6aW50IiBtc2RhdGE6dGFyZ2V0TmFtZXNwYWNlPSIiIG1pbk9jY3Vycz0iMCIgLz4NCiAgICAgICAgPHhzOmVsZW1lbnQgbmFtZT0iTm9tYnJlQ2xhdXN1bGEiIHR5cGU9InhzOnN0cmluZyIgbXNkYXRhOnRhcmdldE5hbWVzcGFjZT0iIiBtaW5PY2N1cnM9IjAiIC8+DQogICAgICAgIDx4czplbGVtZW50IG5hbWU9Ik5yb01nc1NlbmQiIHR5cGU9InhzOmludCIgbXNkYXRhOnRhcmdldE5hbWVzcGFjZT0iIiBtaW5PY2N1cnM9IjAiIC8+DQogICAgICAgIDx4czplbGVtZW50IG5hbWU9ImJvb2ttYXJrIiB0eXBlPSJ4czppbnQiIG1zZGF0YTp0YXJnZXROYW1lc3BhY2U9IiIgbWluT2NjdXJzPSIwIiAvPg0KICAgICAgPC94czpzZXF1ZW5jZT4NCiAgICA8L3hzOmNvbXBsZXhUeXBlPg0KICA8L3hzOmVsZW1lbnQ+DQogIDx4czplbGVtZW50IG5hbWU9InRtcERhdGFTZXQiIG1zZGF0YTpJc0RhdGFTZXQ9InRydWUiIG1zZGF0YTpNYWluRGF0YVRhYmxlPSJUYWJsZSIgbXNkYXRhOkxvY2FsZT0iIj4NCiAgICA8eHM6Y29tcGxleFR5cGU+DQogICAgICA8eHM6Y2hvaWNlIG1pbk9jY3Vycz0iMCIgbWF4T2NjdXJzPSJ1bmJvdW5kZWQiIC8+DQogICAgPC94czpjb21wbGV4VHlwZT4NCiAgPC94czplbGVtZW50Pg0KPC94czpzY2hlbWE+BgUAAADKBzxkaWZmZ3I6ZGlmZmdyYW0geG1sbnM6bXNkYXRhPSJ1cm46c2NoZW1hcy1taWNyb3NvZnQtY29tOnhtbC1tc2RhdGEiIHhtbG5zOmRpZmZncj0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTp4bWwtZGlmZmdyYW0tdjEiPg0KICA8dG1wRGF0YVNldD4NCiAgICA8VGFibGUgZGlmZmdyOmlkPSJUYWJsZTEiIG1zZGF0YTpyb3dPcmRlcj0iMCI+DQogICAgICA8SWREZXRhbGxlSW5zcGVjY2lvbj4yMDIyLTE8L0lkRGV0YWxsZUluc3BlY2Npb24+DQogICAgICA8RmVjaGE+MjkvMTIvMjAyMjwvRmVjaGE+DQogICAgICA8RGVzY3JpcGNpb24+cHJ1ZWJhPC9EZXNjcmlwY2lvbj4NCiAgICAgIDxSZWNvbWVuZGFjaW9uZXM+b3RyYXM8L1JlY29tZW5kYWNpb25lcz4NCiAgICAgIDxJZENsYXVzdWxhPjE8L0lkQ2xhdXN1bGE+DQogICAgICA8Tm9tYnJlQ2xhdXN1bGE+Q0xBVVNVTEExPC9Ob21icmVDbGF1c3VsYT4NCiAgICAgIDxOcm9NZ3NTZW5kPjE8L05yb01nc1NlbmQ+DQogICAgICA8Ym9va21hcms+MTwvYm9va21hcms+DQogICAgPC9UYWJsZT4NCiAgICA8VGFibGUgZGlmZmdyOmlkPSJUYWJsZTIiIG1zZGF0YTpyb3dPcmRlcj0iMSI+DQogICAgICA8SWREZXRhbGxlSW5zcGVjY2lvbj4yMDIyLTI8L0lkRGV0YWxsZUluc3BlY2Npb24+DQogICAgICA8RmVjaGE+MjgvMTIvMjAyMjwvRmVjaGE+DQogICAgICA8RGVzY3JpcGNpb24+cHJ1ZWJhIDA8L0Rlc2NyaXBjaW9uPg0KICAgICAgPFJlY29tZW5kYWNpb25lcz5wcnVlYmEgMDwvUmVjb21lbmRhY2lvbmVzPg0KICAgICAgPElkQ2xhdXN1bGE+MTwvSWRDbGF1c3VsYT4NCiAgICAgIDxOb21icmVDbGF1c3VsYT5DTEFVU1VMQTE8L05vbWJyZUNsYXVzdWxhPg0KICAgICAgPE5yb01nc1NlbmQ+MDwvTnJvTWdzU2VuZD4NCiAgICAgIDxib29rbWFyaz4yPC9ib29rbWFyaz4NCiAgICA8L1RhYmxlPg0KICA8L3RtcERhdGFTZXQ+DQo8L2RpZmZncjpkaWZmZ3JhbT4EAwAAAA5TeXN0ZW0uVmVyc2lvbgQAAAAGX01ham9yBl9NaW5vcgZfQnVpbGQJX1JldmlzaW9uAAAAAAgICAgCAAAAAAAAAP//////////Cx4ITm9PZlJvd3MCAh4LXyFJdGVtQ291bnQCAh4IZHRDbGllbnQF6RN2YXIgb0RUX0Vhc3lHcmlkVmlld0luc3BlY2lvbmVzPSBuZXcgU0lNQS5EYXRhLkRhdGFUYWJsZSgpOw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZhciBvRENfRWFzeUdyaWRWaWV3SW5zcGVjaW9uZXM9bnVsbDsNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2YXIgb0RSRWFzeUdyaWRWaWV3SW5zcGVjaW9uZXMgPSBudWxsOyBvRENfRWFzeUdyaWRWaWV3SW5zcGVjaW9uZXMgPSBuZXcgU0lNQS5EYXRhLkRhdGFDb2x1bW4oIklkRGV0YWxsZUluc3BlY2Npb24iKTsgb0RUX0Vhc3lHcmlkVmlld0luc3BlY2lvbmVzLkNvbHVtbnMuQWRkKG9EQ19FYXN5R3JpZFZpZXdJbnNwZWNpb25lcyk7IG9EQ19FYXN5R3JpZFZpZXdJbnNwZWNpb25lcyA9IG5ldyBTSU1BLkRhdGEuRGF0YUNvbHVtbigiRmVjaGEiKTsgb0RUX0Vhc3lHcmlkVmlld0luc3BlY2lvbmVzLkNvbHVtbnMuQWRkKG9EQ19FYXN5R3JpZFZpZXdJbnNwZWNpb25lcyk7IG9EQ19FYXN5R3JpZFZpZXdJbnNwZWNpb25lcyA9IG5ldyBTSU1BLkRhdGEuRGF0YUNvbHVtbigiRGVzY3JpcGNpb24iKTsgb0RUX0Vhc3lHcmlkVmlld0luc3BlY2lvbmVzLkNvbHVtbnMuQWRkKG9EQ19FYXN5R3JpZFZpZXdJbnNwZWNpb25lcyk7IG9EQ19FYXN5R3JpZFZpZXdJbnNwZWNpb25lcyA9IG5ldyBTSU1BLkRhdGEuRGF0YUNvbHVtbigiUmVjb21lbmRhY2lvbmVzIik7IG9EVF9FYXN5R3JpZFZpZXdJbnNwZWNpb25lcy5Db2x1bW5zLkFkZChvRENfRWFzeUdyaWRWaWV3SW5zcGVjaW9uZXMpOyBvRENfRWFzeUdyaWRWaWV3SW5zcGVjaW9uZXMgPSBuZXcgU0lNQS5EYXRhLkRhdGFDb2x1bW4oIklkQ2xhdXN1bGEiKTsgb0RUX0Vhc3lHcmlkVmlld0luc3BlY2lvbmVzLkNvbHVtbnMuQWRkKG9EQ19FYXN5R3JpZFZpZXdJbnNwZWNpb25lcyk7IG9EQ19FYXN5R3JpZFZpZXdJbnNwZWNpb25lcyA9IG5ldyBTSU1BLkRhdGEuRGF0YUNvbHVtbigiTm9tYnJlQ2xhdXN1bGEiKTsgb0RUX0Vhc3lHcmlkVmlld0luc3BlY2lvbmVzLkNvbHVtbnMuQWRkKG9EQ19FYXN5R3JpZFZpZXdJbnNwZWNpb25lcyk7IG9EQ19FYXN5R3JpZFZpZXdJbnNwZWNpb25lcyA9IG5ldyBTSU1BLkRhdGEuRGF0YUNvbHVtbigiTnJvTWdzU2VuZCIpOyBvRFRfRWFzeUdyaWRWaWV3SW5zcGVjaW9uZXMuQ29sdW1ucy5BZGQob0RDX0Vhc3lHcmlkVmlld0luc3BlY2lvbmVzKTsgb0RDX0Vhc3lHcmlkVmlld0luc3BlY2lvbmVzID0gbmV3IFNJTUEuRGF0YS5EYXRhQ29sdW1uKCJib29rbWFyayIpOyBvRFRfRWFzeUdyaWRWaWV3SW5zcGVjaW9uZXMuQ29sdW1ucy5BZGQob0RDX0Vhc3lHcmlkVmlld0luc3BlY2lvbmVzKTtvRFJfRWFzeUdyaWRWaWV3SW5zcGVjaW9uZXMgPSBvRFRfRWFzeUdyaWRWaWV3SW5zcGVjaW9uZXMubmV3Um93KCk7ICAgb0RSX0Vhc3lHcmlkVmlld0luc3BlY2lvbmVzWyJJZERldGFsbGVJbnNwZWNjaW9uIl0gPSAiMjAyMi0xIjsgICBvRFJfRWFzeUdyaWRWaWV3SW5zcGVjaW9uZXNbIkZlY2hhIl0gPSAiMjkvMTIvMjAyMiI7ICAgb0RSX0Vhc3lHcmlkVmlld0luc3BlY2lvbmVzWyJEZXNjcmlwY2lvbiJdID0gInBydWViYSI7ICAgb0RSX0Vhc3lHcmlkVmlld0luc3BlY2lvbmVzWyJSZWNvbWVuZGFjaW9uZXMiXSA9ICJvdHJhcyI7ICAgb0RSX0Vhc3lHcmlkVmlld0luc3BlY2lvbmVzWyJJZENsYXVzdWxhIl0gPSAiMSI7ICAgb0RSX0Vhc3lHcmlkVmlld0luc3BlY2lvbmVzWyJOb21icmVDbGF1c3VsYSJdID0gIkNMQVVTVUxBMSI7ICAgb0RSX0Vhc3lHcmlkVmlld0luc3BlY2lvbmVzWyJOcm9NZ3NTZW5kIl0gPSAiMSI7ICAgb0RSX0Vhc3lHcmlkVmlld0luc3BlY2lvbmVzWyJib29rbWFyayJdID0gIjEiOyBvRFRfRWFzeUdyaWRWaWV3SW5zcGVjaW9uZXMuUm93cy5BZGQob0RSX0Vhc3lHcmlkVmlld0luc3BlY2lvbmVzKTtvRFJfRWFzeUdyaWRWaWV3SW5zcGVjaW9uZXMgPSBvRFRfRWFzeUdyaWRWaWV3SW5zcGVjaW9uZXMubmV3Um93KCk7ICAgb0RSX0Vhc3lHcmlkVmlld0luc3BlY2lvbmVzWyJJZERldGFsbGVJbnNwZWNjaW9uIl0gPSAiMjAyMi0yIjsgICBvRFJfRWFzeUdyaWRWaWV3SW5zcGVjaW9uZXNbIkZlY2hhIl0gPSAiMjgvMTIvMjAyMiI7ICAgb0RSX0Vhc3lHcmlkVmlld0luc3BlY2lvbmVzWyJEZXNjcmlwY2lvbiJdID0gInBydWViYSAwIjsgICBvRFJfRWFzeUdyaWRWaWV3SW5zcGVjaW9uZXNbIlJlY29tZW5kYWNpb25lcyJdID0gInBydWViYSAwIjsgICBvRFJfRWFzeUdyaWRWaWV3SW5zcGVjaW9uZXNbIklkQ2xhdXN1bGEiXSA9ICIxIjsgICBvRFJfRWFzeUdyaWRWaWV3SW5zcGVjaW9uZXNbIk5vbWJyZUNsYXVzdWxhIl0gPSAiQ0xBVVNVTEExIjsgICBvRFJfRWFzeUdyaWRWaWV3SW5zcGVjaW9uZXNbIk5yb01nc1NlbmQiXSA9ICIwIjsgICBvRFJfRWFzeUdyaWRWaWV3SW5zcGVjaW9uZXNbImJvb2ttYXJrIl0gPSAiMiI7IG9EVF9FYXN5R3JpZFZpZXdJbnNwZWNpb25lcy5Sb3dzLkFkZChvRFJfRWFzeUdyaWRWaWV3SW5zcGVjaW9uZXMpOxYCHhBEYXRhQm91bmRDb2x1bW5zBbUBW3tUaXBvOiJUZW1wbGF0ZUZpZWxkIixEYXRhRmllbGQ6IiIsVmFsdWU6IiJ9LHtUaXBvOiJUZW1wbGF0ZUZpZWxkIixEYXRhRmllbGQ6IiIsVmFsdWU6IiJ9LHtUaXBvOiJUZW1wbGF0ZUZpZWxkIixEYXRhRmllbGQ6IiIsVmFsdWU6IiJ9LHtUaXBvOiJUZW1wbGF0ZUZpZWxkIixEYXRhRmllbGQ6IiIsVmFsdWU6IiJ9XQEQFgAWABYADBQrAAAWAmYPZBYEAgMPZBYIZg8PZBYCHwUFLHtUaXBvOiJUZW1wbGF0ZUZpZWxkIixEYXRhRmllbGQ6IiIsVmFsdWU6IiJ9ZAIBDw9kFgIfBQUse1RpcG86IlRlbXBsYXRlRmllbGQiLERhdGFGaWVsZDoiIixWYWx1ZToiIn1kAgIPD2QWAh8FBSx7VGlwbzoiVGVtcGxhdGVGaWVsZCIsRGF0YUZpZWxkOiIiLFZhbHVlOiIifWQCAw8PZBYCHwUFLHtUaXBvOiJUZW1wbGF0ZUZpZWxkIixEYXRhRmllbGQ6IiIsVmFsdWU6IiJ9ZAIED2QWCGYPD2QWAh8FBSx7VGlwbzoiVGVtcGxhdGVGaWVsZCIsRGF0YUZpZWxkOiIiLFZhbHVlOiIifWQCAQ8PZBYCHwUFLHtUaXBvOiJUZW1wbGF0ZUZpZWxkIixEYXRhRmllbGQ6IiIsVmFsdWU6IiJ9ZAICDw9kFgIfBQUse1RpcG86IlRlbXBsYXRlRmllbGQiLERhdGFGaWVsZDoiIixWYWx1ZToiIn1kAgMPD2QWAh8FBSx7VGlwbzoiVGVtcGxhdGVGaWVsZCIsRGF0YUZpZWxkOiIiLFZhbHVlOiIifWQYAQUXRWFzeUdyaWRWaWV3SW5zcGVjaW9uZXMPPCsADAEIAgFkkB/5BJkqFapE5JnIwMxsdPbsHNERB5y5TUZZnHJLwqM="></div>
                    <script type="text/javascript">//<![CDATA[var theForm = document.forms['formInspecciones'];if (!theForm) {    theForm = document.formInspecciones;}function __doPostBack(eventTarget, eventArgument) {    if (!theForm.onsubmit || (theForm.onsubmit() != false)) {        theForm.__EVENTTARGET.value = eventTarget;        theForm.__EVENTARGUMENT.value = eventArgument;        theForm.submit();    }}//]]></script>
                    <script>                                            
                        function RegistrarControl() {                                              // Implementado por:ROSALES Azabache EDDY                                            }                                            
                    </script>
                 
                 <div class="aspNetHidden">t
                     <input type="hidden" name="__VIEWSTATEGENERATOR" id="__VIEWSTATEGENERATOR" value="CF66647B">
                 </div>

                 <div>
                     <table cellspacing="0" rules="all" itemcolorseleccionado="#ffcc66" itemcolormousemove="#CDE6F7" databoundcolumns="[{Tipo:&quot;TemplateField&quot;,DataField:&quot;&quot;,Value:&quot;&quot;},{Tipo:&quot;TemplateField&quot;,DataField:&quot;&quot;,Value:&quot;&quot;},{Tipo:&quot;TemplateField&quot;,DataField:&quot;&quot;,Value:&quot;&quot;},{Tipo:&quot;TemplateField&quot;,DataField:&quot;&quot;,Value:&quot;&quot;}]" border="1" id="EasyGridViewInspeciones" style="width:100%;border-collapse:collapse;">
                         <tbody>
                             <tr class="HeaderGrilla" style="background-color:White;height:25px;">ttt
                                 <td colspan="4">
                                     <table style="width:100%;">tttt
                                         <tbody>
                                             <tr>ttttt
                                                 <td align="right" style="width:33.33%;white-space:pre-wrap;word-wrap:break-word;"></td>
                                                 <td align="justify" style="width:33.33%;white-space:pre-wrap;word-wrap:break-word;">
                                                     <button onclick="__doPostBack('EasyGridViewInspeciones$ctl01$CmdCommit','')" id="EasyGridViewInspeciones_CmdCommit" runat="server" style="display:none;">Commit;</button>
                                                 </td>
                                                 <td align="right" style="width:33.33%;white-space:pre-wrap;word-wrap:break-word;">
                                                     <a class="btn btn-primary" href="#" style="margin-top:5px;margin-right:5px;" onclick="EasyGridViewInspeciones_ToolBar_Onclick({Id:&quot;btnAgregar&quot;,Texto:&quot;Agregar&quot;,Descripcion:&quot;&quot;,Icono:&quot;fa fa-plus-square-o&quot;,RunAtServer:&quot;False&quot;,RequiereSelecciondeReg:&quot;True&quot;,SolicitaConfirmar:&quot;False&quot;,MsgConfirm:&quot;&quot;,Ubicacion:&quot;Derecha&quot;});">
                                                         <i class="fa fa-plus-square-o" style="color:white;margin-right:2px;"></i>
                                                         <span style="text-transform:capitalize; font-size:12px">Agregar</span>
                                                     </a>
                                                 </td>tttt
                                             </tr>ttt
                                         </tbody>
                                     </table>
                                 </td>tt
                             </tr>
                             <tr class="HeaderGrilla" tiporow="1" style="height:25px;">ttt
                                 <td colspan="4">DETALLE</td>tt
                             </tr>
                             <tr class="HeaderGrilla" tiporow="1" style="height:25px;">ttt
                                 <th scope="col">FECHA</th>
                                 <th scope="col">DESCRIPCION</th>
                                 <th scope="col">RECOMENDACIONES</th>
                                 <th scope="col">CLAUSULA</th>tt
                             </tr>
                             <tr class="ItemGrilla">ttt
                                 <td align="left" valign="top" databoundcolumns="{Tipo:&quot;TemplateField&quot;,DataField:&quot;&quot;,Value:&quot;&quot;}" style="width:15%;">
                                     <input name="EasyGridViewInspeciones$ctl04$FIni" type="text" value="29/12/2022" id="EasyGridViewInspeciones_FIni_0" class="form-control" autocomplete="off" data-validate="true" placeholder="" style="background:white url('data:image/gif;base64,R0lGODlhFgAUAHAAACH5BAEAADcALAAAAAAWABQAhQAAAISlvYScvYSlxmuU79bn/97v/3Oc/3ut/2ul/2uc/1qU/2OU/1KM78bW/87e90p71qXG/2uc94St/3Ol/2Oc/1qM91qM78bW91J73kJzzoyt74St72OU53Oc72OU70qE70p77zlz5zl77zlz3jlr3tbe79be5629ztbW5621zv///7W91rW9zt5zUud7UvfGtf/Ovf/Gtd5zSufn9+fv997n9wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAaxwJtwSCwaj8ikMCBoOp/PgVFAKBgOCERCsWA0HA+IYBqpSiaURKViuWAymnFRsOF0PITP5QIKiUYkJXJEAiYnKCkmKisrKIyLK4NDAicmKIYsj4wtjJJCAigqoaOipaGeNwKaK5yNjJmRU4yOK5C0kKgCKiwoLbu9Li8uLru5s6suMDEunbK1m4wuMTIvzXOkpMMuM6fOtCwmiuEtNDXGrrWGiIo1NqhMUPFNUkr19vdBADs=') right center no-repeat; padding-right:5px;;">
                                     <script>
                                            var EasyGridViewInspeciones_FIni_0_Config = { todayHighlight: true, language: 'zh-CN', autoclose: true, clearBtn: false, format: "dd/mm/yyyy" };
                                            $("#EasyGridViewInspeciones_FIni_0").datepicker(EasyGridViewInspeciones_FIni_0_Config).on('changeDate', function (e) { });
                                     </script>
                                 </td>
                                 <td align="left" valign="middle" databoundcolumns="{Tipo:&quot;TemplateField&quot;,DataField:&quot;&quot;,Value:&quot;&quot;}" style="width:30%;">
                                     <textarea name="EasyGridViewInspeciones$ctl04$txtDescrip" rows="2" cols="20" id="EasyGridViewInspeciones_txtDescrip_0" class="form-control" style="Width:100%;Height:100%;">prueba</textarea>
                                 </td>
                                 <td align="left" valign="middle" databoundcolumns="{Tipo:&quot;TemplateField&quot;,DataField:&quot;&quot;,Value:&quot;&quot;}" style="width:30%;">
                                     <textarea name="EasyGridViewInspeciones$ctl04$txtObs" rows="2" cols="20" id="EasyGridViewInspeciones_txtObs_0" class="form-control" style="Width:100%;Height:100%;">prueba</textarea>
                                 </td>
                                 <td align="left" valign="top" databoundcolumns="{Tipo:&quot;TemplateField&quot;,DataField:&quot;&quot;,Value:&quot;&quot;}" style="width:20%;">
                                     <select name="EasyGridViewInspeciones$ctl04$ctl00" class="form-control">tttt
                                         <option value="1">CLAUSULA1</option>ttt
                                     </select>
                                 </td>tt
                             </tr>
                             <tr class="AlternateItemGrilla">ttt
                                 <td align="left" valign="top" databoundcolumns="{Tipo:&quot;TemplateField&quot;,DataField:&quot;&quot;,Value:&quot;&quot;}" style="width:15%;">
                                     <input name="EasyGridViewInspeciones$ctl05$FIni" type="text" value="28/12/2022" id="EasyGridViewInspeciones_FIni_1" class="form-control" autocomplete="off" data-validate="true" placeholder="" style="background:white url('data:image/gif;base64,R0lGODlhFgAUAHAAACH5BAEAADcALAAAAAAWABQAhQAAAISlvYScvYSlxmuU79bn/97v/3Oc/3ut/2ul/2uc/1qU/2OU/1KM78bW/87e90p71qXG/2uc94St/3Ol/2Oc/1qM91qM78bW91J73kJzzoyt74St72OU53Oc72OU70qE70p77zlz5zl77zlz3jlr3tbe79be5629ztbW5621zv///7W91rW9zt5zUud7UvfGtf/Ovf/Gtd5zSufn9+fv997n9wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAaxwJtwSCwaj8ikMCBoOp/PgVFAKBgOCERCsWA0HA+IYBqpSiaURKViuWAymnFRsOF0PITP5QIKiUYkJXJEAiYnKCkmKisrKIyLK4NDAicmKIYsj4wtjJJCAigqoaOipaGeNwKaK5yNjJmRU4yOK5C0kKgCKiwoLbu9Li8uLru5s6suMDEunbK1m4wuMTIvzXOkpMMuM6fOtCwmiuEtNDXGrrWGiIo1NqhMUPFNUkr19vdBADs=') right center no-repeat; padding-right:5px;;">
                                     <script>
                                        var EasyGridViewInspeciones_FIni_1_Config = { todayHighlight: true, language: 'zh-CN', autoclose: true, clearBtn: false, format: "dd/mm/yyyy" };
                                        $("#EasyGridViewInspeciones_FIni_1").datepicker(EasyGridViewInspeciones_FIni_1_Config).on('changeDate', function (e) { });
                                     </script>
                                 </td>
                                 <td align="left" valign="middle" databoundcolumns="{Tipo:&quot;TemplateField&quot;,DataField:&quot;&quot;,Value:&quot;&quot;}" style="width:30%;">
                                     <textarea name="EasyGridViewInspeciones$ctl05$txtDescrip" rows="2" cols="20" id="EasyGridViewInspeciones_txtDescrip_1" class="form-control" style="Width:100%;Height:100%;">prueba 0</textarea>
                                 </td>
                                 <td align="left" valign="middle" databoundcolumns="{Tipo:&quot;TemplateField&quot;,DataField:&quot;&quot;,Value:&quot;&quot;}" style="width:30%;">
                                     <textarea name="EasyGridViewInspeciones$ctl05$txtObs" rows="2" cols="20" id="EasyGridViewInspeciones_txtObs_1" class="form-control" style="Width:100%;Height:100%;">prueba 0</textarea>
                                 </td>
                                 <td align="left" valign="top" databoundcolumns="{Tipo:&quot;TemplateField&quot;,DataField:&quot;&quot;,Value:&quot;&quot;}" style="width:20%;">
                                     <select name="EasyGridViewInspeciones$ctl05$ctl00" class="form-control">tttt
                                         <option value="1">CLAUSULA1</option>ttt
                                     </select>
                                 </td>tt
                             </tr>
                             <tr tiporow="3">ttt
                                 <td colspan="4" height="10">
                                     <button onclick="__doPostBack('EasyGridViewInspeciones$ctl06$btnExtendDet','')" id="EasyGridViewInspeciones_btnExtendDet" runat="server" style="display:none;">CallWebForm</button>
                                     <input name="EasyGridViewInspeciones$ctl06$txtIdRegSelected" type="text" id="EasyGridViewInspeciones_txtIdRegSelected" style="display:none;">
                                     <input name="EasyGridViewInspeciones$ctl06$txtIdxPag" type="text" value="0" id="EasyGridViewInspeciones_txtIdxPag" style="display:none;">
                                     <input name="EasyGridViewInspeciones$ctl06$txtSort" type="text" id="EasyGridViewInspeciones_txtSort" style="display:none;">
                                     <input name="EasyGridViewInspeciones$ctl06$txtIdSortField" type="text" id="EasyGridViewInspeciones_txtIdSortField" style="display:none;">
                                     <input name="EasyGridViewInspeciones$ctl06$txtIdSortA_D" type="text" id="EasyGridViewInspeciones_txtIdSortA_D" style="display:none;">
                                     <table id="EasyGridViewInspeciones_FooterButtons" border="0px" width="100%">tttt
                                         <tbody>
                                             <tr>ttttt
                                                 <td width="80%"></td>ttttt
                                                 <td width="20%" align="right">
                                                     <a class="btn btn-light" href="#" style="margin-top:5px;margin-right:5px;" onclick="EasyGridViewInspeciones_ToolBar_Onclick({Id:&quot;btnXLS&quot;,Texto:&quot;&quot;,Descripcion:&quot;&quot;,Icono:&quot;fa fa-file-excel-o&quot;,RunAtServer:&quot;True&quot;,RequiereSelecciondeReg:&quot;False&quot;,SolicitaConfirmar:&quot;False&quot;,MsgConfirm:&quot;&quot;,Ubicacion:&quot;Footer&quot;});">
                                                         <i class="fa fa-file-excel-o" style="color:black;margin-right:2px;"></i>
                                                         <span style="text-transform:capitalize; font-size:12px"></span>
                                                     </a>
                                                     <a class="btn btn-light" href="#" style="margin-top:5px;margin-right:5px;" onclick="EasyGridViewInspeciones_ToolBar_Onclick({Id:&quot;btnPDF&quot;,Texto:&quot;&quot;,Descripcion:&quot;&quot;,Icono:&quot;fa fa-file-pdf-o&quot;,RunAtServer:&quot;False&quot;,RequiereSelecciondeReg:&quot;False&quot;,SolicitaConfirmar:&quot;False&quot;,MsgConfirm:&quot;&quot;,Ubicacion:&quot;Footer&quot;});">
                                                         <i class="fa fa-file-pdf-o" style="color:black;margin-right:2px;"></i>
                                                         <span style="text-transform:capitalize; font-size:12px"></span>
                                                     </a>
                                                 </td>ttttt
                                                 <td>
                                                 </td>tttt
                                             </tr>ttt
                                         </tbody>
                                     </table>ttt
                                </td>tt
                             </tr>t
                         </tbody>
                     </table>
                 </div>
                 <script>SIMA.GridView.Extended.Paginacion.Apply('EasyGridViewInspeciones', '');</script>
                 <script>
                            function EasyGridViewInspeciones_OnDetalle(IdRow) {
                                $('#EasyGridViewInspeciones_txtIdRegSelected').val(IdRow); var ItemRowBE = oDT_EasyGridViewInspeciones.Rows[IdRow]; OnEasyGridDetalle_Click(ItemRowBE);
                            }
                 </script>
                 <script>
                            var oDT_EasyGridViewInspeciones = new SIMA.Data.DataTable();
                            var oDC_EasyGridViewInspeciones = null;
                            var oDREasyGridViewInspeciones = null;
                            oDC_EasyGridViewInspeciones = new SIMA.Data.DataColumn("IdDetalleInspeccion");
                            oDT_EasyGridViewInspeciones.Columns.Add(oDC_EasyGridViewInspeciones);
                            oDC_EasyGridViewInspeciones = new SIMA.Data.DataColumn("Fecha");
                            oDT_EasyGridViewInspeciones.Columns.Add(oDC_EasyGridViewInspeciones);
                            oDC_EasyGridViewInspeciones = new SIMA.Data.DataColumn("Descripcion");
                            oDT_EasyGridViewInspeciones.Columns.Add(oDC_EasyGridViewInspeciones);
                            oDC_EasyGridViewInspeciones = new SIMA.Data.DataColumn("Recomendaciones");
                            oDT_EasyGridViewInspeciones.Columns.Add(oDC_EasyGridViewInspeciones);
                            oDC_EasyGridViewInspeciones = new SIMA.Data.DataColumn("IdClausula");
                            oDT_EasyGridViewInspeciones.Columns.Add(oDC_EasyGridViewInspeciones);
                            oDC_EasyGridViewInspeciones = new SIMA.Data.DataColumn("NombreClausula");
                            oDT_EasyGridViewInspeciones.Columns.Add(oDC_EasyGridViewInspeciones);
                            oDC_EasyGridViewInspeciones = new SIMA.Data.DataColumn("NroMgsSend");
                            oDT_EasyGridViewInspeciones.Columns.Add(oDC_EasyGridViewInspeciones);
                            oDC_EasyGridViewInspeciones = new SIMA.Data.DataColumn("bookmark");
                            oDT_EasyGridViewInspeciones.Columns.Add(oDC_EasyGridViewInspeciones);
                            oDR_EasyGridViewInspeciones = oDT_EasyGridViewInspeciones.newRow();
                            oDR_EasyGridViewInspeciones["IdDetalleInspeccion"] = "2022-1";
                            oDR_EasyGridViewInspeciones["Fecha"] = "29/12/2022";
                            oDR_EasyGridViewInspeciones["Descripcion"] = "prueba";
                            oDR_EasyGridViewInspeciones["Recomendaciones"] = "otras";
                            oDR_EasyGridViewInspeciones["IdClausula"] = "1";
                            oDR_EasyGridViewInspeciones["NombreClausula"] = "CLAUSULA1";
                            oDR_EasyGridViewInspeciones["NroMgsSend"] = "1";
                            oDR_EasyGridViewInspeciones["bookmark"] = "1";
                            oDT_EasyGridViewInspeciones.Rows.Add(oDR_EasyGridViewInspeciones);
                            oDR_EasyGridViewInspeciones = oDT_EasyGridViewInspeciones.newRow();
                            oDR_EasyGridViewInspeciones["IdDetalleInspeccion"] = "2022-2";
                            oDR_EasyGridViewInspeciones["Fecha"] = "28/12/2022";
                            oDR_EasyGridViewInspeciones["Descripcion"] = "prueba 0";
                            oDR_EasyGridViewInspeciones["Recomendaciones"] = "prueba 0";
                            oDR_EasyGridViewInspeciones["IdClausula"] = "1";
                            oDR_EasyGridViewInspeciones["NombreClausula"] = "CLAUSULA1";
                            oDR_EasyGridViewInspeciones["NroMgsSend"] = "0";
                            oDR_EasyGridViewInspeciones["bookmark"] = "2";
                            oDT_EasyGridViewInspeciones.Rows.Add(oDR_EasyGridViewInspeciones);
                 </script>
                 <script>                                                        
                            function EasyGridViewInspeciones_ToolBar_Onclick(btnItem) {
                                var otxt = jNet.get('EasyGridViewInspeciones_txtIdRegSelected');
                                var oIdReg = otxt.value.replace(' ', '');
                                var ItemRowBE = ((oIdReg != '0') ? oDT_EasyGridViewInspeciones.Rows[oIdReg - 1] : null);
                                if (btnItem.RequiereSelecciondeReg.toLowerCase() == 'true') {
                                    if (oIdReg.length == 0) {
                                        $.alert({ title: 'Error', icon: 'fa fa-warning fa-4', type: 'red', closeIcon: true, content: 'Seleccionar un registro, para concretar esta operación', });
                                        return;
                                    }
                                    if (btnItem.SolicitaConfirmar.toLowerCase() == 'true') {
                                        $.confirm({ title: '', content: btnItem.MsgConfirm, icon: 'fa fa-question-circle', animation: 'scale', closeAnimation: 'scale', opacity: 0.5, buttons: { 'confirm': { text: 'Aceptar', btnClass: 'btn-blue', action: function () { if (btnItem.RunAtServer.toLowerCase() == 'true') { __doPostBack('EasyGridViewInspeciones$ctl01$CmdCommit', btnItem.Id); } else { OnEasyGridInspecionesButton_Click(btnItem, ItemRowBE); } } }, cancel: function () { }, } });
                                    } else { if (btnItem.RunAtServer.toLowerCase() == 'true') { __doPostBack('EasyGridViewInspeciones$ctl01$CmdCommit', btnItem.Id); } else { OnEasyGridInspecionesButton_Click(btnItem, ItemRowBE); } }
                                } else { if (btnItem.SolicitaConfirmar.toLowerCase() == 'true') { $.confirm({ title: '', content: btnItem.MsgConfirm, icon: 'fa fa-question-circle', animation: 'scale', closeAnimation: 'scale', opacity: 0.5, buttons: { 'confirm': { text: 'Aceptar', btnClass: 'btn-blue', action: function () { if (btnItem.RunAtServer.toLowerCase() == 'true') { __doPostBack('EasyGridViewInspeciones$ctl01$CmdCommit', btnItem.Id); } else { OnEasyGridInspecionesButton_Click(btnItem, ItemRowBE); } } }, cancel: function () { }, } }); } else { if (btnItem.RunAtServer.toLowerCase() == 'true') { __doPostBack('EasyGridViewInspeciones$ctl01$CmdCommit', btnItem.Id); } else { OnEasyGridInspecionesButton_Click(btnItem, ItemRowBE); } } }
                            }                                             </script><script>                                                (function () { window.setTimeout(EasyGridViewInspeciones_Integrar_EasyFiltro_View, 100); })(); function EasyGridViewInspeciones_Integrar_EasyFiltro_View() { try { var obj = jNet.get('_BarraFiltro'); var otblContext = jNet.get('EasyGridViewInspeciones_FooterButtons'); jNet.get(otblContext.rows[0].cells[0]).insert(obj); obj.css('display', 'block'); } catch (ex) { } }                                              </script>               </form>    </div>  





    </form>
</body>
</html>
