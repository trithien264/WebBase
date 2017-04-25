<%@ Page Language="C#" AutoEventWireup="true" CodeFile="IndexNg.aspx.cs" Inherits="ngManager_IndexNg" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" ng-app="ngMasterAg" ng-controller="ctrMasterAg">
<head id="Head1" runat="server">
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta http-equiv="X-UA-Compatible" content="IE=7,IE=8,IE=9,IE=10" />

    <script src="<%= ResolveClientUrl("~/")%>Pub/libAngular/angularjs/angular.min.js"></script>
    <script src="<%= ResolveClientUrl("~/")%>Pub/libAngular/angularjs/angular-animate.js"></script>
    <script src="<%= ResolveClientUrl("~/")%>Pub/libAngular/angularjs/angular-touch.js"></script>


    <link href="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/bootstrap/css/bootstrap-glyphicons.css" rel="stylesheet" />
    <link href="<%= ResolveClientUrl("~/")%>Pub/libAngular/toas/css/toastr.css" rel="stylesheet" type="text/css" />
    <link href="<%= ResolveClientUrl("~/")%>Pub/libAngular/toas/css/custom.css" rel="stylesheet" type="text/css" />
    <script src="<%= ResolveClientUrl("~/")%>Pub/libAngular/toas/toastr.js" type="text/javascript"></script>
    <script src="<%= ResolveClientUrl("~/")%>Pub/libAngular/toas/toastr.tpl.js" type="text/javascript"></script>
    <link href="<%= ResolveClientUrl("~/")%>Pub/libAngular/loadingBar/loading-bar.css" rel="stylesheet" />
    <script src="<%= ResolveClientUrl("~/")%>Pub/libAngular/loadingBar/loading-bar.js"></script>

    <script type="text/javascript" src="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/Js/jquery191.min.js"></script>
    <link href="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/Css/IndexStyle.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/Layout/Css/easyui.css" />
    <script type="text/javascript" src="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/Js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/Js/jquery.tabs.js"></script>
    <script src="<%= ResolveClientUrl("~/")%>Pub/jsModule/JQuery/JqueryService.js"></script>
    <script src="<%= ResolveClientUrl("~/")%>Pub/jsModule/Angular/Util/Tools.js"></script>
    <script src="<%= ResolveClientUrl("~/")%>Pub/jsModule/Angular/Util/Language.js"></script>


    <link rel="stylesheet" type="text/css" href="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/NgMenu/sm-core-css.css">
    <link rel="stylesheet" type="text/css" href="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/NgMenu/sm-blue.css">

    <script type="text/javascript" src="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/NgMenu/jquery.smartmenus.js"></script>
    <link href="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/NgMenu/NgMenu.css" rel="stylesheet" />

    <script src="<%= ResolveClientUrl("~/")%>Pub/jsModule/Angular/Util/Service.js" type="text/javascript"></script>
    <script src="<%= ResolveClientUrl("~/")%>Pub/jsModule/Angular/Util/Url.js" type="text/javascript"></script>

    <style>
        .loadingAdmin {
            position: absolute;
            background: url('<%= ResolveClientUrl("~/")%>Pub/EasyLayout/ImgBody/loading-bar.gif') #ffffff no-repeat 50% 30%;
            padding: 0px;
            margin: 0px;
            height: 100%;
            width: 100%;
            overflow: hidden;
            opacity: 1;
            filter: alpha(opacity=100) filter:1(opacity:100);
        }

        .iframeBody {
            background-image: url('<%= ResolveClientUrl("~/")%>Pub/EasyLayout/ImgBody/BgFrame.jpg') !important;
            background-position: bottom right !important;
            background-size: 100% 100%;
        }

        .no-padding {
            padding: 0 !important;
            margin: 0 !important;
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

            function Ins_User_Log(mnuID) {                
                Jquery.getService("Apps.Manage.Base.Index.RecordMenuAccess", [mnuID*1], function (data) {

                });
            }

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
                    content: '<div id="' + sub_loadname + tab_id + '" class="loadingAdmin" > </div><iframe  id="' + tab_id + '" name="' + tab_id + '" style="width: 100%; height: 100%; "     src="' + Url + tab_url + '" frameborder="0" class="iframeBody"></iframe>',
                    closable: eval(tab_close)
                });

                //Hide menu
                var $mainMenuState = $('#main-menu-state');
                if ($mainMenuState.length) {

                    var $menu = $('#main-menu');
                    // animate mobile menu                  

                    $menu.hide();
                    $menu.css('display', '');

                    if ($mainMenuState[0].checked) {
                        $mainMenuState[0].click();
                    }



                }


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

            $('#editMyInfo').click(function () {
                addTab("Thông tin cá nhân", "Apps/Manage/Base/Users/UserInfo.aspx", true, "-1");
            });


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



    </script>
