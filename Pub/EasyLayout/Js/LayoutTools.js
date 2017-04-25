/*http://javascriptcompressor.com/*/

/***Menu****/

  <script type="text/javascript">


        var Url = '<%= ResolveClientUrl("~/")%>';

        ddaccordion.init({
            autoHeight: true,
            headerclass: "submenuheader", //Shared CSS class name of headers group
            contentclass: "submenu", //Shared CSS class name of contents group
            revealtype: "click", //Reveal content when user clicks or onmouseover the header? Valid value: "click", "clickgo", or "mouseover"
            mouseoverdelay: 0, //if revealtype="mouseover", set delay in milliseconds before header expands onMouseover
            collapseprev: false, //Collapse previous content (so only one open at any time)? true/false 
            defaultexpanded: [0], //index of content(s) open by default [index1, index2, etc] [] denotes no content
            onemustopen: false, //Specify whether at least one header should be open always (so never all headers closed)
            animatedefault: false, //Should contents open by default be animated into view?
            persiststate: true, //persist state of opened contents within browser session?
            toggleclass: ["", ""], //Two CSS classes to be applied to the header when it's collapsed and expanded, respectively ["class1", "class2"]
            togglehtml: ["suffix", "<img src='" + Url + "Pub/EasyLayout/Menu/images/plus.gif' class='statusicon' />", "<img src='" + Url + "Pub/EasyLayout/Menu/images/minus.gif' class='statusicon' />"], //Additional HTML added to the header when it's collapsed and expanded, respectively  ["position", "html1", "html2"] (see docs)
            animatespeed: "fast", //speed of animation: integer in milliseconds (ie: 200), or keywords "fast", "normal", or "slow"
            oninit: function (headers, expandedindices) { //custom code to run when headers have initalized
                //do nothing
            },
            onopenclose: function (header, index, state, isuseractivated) { //custom code to run whenever a header is opened or closed
                //do nothing
            }
        })
	        
    </script>

/***Layout****/

<script type="text/javascript">
        $(function () {
            if(detectIE().toString().toLowerCase()=="false") 
            {   
                alert("系統僅支援IE瀏覽器 !!!(Hệ thống chỉ hỗ trợ trên trình duyệt IE");
                 window.location.href="Default.aspx";
                 return;
            }
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
            var isLoaded=false;
            /*HomeTab*/
            $(window).load(function () {
                addTab("Home", "Pub/Module/LoginBody.aspx?ApID=<%= Request.QueryString["ApID"] %>", false);              
            });

            /*ClickTab*/
            $(".menu_Link").click(function () {
                if (isFrameBusy) {
                    alert("正在載入另一個頁面﹐請稍候...");
                    return;
                }
                var mnuName = $(this).attr("mnuName");
                var mnuLink = $(this).attr("mnuLink");
                addTab(mnuName, mnuLink, true);
            });
            var tab_index = 1;
            function addTab(tab_name, tab_url, tab_close) {
           
           
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

             var _timer ;         
        
          
            $('#TabLayout').tabs({
                //border:false,
                onSelect: function (title,index) 
                {     
                    try
                    {                        
                        clearInterval(_timer);
                        clearTimeout(_timer);
                        _timer.abort();
                    }catch(e){}                  
               
                    
                    $curFrame = getCurFrame();
                    tab_id=$curFrame.attr("id");
                    try{
                    obj = $(frames[tab_id].window)[0];
                    }catch(e){}
                   
                    CallBeforeUnload(obj,tab_id);                   
                   
                    $divLoadFrame = $curFrame.prev();
                    //Khống chế lúc đang loading tab 1, thì chọn tab 2 , trở lại tab 1 vẫn còn loading        
                    try{
                        iframe = $curFrame[0];
                        iframe = iframe.contentWindow || iframe.contentDocument;
                        if (iframe.document) iframe = iframe.document;
                    }
                    catch(e){                       
                        iframe= $(frames[$curFrame.attr("id")].document)[0]  ;                        
                    }
                    //                    
                  
                    _timer=setInterval(function () { //lặp tới khi trang load hoàn tất       
                                     
                            try{
                                if (iframe.readyState == 'complete') 
                                { 
                                    if ($divLoadFrame.is(":visible")) 
                                    {      
                                        isFrameBusy=false;                  
                                            $divLoadFrame.hide(); // Download is complete 
                                        clearInterval(_timer);
                                         clearTimeout(_timer); 
                                    } 
                                    clearInterval(_timer);
                                    clearTimeout(_timer); 
                                }
                            }catch(e){
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
                try{
                obj = $(frames[tab_id].window)[0];
                }
                catch(e){}


                /*** Hide loading ***/
                $curFrame = getCurFrame();
                $divLoadFrame = $curFrame.prev();
                //alert($divLoadFrame.attr("id"));
                       
                $divLoadFrame.hide();
                
              CallBeforeUnload(obj,tab_id)
  
            }

            
           


            function CallBeforeUnload(obj,tab_id)
            {            
                    try {
                    obj.attachEvent('onbeforeunload', function () { _fnframeUnLoad(tab_id) });
                } catch (e) { }
                obj.onbeforeunload = function () {
                    _fnframeUnLoad(tab_id);
                }

                
            }          
            
             

            
            function _fnframeUnLoad(tab_id) 
            {  
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
            chk = confirm("確認登出現有使用者？");
            if (chk == true) {
                window.location.href='Default.aspx?Type=Logout';
                
            }
        }
        
    </script>