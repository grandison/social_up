// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require jquery.ui.autocomplete
//= require soundmanager/soundmanager2-jsmin.js

$(function(){
  $(".invite_friends").click(function(){
    VK.External.showInviteBox();
  });
  $(".tell_to_friends").click(function(){
    VK.api("wall.post", { message: "Выбери мне мелодию для будильника!", attachments: 'photo1921860_312503837,http://vk.com/app3915849' });
  });
});

soundManager.url = '/soundmanager2.swf';
soundManager.debugMode = false;
soundManager.consoleOnly = false;
