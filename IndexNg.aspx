<%@ Page Language="C#" AutoEventWireup="true" CodeFile="IndexNg.aspx.cs" Inherits="IndexAg" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" ng-app="ngMasterAg" ng-controller="ctrMasterAg">
<head id="Head1" runat="server">
    <title></title>
       <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta http-equiv="X-UA-Compatible" content="IE=7,IE=8,IE=9,IE=10" />
    <link href="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/Css/IndexStyle.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/Layout/Css/easyui.css" />
    <script type="text/javascript" src="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/Js/jquery191.min.js"></script>
    <script type="text/javascript" src="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/Js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/Js/jquery.tabs.js"></script>
    <script src="<%= ResolveClientUrl("~/")%>Pub/jsModule/JQuery/JqueryService.js"></script>  
    <link href="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/Css/menu.css" rel="stylesheet"  type="text/css" />
    <link rel="stylesheet" type="text/css" href="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/Css/navigation.css" />
    <style>
        .loadingAdmin
        {
            position: absolute;
            background: url('Pub/EasyLayout/ImgBody/loading-bar.gif') #ffffff no-repeat 50% 30%;
            padding: 0px;
            margin: 0px;
            height: 100%;
            width: 100%;
            overflow: hidden;
            opacity: 1;
            filter: alpha(opacity=100) filter:1(opacity:100);
        }
        
        .iframeBody
        {
            background-image: url('<%= ResolveClientUrl("~/")%>Pub/EasyLayout/ImgBody/BgFrame.jpg') !important;
            background-position: bottom right !important;
            background-size: 100% 100%;
        }
    </style>
    <script type="text/javascript">

        var Url = '<%= ResolveClientUrl("~/")%>';
       
    </script>
    <script type="text/javascript">

        $(function () {
            /*if(detectIE().toString().toLowerCase()=="false") 
            {   
            alert("系統僅支援IE瀏覽器 !!!(Hệ thống chỉ hỗ trợ trên trình duyệt IE");
            window.location.href="Default.aspx";
            return;
            }*/
            function detectIE() {
                var ua = window.navigator.userAgent;
                var msie = ua.indexOf('MSIE ');
                var trident = ua.indexOf('Trident/');

                if (msie > 0) {
                    // IE 10 or older => return version number
                    return parseInt(ua.substring(msie + 5, ua.indexOf('.', msie)), 10);
                }

                if (trident > 0) {
                    // IE 11 (or newer) => return version number
                    var rv = ua.indexOf('rv:');
                    return parseInt(ua.substring(rv + 3, ua.indexOf('.', rv)), 10);
                }

                // other browser
                return false;
            }

            var isFrameBusy = false;
            var sub_loadname = "load_";
            var isLoaded = false;
            /*HomeTab*/
            $(window).load(function () {
                addTab("Home", "Default.aspx", false);

            });

            /*ClickTab*/
            $(".menu_Link").click(function () {
                if (isFrameBusy) {
                    alert("正在載入另一個頁面﹐請稍候...");
                    return;
                }
                var mnuName = $(this).attr("mnuName");
                var mnuLink = $(this).attr("mnuLink");
                var mnuID = $(this).attr("mnuID");

                //Insert Log
                try {
                    
                    if (mnuID != "") {
                        Ins_User_Log(mnuID);
                    }
                } catch (e) {
                }

                if (mnuLink.indexOf('ptarget=_blank') > -1) {
                    heightscreen = screen.height - 90;
                    widthscreen = screen.width - 20;
                    window.open("IndexWin.aspx?GoURL=" + encodeURIComponent(mnuLink), "_blank", "height=" + heightscreen + ",width=" + widthscreen + ",resizable=no,scrollbars=no,toolbar=no,menubar=no,location=no");
                    return;
                }
                else if (mnuLink.indexOf('ptargetSJS=_blank') > -1) {
                    heightscreen = screen.height - 90;
                    widthscreen = screen.width - 20;
                    window.open(mnuLink, "_blank", "height=" + heightscreen + ",width=" + widthscreen + ",resizable=no,scrollbars=no,toolbar=no,menubar=no,location=no");
                    return;
                }



                addTab(mnuName, mnuLink, true, mnuID);
            });
            var tab_index = 1;
            function addTab(tab_name, tab_url, tab_close, mnuID) {


                //check existed tab
                if ($('#TabLayout').tabs('exists', tab_name)) {
                    $('#TabLayout').tabs('select', tab_name);
                    return;
                } //end if the tab exists



                isFrameBusy = true;
                tab_id = "tabcontent_" + tab_index;
                tab_index++;
                $('#TabLayout').tabs('add', {
                    title: tab_name,
                    content: '<div id="' + sub_loadname + tab_id + '" class="loadingAdmin" > </div><iframe  id="' + tab_id + '" name="' + tab_id + '" style="width: 100%; height: 100%; "     src="' + tab_url + '" frameborder="0" class="iframeBody"></iframe>',
                    closable: eval(tab_close)
                });

                //Phan xu ly loading
                obj = $("#" + tab_id)[0];
                try {
                    obj.attachEvent('onload', function () { _fnframeLoad(tab_id) });
                } catch (e) {
                }
                obj.onload = function () {
                    _fnframeLoad(tab_id)
                }

            }

            //Select Tab: kiem tra xem con loading ko

            var _timer;


            $('#TabLayout').tabs({
                //border:false,
                onSelect: function (title, index) {
                    try {
                        clearInterval(_timer);
                        clearTimeout(_timer);
                        _timer.abort();
                    } catch (e) { }


                    $curFrame = getCurFrame();
                    tab_id = $curFrame.attr("id");
                    try {
                        obj = $(frames[tab_id].window)[0];
                    } catch (e) { }

                    CallBeforeUnload(obj, tab_id);

                    $divLoadFrame = $curFrame.prev();
                    //Khống chế lúc đang loading tab 1, thì chọn tab 2 , trở lại tab 1 vẫn còn loading        
                    try {
                        iframe = $curFrame[0];
                        iframe = iframe.contentWindow || iframe.contentDocument;
                        if (iframe.document) iframe = iframe.document;
                    }
                    catch (e) {
                        iframe = $(frames[$curFrame.attr("id")].document)[0];
                    }
                    //                    

                    _timer = setInterval(function () { //lặp tới khi trang load hoàn tất       

                        try {
                            if (iframe.readyState == 'complete') {
                                if ($divLoadFrame.is(":visible")) {
                                    isFrameBusy = false;
                                    $divLoadFrame.hide(); // Download is complete 
                                    clearInterval(_timer);
                                    clearTimeout(_timer);
                                }
                                clearInterval(_timer);
                                clearTimeout(_timer);
                            }
                        } catch (e) {
                            clearInterval(_timer);
                            clearTimeout(_timer);

                        }
                    }, 1)
                }
            });

            /**************** Loading ****************/

            function getCurFrame() {
                // get the selected tab panel and its tab object
                var pp = $('#TabLayout').tabs('getSelected');
                //var $fCurrent = pp.panel('options').tab;    // the corresponding tab object   
                var $fCurrent = pp.find("iframe");
                return $fCurrent;
            }

            function _fnframeLoad(tab_id) {

                var theframe;
                isFrameBusy = false;
                try {
                    obj = $(frames[tab_id].window)[0];
                }
                catch (e) { }


                /*** Hide loading ***/
                $curFrame = getCurFrame();
                $divLoadFrame = $curFrame.prev();
                //alert($divLoadFrame.attr("id"));

                $divLoadFrame.hide();

                CallBeforeUnload(obj, tab_id)



                //Trường hợp trang flash nổi lên trên   
                try {
                    $curFrame.contents().find("body").find("object").parent().html($curFrame.contents().find("body").find("object").parent().html().replace('VALUE="Window"', 'VALUE="opaque"'));
                } catch (e) {
                }




                //1 số trường hợp đặc biệt
                try {
                    iframe = $curFrame[0];
                    iframe = iframe.contentWindow || iframe.contentDocument;
                    if (iframe.document) iframe = iframe.document;
                }
                catch (e) {
                    iframe = $(frames[$curFrame.attr("id")].document)[0];
                }
                //      
                _timer = setInterval(function () { //lặp tới khi trang load hoàn tất       

                    try {
                        if (iframe.readyState == 'complete') {
                            if ($divLoadFrame.is(":visible")) {
                                isFrameBusy = false;
                                $divLoadFrame.hide(); // Download is complete 
                                clearInterval(_timer);
                                clearTimeout(_timer);
                            }
                            clearInterval(_timer);
                            clearTimeout(_timer);
                        }
                    } catch (e) {
                        clearInterval(_timer);
                        clearTimeout(_timer);

                    }
                }, 1)




            }


            function CallBeforeUnload(obj, tab_id) {
                try {
                    obj.attachEvent('onbeforeunload', function () { _fnframeUnLoad(tab_id) });
                } catch (e) { }
                obj.onbeforeunload = function () {
                    _fnframeUnLoad(tab_id);
                }
            }


            function _fnframeUnLoad(tab_id) {
                //--Khong che nhung truong hop dac biet, VD: D:\PCaWeb\ReportPortal\Program\Source\UserControl\ExportExcel.ascx
                try {
                    obj = $(frames[tab_id].window)[0];
                } catch (e) {
                    try {
                        obj = document.getElementById(tab_id).contentWindow.targetObject
                    }
                    catch (e) { }
                }

                try {

                    $curFrame = getCurFrame();
                    //if(obj.document.getElementById("hideLoadingPage").value=="true")                
                    if ($curFrame.contents().find('.hideLoadingPage').val() == "true") {
                        isFrameBusy = false;
                        //obj.document.getElementById("hideLoadingPage").value="false";
                        return;
                    }
                } catch (e) { }

                //---End

                $curFrame = getCurFrame();
                $divLoadFrame = $curFrame.prev();
                // alert($('#TabLayout').tabs('getSelected').panel('options').id)
                //alert( $('#TabLayout').tabs('getTabIndex',$('#TabLayout').tabs('getSelected')));                   

                if ($divLoadFrame) {
                    isFrameBusy = true;
                    $divLoadFrame.show();
                }



                window.onbeforeunload = null;
                window.onunload = null;
            }




            /**************** End Loading ****************/
        });          //end $(function ()



        //application
        $(document).ready(function () {

            var apID = '<%=Request.Params["ApID"] %>';
            if (apID == "104") {
                $("#tab104").hide();
                $("#tab183").show();
            }
            else {
                $("#tab104").show();
                $("#tab183").hide();
            }

        });

        function funReLogin() {
            chk = confirm("Bạn có muốn đăng xuất？");
            if (chk == true) {
                window.location.href = 'Default.aspx?Type=Logout';
            }
        }
        
    </script>
