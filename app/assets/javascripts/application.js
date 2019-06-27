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
//= require jquery3
//= require cocoon
//= require popper
//= require bootstrap-sprockets
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree

// ========================最終合計金額を出す関数==================================
const finalamount = () => {
  final_amount = 0;
  $(".total_price_div").each(function (index, total_price) {
    final_amount = final_amount + parseInt($(total_price).text());
  });
  $('#final_amount').text(final_amount);
};
// ============================================================================


// =====================Loading イメージ表示関数==================================
// 引数： msg 画面に表示する文言
const dispLoading = (msg) => {
  // 引数なし（メッセージなし）を許容
  if( msg == undefined ){
    msg = "";
  }
  // 画面表示メッセージ
  var dispMsg = "<div class='loadingMsg'>" + msg + "</div>";
  // ローディング画像が表示されていない場合のみ出力
  if($("#loading").length == 0){
    $("body").append("<div id='loading'>" + dispMsg + "</div>");
  }
};

// ============================================================================

 // ==========================Loading イメージ削除関数============================
 const removeLoading = () => {
  $("#loading").remove();
};
// ============================================================================
