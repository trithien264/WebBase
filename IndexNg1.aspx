<%@ Page Language="C#" AutoEventWireup="true" CodeFile="IndexNg1.aspx.cs" Inherits="IndexNg1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" ng-app="ngMasterAg" ng-controller="ctrMasterAg">
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=7,IE=8,IE=9" />
    <link href="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/Css/IndexStyleNg.css" rel="stylesheet"
        type="text/css" />
    <link href="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/menu/menu.css" id="bootstrap_css"
        rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/Layout/Css/easyui.css">
    <script type="text/javascript" src="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/Js/jquery191.min.js"></script>
    <script type="text/javascript" src="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/Js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/Js/jquery.tabs.js"></script>
    <link href="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/Menu/J_MenuNg.css" rel="stylesheet"
        type="text/css" />
    <script src="<%= ResolveClientUrl("~/")%>Pub/jsModule/JQuery/JqueryService.js"></script>
    <style type="text/css">
        .btn-start
        {
            color: #7a1a7a !important;
        }
        
        .dropdown-submenu
        {
            position: relative;
        }
        
        .dropdown-submenu > .dropdown-menu
        {
            top: 0;
            left: 100%;
            margin-top: -6px;
            margin-left: -1px;
            -webkit-border-radius: 0 6px 6px 6px;
            -moz-border-radius: 0 6px 6px;
            border-radius: 0 6px 6px 6px;
        }
        
        .dropdown-submenu:hover > .dropdown-menu
        {
            display: block;
        }
        
        .dropdown-submenu > a:after
        {
            display: block;
            content: " ";
            float: right;
            width: 0;
            height: 0;
            border-color: transparent;
            border-style: solid;
            border-width: 5px 0 5px 5px;
            border-left-color: #ccc;
            margin-top: 5px;
            margin-right: -10px;
        }
        
        .dropdown-submenu:hover > a:after
        {
            border-left-color: #fff;
        }
        
        .dropdown-submenu.pull-left
        {
            float: none;
        }
        
        .dropdown-submenu.pull-left > .dropdown-menu
        {
            left: -100%;
            margin-left: 10px;
            -webkit-border-radius: 6px 0 6px 6px;
            -moz-border-radius: 6px 0 6px 6px;
            border-radius: 6px 0 6px 6px;
        }
    </style>
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        window.alert = function () { };
        var defaultCSS = document.getElementById('bootstrap_css');
        function changeCSS(css) {
            if (css) $('head > link').filter(':first').replaceWith('<link rel="stylesheet" href="' + css + '" type="text/css" />');
            else $('head > link').filter(':first').replaceWith(defaultCSS);
        }
        $(document).ready(function () {
            // var iframe_height = parseInt($('html').height());
            // window.parent.postMessage(iframe_height, 'http://bootsnipp.com');
        });
    </script>
    <script type="text/javascript">
        var Url = '<%= ResolveClientUrl("~/")%>';
        $(function () {

            var isFrameBusy = false;
            var sub_loadname = "load_";
            var isLoaded = false;
            /*HomeTab*/
            $(window).load(function () {

                if ('<%= Session["To_LinkPage"] %>' != "") {
                    addTab("", "Home", '<%= Session["To_LinkPage"] %>', true);
                }
                else {
                    addTab("", "Home", "Manager/Default.aspx", false);
                }
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
                addTab(mnuID, mnuName, mnuLink, true, mnuID);
            });
            var tab_index = 1;
            function addTab(mnuID, tab_name, tab_url, tab_close) {

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
                    content: '<div id="' + sub_loadname + tab_id + '" class="loadingAdmin" > </div><iframe  id="' + tab_id + '" name="' + tab_id + '" style="width: 100%; height: 100%;"     src="' + tab_url + '" frameborder="0"></iframe>',
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

                        }   //end if      
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
                            isFrameBusy = false;
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
        });              //end $(function ()





        function funReLogin() {
            chk = confirm("Bạn muốn đăng xuất hệ thống？");
            if (chk == true) {
                window.location.href = 'Default.aspx?Type=Logout';

            }
        }

    </script>
