// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require turbolinks

var ready = function() {
  $("#navbar").addClass("collapse navbar-collapse");
  $("#navbar > ul").addClass("nav navbar-nav");
  $("#navbar ul ul")
    .each(function(){
      $parentLink = $(this).prev();
      $(this).prepend($("<li><a href='" + $parentLink.attr("href") + "'>" + $parentLink.text() + "</a></li>"));
    })
    .addClass("dropdown-menu")
    .prev().addClass("dropdown-toggle").attr("data-toggle", "dropdown").append(' <b class="caret"></b>')
    .parent().addClass("dropdown");
  $("#navbar a").each(function(i) {
    if (this.href.replace(/^.*\/\/[^\/]+/, "") === window.location.pathname) {
      $(this).parent().addClass("active");
      return false;
    }
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);
