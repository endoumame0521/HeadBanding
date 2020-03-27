// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .

// 検索フォームでの都道府県選択に連動する市区町村
$(document).on('turbolinks:load', function() {
  $(document).on('change', '.prefecture_id_select', function(){
      $.ajax({
        type: 'GET',
        url: '/cities_select',
        data: {
        prefecture_id: $(this).val()
        }
      }).done(function(data){
        $('#ajax_cities_check_boxes').html(data);
      }).fail(function(){
        alert("通信失敗");
      })
    });
});

// 会員新規登録フォームでの都道府県選択に連動する市区町村
$(document).on('turbolinks:load', function() {
  $(document).on('change', '#member_address_prefecture', function(){
      $.ajax({
        type: 'GET',
        url: '/cities_select_regist',
        data: {
        prefecture_name: $(this).val()
        }
      }).done(function(data){
        $('#ajax_cities_radio_buttons').html(data);
      }).fail(function(){
        alert("通信失敗");
      })
    });
});


// 検索フォームの収納・引き出し
$(document).on('turbolinks:load', function() {
  $('.search_button').on('click', function(){
    $('.search_form').slideToggle();
  });
});

// 通知が表示されてから2000msで非表示にする
$(document).on('turbolinks:load', function() {
  setTimeout("$('#notice').fadeOut('slow')", 2000);
});