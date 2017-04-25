<%@ Page Title="" Language="C#" MasterPageFile="~/ManagerAg.master" AutoEventWireup="true" CodeFile="Default2.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="test"></div>
      <div class="test1"></div>
    <div class="test2"></div>

    <script>
        $(document).ready(function () {
            for (var i = 0; i < 5; i++) {                
                var $btn = $("<button/>");
                $btn.text(i);
                /*$btn.click(function() {  
                            alert(i);                  
                });*/

                $btn.click(call(i));

               
                $(".test").append($btn);   
            }

            function call(id) {
                return function () {
                    alert(id);  // variable found in the closure with the expected value
                };
            }
            
        });

        for (var i = 0; i < 5; i++) {
            var $btn = $("<button/>");
            $btn.text(i);
          

            $btn.click((function () {
                var index = i;
                return function () {
                    alert(index)
                }
            })());


            $(".test").append($btn);
        }
      

    </script>
    
  
</asp:Content>

