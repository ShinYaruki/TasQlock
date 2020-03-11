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
//= require jquery
//= require jquery_ujs
//= require moment
//= require fullcalendar
//= require fullcalendar/lang/ja
//= require_tree .

$(function(){
  setTimeout("$('.time-limit').fadeOut('slow')", 1000) 
})

$(function(){
  function eventCalendar() {
    $('#calendar').fullCalendar({
      lang: 'ja',
      contentHeight: 'auto', // 自動
      dayClick: function (date) {
        // クリックした日付をformで受け取り、calendarアクションに送信
        function postForm(value) {

          let form = document.createElement('form');
          let input = document.createElement('input');
        
          form.method = 'GET';
          // 現在開発環境である為localhostに飛ばしている
          form.action = '/tasks/calendar/';
          input.type = 'hidden'; //フォームは必要ないので非表示
          input.name = 'text';
          input.value = value;
        
          form.appendChild(input);
          document.body.appendChild(form);
        
          form.submit();
        }
        postForm(date.format())
      }
    })
  };

  // カレンダーを非表示させる関数を記述(今の所使用予定なし)　
  // function clearCalendar() {
  //   $('#calendar').html('');
  // };

  // ログインし、スケジュールページに飛んだらカレンダーを表示
  if (window.location.href.match(/tasks/)){
    eventCalendar();
  }

  // カレンダーをクリックした特定の日付に背景色のcssを付与する関数
  function calendarColor() {
    // _calendar_bar.html.hamlより、架空のinputから日付情報の値を取得
    caledate = $('.cale_date').val();
    $(`.fc-day[data-date=${caledate}]`).css('background','rgb(255, 172, 230)')
  };

  function calendarImage(){
    // カレンダーの中でイベントが登録されている日にイメージを追加する。
    if(window.location.href.match(/\/tasks/)){

    }
  }
  
  // カレンダーをクリックした時に背景色のcssを付与する関数を実行
  if(window.location.href.match(/\/tasks\/calendar/)){
    // 選択した日が当月であった場合そのまま色付けを発火
    calendarColor();
    // 選択した日が当月でなかった場合、カレンダーの<>ボタンをクリックした時にも発火
    $(".fc-button").click(calendarColor);
  };
});