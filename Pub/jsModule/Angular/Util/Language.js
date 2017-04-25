var NgJs = NgJs || {}; //x = a || b; (a, b đều là object) thì x = a nếu a khác null trái lại x = b.

NgJs.Language = (function () {    
    return {
       getLang: function () {
            var cookieLang = NgJs.Tools.getCookie("LANGUAGE");
            if (cookieLang && cookieLang != "") //Load Lang from cookie
            {
                return cookieLang;
            }
            else {
                return "vn";
            }
        }
        , onLoad: function (app, path) { 
            var _r_objLANGUAGE;
            app.factory("Service_Lang", function ($http, $q) {                
                function Service_Lang() {
                    self = this;                    
                    self.getData = function () {                        
                        var deferred_lang = $q.defer();
                        var lang = NgJs.Language.getLang();
                        
                        if (_r_objLANGUAGE) {
                            deferred_lang.resolve(_r_objLANGUAGE);
                        } else {
                            $http.get(path + "Pub/Common/Languages/" + lang + ".js", { cache: true }).success(function (data) {
                                _r_objLANGUAGE = data;
                                
                                deferred_lang.resolve(data);
                            }).error(function (response) {
                                deferred_lang.reject(response);
                            });
                        }                       
                        return deferred_lang.promise;
                    };
                }
                return new Service_Lang();
            });            
                               

            var obj_app = this;
            app.directive('nLang', function (Service_Lang) {
                return {
                    restrict: 'AE'
                    //,scope: "="                    
                    , link: function (scope, iElement, iAttrs, ctrl) {
                        if (!_r_objLANGUAGE) {
                            Service_Lang.getData().then(function (obj_lang) {
                                iElement[0].innerHTML = obj_app._ChangeElemLang(scope, iElement, iAttrs, ctrl, obj_lang)
                            });
                        }
                        else {                            

                            iElement[0].innerHTML = obj_app._ChangeElemLang(scope, iElement, iAttrs, ctrl, _r_objLANGUAGE)
                        }             
                    }
                };                    

            });                        
        }
        , _ChangeElemLang: function(scope, iElement, iAttrs, ctrl,obj_lang)
        {               
            if (obj_lang && iElement && iAttrs) {
                var lang_nm = "";
                if (iAttrs.nLang) 
                {                        
                    if (iAttrs.nLang.startsWith("attr_")) //Attribute n-lang="attr_placeholder" placeholder="Nhập vào email" 
                    {
                        var attr = iAttrs.nLang.replace("attr_", "");                            
                        if(iAttrs.code)                                                       
                            lang_nm = obj_lang[iAttrs.code];
                        else
                            lang_nm = obj_lang[iAttrs[attr]];
                        if (lang_nm && lang_nm != "")//If have node value
                        {
                            iElement[0].setAttribute(attr, lang_nm);
                            return;
                        }                           
                    }                            
                    else
                        lang_nm = obj_lang[iAttrs.nLang] //Attribute <span n-lang="lbl00001">Test</span>
                }                        
                else if (iAttrs.code)//Element <n-lang code='lbl0003'>Test</n-lang>
                {
                    lang_nm = obj_lang[iAttrs.code];
                    if (!lang_nm || lang_nm == "")//truong hop ep convert string html to object angular
                        lang_nm = obj_lang[iAttrs.code.value];
                }                    
                else
                    lang_nm = obj_lang[iElement[0].innerText]; //<n-lang>Test</n-lang>

                if (lang_nm && lang_nm != "")//If have node value
                    return lang_nm;
                    //iElement[0].innerHTML = lang_nm;
                else
                    return iElement[0].innerHTML;
                    
            }
    }
    }

}).call(this);



/*
setLang: function (http, scope, path) {

            var cookieLang = NgJs.Tools.getCookie("LANGUAGE");
            
            if (cookieLang != "") //Load Lang from cookie
            {
                if (!scope.obj_LANGUAGE)
                {
                    return http.get(path + "Pub/Common/Languages/" + cookieLang + ".js").success(function (data) {
                        scope.obj_LANGUAGE = data;
                    });
                }               
            }
            else {
                NgJs.callService({
                    url: "Apps.Manage.Base.Index.GetLanguage",
                    params: null,
                    http: http,
                    scope: scope
                }).then(function (res) {
                    return http.get(path + "Pub/Common/Languages/" + res.data.Result + ".js").success(function (data) {
                        scope.obj_LANGUAGE = data;
                    });
                });
            }

                  
        }
        ,



try {
                            scope.$watch('directiveLangCall', function () {
                                var name = iElement[0].innerHTML;
                                debugger
                                if (!_r_objLANGUAGE) {
                                    Service_Lang.getData().then(function (obj_lang) {
                                        _ChangeElemLang(scope, iElement, iAttrs, ctrl, obj_lang)
                                    });
                                }
                               else{

                                    _ChangeElemLang(scope, iElement, iAttrs, ctrl, scope._r_objLANGUAGE)
                                }
                            });
                        } catch (e) {

                        }
                       

scope.$watch('_r_objLANGUAGE', function () {  
                            if (obj_app._r_objLANGUAGE) {
                                _ChangeElemLang(scope, iElement, iAttrs, ctrl, scope._r_objLANGUAGE)
                            }   
                        });
, controller: function ($scope, $q, $http) {
                       var lang = NgJs.Language.getLang();
                       
                       if (!obj_app._r_objLANGUAGE)
                       {
                           $http.get(path + "Pub/Common/Languages/" + lang + ".js", { cache: true }).success(function (data) {
                               
                               $scope._r_objLANGUAGE = data;
                               obj_app._r_objLANGUAGE = data;
                               
                           }).error(function (response) {
                           });
                       }                       
                    }*/