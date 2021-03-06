// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import "bootstrap/dist/js/bootstrap";
require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");
import "bootstrap";
import $ from "jquery";
global.$ = jQuery;
// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
//= require jquery
//= require jquery_ujs
//= require popper
//= require bootstrap
//= require bootstrap-sprockets
//= require_tree .

$(function () {
  $("#userNotification").click(() => {
    $.ajax({
      url: "order_friends/notifications_seen",
      type: "POST",
      data: { name: "hi" },
      success: function (data) {
        console.log(data);
        $("#NumbersOfNotification").text("0");
      },
    });
  });
});