</head>
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
</style>
<%--Menu--%>
</head>
<body class="easyui-layout">
    <form id="form1" runat="server">
    <div data-options="region:'north',border:false" style="overflow: hidden; height: 100px">
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="area_top">
            <tr>
                <td style="width: 50px">
                    <div class="container" id="divContainerMenu" >
                        <%-- <div ng-bind-html="dataMenu"></div>--%>
                    </div>
                </td>
                <td style="width: 10px" class="btn-start">
                    ||
                </td>
                <td>
                    <div id="pnToolBar">
                        <table border="0" width="100%">
                            <tr>
                                <td style="height: 25px; vertical-align: middle">
                                    <table cellpadding="0" cellspacing="0" style="width: 100%" class="area_welcome" border="0">
                                        <tr>
                                            <td style="height: 25px; text-align: left; vertical-align: middle; width: 20%; white-space: nowrap">
                                                <span id="btn_MenuHide" class="btn_menuHide_0" onclick="fnMenu(-1)" title="隱藏選單"
                                                    style="color: #7a1a7a">&nbsp;</span> <span id="btn_MenuShow" class="btn_menuShow_0"
                                                        onclick="fnMenu(0)" title="顯示選單" style="display: none; color: #7a1a7a">&nbsp;</span>
                                                <span class="welcome">
                                                    <asp:Label ID="lblwelcome" runat="server" Text="Chào mừng " Style="color: #7a1a7a"></asp:Label><span
                                                        class="user01" style="color: #7a1a7a"><asp:LinkButton ID="lbllogin_user" runat="server"
                                                            Style="color: green"></asp:LinkButton></span><asp:Label ID="lblloginsys" runat="server"
                                                                Text=" đăng nhập hệ thống！" Style="color: #7a1a7a"></asp:Label></span>
                                            </td>
                                            <td style="vertical-align: middle; width: 10%">
                                                <img src="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/ImgBody/home.gif" width="18px"
                                                    alt="Home" />
                                            </td>
                                            <td style="vertical-align: middle; width: 20%; text-align: center">
                                                <a id="A1" href="javascript:void(0)" onclick="_onPrevious()">
                                                    <asp:Image ID="Image1" runat="server" ImageUrl='Pub/EasyLayout/ImgBody/previousover.gif' />Back&nbsp;
                                                </a><a id="A4" href="javascript:void(0)" onclick="_onNext()">
                                                    <asp:Image ID="imgNextOver" runat="server" ImageUrl='Pub/EasyLayout/ImgBody/NextOver.gif' />Forward&nbsp;
                                                </a><a id="ClickRefresh" href="javascript:void(0)">
                                                    <asp:Image ID="imgrefreshover" runat="server" ImageUrl='Pub/EasyLayout/ImgBody/refreshover.gif' />Refesh</a>
                                            </td>
                                            <td style="cursor: pointer; height: 25px; text-align: right; width: 20%">
                                                <div id="pnLogOut">
                                                    <span style="cursor: hand" onclick="funReLogin();">
                                                        <img style="text-align: right; vertical-align: middle;" src="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/ImgBody/logout_0.gif"
                                                            alt="LogOut" />
                                                    </span>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <div data-options="region:'center'">
        <%--fit="true" fullscreen layout content tab--%>
        <div id="TabLayout" class="easyui-tabs" style="width: 100%; height: 100%" fit="true">
        </div>
        <div data-options="region:'south',border:false">
            <div id="pnFooter" align="left">
                <div style="width: 100%; padding-top: 5px">
                </div>
            </div>
        </div>
        <script>
            var Url = '<%= ResolveClientUrl("~/")%>';

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
        </script>
        <script>
            Jquery.getService("WebBase.Base.Menu.GetMenubk", [{}], function (data) {
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
