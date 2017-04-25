<%@ Page Language="C#" AutoEventWireup="true" CodeFile="IndexNg - Copy.aspx.cs" Inherits="ngManager_IndexNg" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <script type="text/javascript" src="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/Js/jquery191.min.js"></script>
    <script src="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/bootstrap/js/bootstrap.min.js"></script>
    <link href="<%= ResolveClientUrl("~/")%>Pub/EasyLayout/Css/NgMenu.css" rel="stylesheet" />
    <script>
        jQuery(document).on('click', '.mega-dropdown', function (e) {
            e.stopPropagation()
        });
    </script>
 
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <nav class="navbar navbar-default">
                <div class="navbar-header">
                    <button class="navbar-toggle" type="button" data-toggle="collapse" data-target=".js-navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">WebBase</a>
                </div>

                <div class="collapse navbar-collapse js-navbar-collapse">
                    <ul class="nav navbar-nav">
                        <li class="dropdown mega-dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Start<span class="glyphicon glyphicon-chevron-down pull-right"></span></a>
                            <ul class="dropdown-menu mega-dropdown-menu row">                               
                                <li class="col-sm-3">
                                    <ul>
                                        <li class="dropdown-header">Khu quản lý</li>
                                        <li><a href="#">Quản lý menu</a></li>
                                        <li><a href="#">Quyền hạn người dùng</a></li>                                       
                                    </ul>
                                </li>           
                            </ul>
                        </li>                       
                    </ul>
                </div>              
            </nav>
        </div>       
    </form>
</body>
</html>
