var NgJs = NgJs || {}; //x = a || b; (a, b đều là object) thì x = a nếu a khác null trái lại x = b.

NgJs.Config = (function () {

    this.Grid = {
        paginationPageSize: 25,
        paginationPageSizes: [25, 50, 100]
    }

   
    return {
        grid: this.Grid       
    };

});

NgJs.Config = new NgJs.Config();