</head>
<body class="easyui-layout" style="overflow: hidden">
    <form id="form1" runat="server">
    <div data-options="region:'north',border:false,split:false">
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="area_topleftImg">
            <tr>
                <td style="text-align: right; vertical-align: top" class="area_topImg">
                    <table border="0" cellpadding="0" cellspacing="0" style="float: right">
                        <tr>
                            <td class="left_trans">
                            </td>
                            <td class="middle_trans" style="text-align: left; vertical-align: top">
                                <table border="0" cellpadding="4" cellspacing="0">
                                    <tr>
                                        <td style="text-align: left; vertical-align: middle">
                                            <span id="btn_MenuHide" class="btn_menuHide_0" onclick="fnMenu(-1)" title="隱藏選單">&nbsp;</span>
                                            <span id="btn_MenuShow" class="btn_menuShow_0" onclick="fnMenu(0)" title="顯示選單" style="display: none;">
                                                &nbsp;</span>
                                        </td>
                                        <td style="text-align: left; vertical-align: middle">
                                            <span class="welcome"></span>
                                        </td>
                                        <td style="text-align: left; vertical-align: top">
                                        </td>
                                        <td style="cursor: pointer; text-align: right; white-space: nowrap">
                                            <div id="pnLogOut">
                                                <span style="cursor: hand" onclick="funReLogin();">
                                                    <img style="text-align: right; vertical-align: middle;" src="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/ImgBody/logout_0.gif"
                                                        alt="登出系統" />
                                                </span>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td class="right_trans">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table style="width: 100%;" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td  style="background: #fff url(Pub/EasyLayout/ImgBody/menu.jpg) repeat-x;width: 99%; white-space: nowrap">
                                <div id="divContainerMenu">
                                </div>
                            </td>
                            <td style="text-align: right; white-space: nowrap; vertical-align: top">
                                <div id="pnToolBar_menu">
                                    <table border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td class="left_toolmenu">
                                                <img src="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/ImgBody/left_toolmenu.jpg" />
                                            </td>
                                            <td class="middle_toolmenu" style="text-align: left; vertical-align: top">
                                                <table border="0" cellpadding="2" cellspacing="0">
                                                    <tr>
                                                        <td style="vertical-align: middle; white-space: nowrap">
                                                            <table cellpadding="2" cellspacing="0" class="area_welcome" border="0">
                                                                <tr>
                                                                    <td style="vertical-align: middle; width: 10%; white-space: nowrap; text-align: center">
                                                                        <table border="0">
                                                                            <tr>
                                                                                <td>
                                                                                    <img src="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/ImgBody/home.gif" width="17px"
                                                                                        alt="登出系統" />
                                                                                </td>
                                                                                <td style="vertical-align: bottom">
                                                                                    <asp:LinkButton ID="linkmain" runat="server" Text="Home"></asp:LinkButton>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                    <td style="vertical-align: middle; width: 5%; text-align: center; white-space: nowrap">
                                                                        <table border="0" cellpadding="4">
                                                                            <tr>
                                                                                <td>
                                                                                    <a id="A1" href="javascript:void(0)" onclick="_onPrevious()">
                                                                                        <asp:Image ID="Image1" runat="server" ImageUrl='Pub/EasyLayout/ImgBody/previousover.gif' />Back
                                                                                    </a>
                                                                                </td>
                                                                                <td>
                                                                                    <a id="A4" href="javascript:void(0)" onclick="_onNext()">
                                                                                        <asp:Image ID="imgNextOver" runat="server" ImageUrl='Pub/EasyLayout/ImgBody/NextOver.gif' />Forward
                                                                                    </a>
                                                                                </td>
                                                                                <td>
                                                                                    <a id="ClickRefresh" href="javascript:void(0)">
                                                                                        <asp:Image ID="imgrefreshover" runat="server" ImageUrl='Pub/EasyLayout/ImgBody/refreshover.gif' />Refesh</a>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                    <td style="text-align: right; white-space: nowrap">
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td class="right_toolmenu">
                                                &nbsp;&nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                    <%--      <li class='toolbar_menu' style="float: right"></li>--%>
                </td>
            </tr>
        </table>
    </div>
    <div data-options="region:'center',split:false">
        <%--fit="true" fullscreen layout content tab--%>
        <div id="TabLayout" class="easyui-tabs" style="width: 100%; height: 100%" fit="true">
        </div>
    </div>
    <div data-options="region:'south',border:false,split:false" style="border-top: 1px solid #95B8E7">
    </div>
    <script>
        function Ins_User_Log(mnuID) {
            debugger
            Jquery.getService("Apps.Manage.Base.Index.RecordMenuAccess", [{ "menuID": mnuID }], function (data) {
                
            });
        }
        function getCurFrame() {
            // get the selected tab panel and its tab object
            var pp = $('#TabLayout').tabs('getSelected');
            //var $fCurrent = pp.panel('options').tab;    // the corresponding tab object   
            var $fCurrent = pp.find("iframe");
            return $fCurrent;
        }
        function _onPrevious() {

            $fCurrent = getCurFrame();
            $fCurrent[0].contentWindow.history.back();
        }
        function _onNext() {
            $fCurrent = getCurFrame();
            $fCurrent[0].contentWindow.history.forward();
        }



        $("#ClickRefresh").click(function () {
            $fCurrent = getCurFrame();
            $fCurrent.attr("src", $fCurrent.attr("src"));
        });

        function fnOpen(iType, iPos) {
            try {

                window.open("fDetailStatus.aspx");
            }
            catch (e) { }
        }


    </script>
    <script>
        Jquery.getService("WebBase.Base.Menu.GetMenu", [{}], function (data) {
            $("#divContainerMenu").html(data.Result);
        });

        //        NgJs.callService({
        //            url: NgJs.Url.get("WebBase.Base.Menu.GetMenu", [{}]),
        //            scope: "dataMenu",
        //            formatHtml: true /*,
        //            directiveId: "directivemenu",           
        //            restrict: 'A'*/
        //        });      
    </script>
    </form>
</body>
</html>