</head>
<body class="easyui-layout" style="overflow: hidden">
    <form id="form1" runat="server">
        <div data-options="region:'north',border:false,split:false">
            <nav class="main-nav" role="navigation">
                <!-- Mobile menu toggle button (hamburger/x icon) -->
                           
                    <input id="main-menu-state" type="checkbox" />                
                    <label class="main-menu-btn" for="main-menu-state"> 
                        <span class="main-menu-btn-icon"></span>
                    </label>                           
                <div class="nav-brand"><a href="IndexNg.aspx" style="float:left">
                    <img src="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/NgMenu/img/home-icon.png"   style="width:25px" /></a><a style="float:left" id="lblUser"></a></div>

                <!-- Sample menu definition -->
                <ul id='main-menu' class='sm sm-blue'>                   
                    <div id="divContainerMenu">
                    </div>    
                     <li style="float:right; right: 0px">
                        <a href="#" style="padding: 4px auto 4px 4px" id="lblLang"><img style="width:18px" src="../../Pub/EasyLayout/ImgBody/flag/vn.svg" /></a>
                         <ul id='ulContainerLanguage'>
                         </ul>
                       
                        <%--<ul>
                            <li><a href="#" ><img class="menuicon" style="width:18px" src="../../Pub/EasyLayout/ImgBody/flag/vn.svg"  />&nbsp;&nbsp;Việt Nam</a></li>               
                            <li><a href="#" ><img class="menuicon"  style="width:18px" src="../../Pub/EasyLayout/ImgBody/flag/us.svg"  />&nbsp;&nbsp;English</a></li>               
                        </ul>--%>
                    </li>
                     <li style="float:right; right: 0px">
                        <a href="#" style="padding: 8px auto 8px 15px" id="lblInfoUser"><img style="width:13px" src="../../Pub/EasyLayout/Layout/icons/Icon-user.png" /></a>
                        <ul>
                               <li><a href='#' id="editMyInfo"><span class="menuicon glyphicon glyphicon-user"></span><span n-lang="lbl00001">Quản lý thông tin cá nhân</span></a></li> 
                               <li><a href='#' ng-click="Logout()"><span class="menuicon glyphicon glyphicon-log-out" ></span><span n-lang="lbl00002">Đăng xuất</span></a></li> 
                        </ul>
                    </li>                                           
                </ul>
            </nav>
        </div>
        <div data-options="region:'center',split:false">
            <%--fit="true" fullscreen layout content tab--%>
            <div id="TabLayout" class="easyui-tabs" style="width: 100%; height: 100%" fit="true">
            </div>
        </div>
        <div data-options="region:'south',border:false,split:false" style="border-top: 1px solid #95B8E7">
        </div>
        <script>
          
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
        <script type='text/javascript'>//<![CDATA[

            // SmartMenus init
            $(function () {
                $('#main-menu').smartmenus({
                    subMenusSubOffsetX: 1,
                    subMenusSubOffsetY: -8,
                });

                $('#main-menu-user').smartmenus({
                    subMenusSubOffsetX: 1,
                    subMenusSubOffsetY: -8,
                });
            });

            // SmartMenus mobile menu toggle button
            $(function () {
                var $mainMenuState = $('#main-menu-state');
                if ($mainMenuState.length) {
                    // animate mobile menu
                    $mainMenuState.change(function (e) {
                        var $menu = $('#main-menu');
                        if (this.checked) {
                            $menu.hide().slideDown(250, function () { $menu.css('display', ''); });
                        } else {
                            $menu.show().slideUp(250, function () { $menu.css('display', ''); });
                        }
                    });
                    // hide mobile menu beforeunload
                    /*$(window).bind('beforeunload unload', function () {
                        
                        if ($mainMenuState[0].checked) {
                            $mainMenuState[0].click();
                        }
                    });*/
                }
            });
            //]]> 

        </script>

        <script>
            // tell the embed parent frame the height of the content
            if (window.parent && window.parent.parent) {
                window.parent.parent.postMessage(["resultsFrame", {
                    height: document.body.getBoundingClientRect().height,
                    slug: "oxe40pat"
                }], "*")
            }
        </script>
        <script>

            app = angular
             .module('ngMasterAg', ['toastr', 'chieffancypants.loadingBar', 'ngTouch'])
            
            //Init Language
            NgJs.Language.onLoad(app, '<%= ResolveClientUrl("~/")%>');

            //register user page
            app.controller('ctrMasterAg', function ($rootScope,$scope, $sce, $location, $timeout, $http, toastr, toastrConfig, cfpLoadingBar) {
             
                $scope.Logout = function () {
                    NgJs.callService({
                        url: "Apps.ui.Apps.User.Users.LogoutUser",
                        params: [{}],
                        http: $http,
                        toastr: toastr,
                        toastrConfig: toastrConfig,
                        cfpLoadingBar: cfpLoadingBar,
                        scope: $scope
                    }).then(function (res) {
                        if (res && res.data && res.data.Result) {
                            window.location.href = Url + 'Apps/ui/User/UserInfo.aspx#/loginuser';
                        }
                    });
                }

                $scope.changeLang = function (lang) {                                        
                    var cookieLang = NgJs.Tools.getCookie("LANGUAGE");

                    if (cookieLang == lang) return;

                    var entity = {};
                    entity.lang_value = lang;
                    NgJs.callService({
                        url: "Apps.Manage.Base.Index.ChangeLanguage",
                        params: [entity],
                        http: $http,
                        toastr: toastr,
                        toastrConfig: toastrConfig,
                        cfpLoadingBar: cfpLoadingBar,
                        scope: $scope
                    }).then(function (res) {                       
                        window.location.href = window.location.href;                                               
                    });
                }

            });

            function GenToolbarMenu(data)
            {                
                $("#lblUser").html("<n-lang code='lbl0003'>Welcome</n-lang> <strong>" + data.UserInfo.user_desc) + "</strong>";                
                $("#lblInfoUser").attr("title", "Account : " + data.UserInfo.user_desc + "\n" + data.UserInfo.email + "(" + data.UserInfo.user_id + ")");
                $("#lblUser").attr("title", $("#lblInfoUser").attr("title"));
                $("#divContainerMenu").replaceWith(data.MenuInfo);
                $("#ulContainerLanguage").html(data.Languages);                
            }

            Jquery.getService("Apps.Manage.Base.Index.GetIndexInfo", [{}], function (data) {
                if (data && data.Message) { //Error Login
                    alert(data.Message);
                    return;
                } 
                GenToolbarMenu(data.Result);        

            });


        </script>
    </form>
</body>
</html>
