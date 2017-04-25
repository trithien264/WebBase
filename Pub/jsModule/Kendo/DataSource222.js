
(function ($) {
    debugger
    $.fn.DataSource = function (options) {
        var defaults = {
            soA: 2,
            soB: 5,
            soC: 9
        };
       
        var options = $.extend(defaults, options);

        return this.each(function () {
            debugger;
            function Cong()
            {
                return options.soA + options.soB;
            }
           
            alert(Cong());
        });
    
}
})(jQuery);