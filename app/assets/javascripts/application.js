// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require ckeditor/init

//= require turbolinks
//= require ace-rails-ap
//= require bootstrap


//= require messages
//= require select2

//= require moment
//= require bootstrap-datetimepicker
//= require_tree .


// $( "#dropdown" ).select2({
//     theme: "bootstrap"
// });

 
// $(function () {
//     $('#datetimepicker1').datetimepicker({format: 'YYYY-MM-DD HH:mm'});
//     $('#datetimepicker2').datetimepicker({format: 'YYYY-MM-DD HH:mm'});
// });


// $(function() {

//     $('#side-menu').metisMenu();

// });

// $(function() {
//     $(window).bind("load resize", function() {
//         topOffset = 50;
//         width = (this.window.innerWidth > 0) ? this.window.innerWidth : this.screen.width;
//         if (width < 768) {
//             $('div.navbar-collapse').addClass('collapse');
//             topOffset = 100; // 2-row-menu
//         } else {
//             $('div.navbar-collapse').removeClass('collapse');
//         }

//         height = ((this.window.innerHeight > 0) ? this.window.innerHeight : this.screen.height) - 1;
//         height = height - topOffset;
//         if (height < 1) height = 1;
//         if (height > topOffset) {
//             $("#page-wrapper").css("min-height", (height) + "px");
//         }
//     });

//     var url = window.location;
//     var element = $('ul.nav a').filter(function() {
//         return this.href == url || url.href.indexOf(this.href) == 0;
//     }).addClass('active').parent().parent().addClass('in').parent();
//     if (element.is('li')) {
//         element.addClass('active');
//     }
// });