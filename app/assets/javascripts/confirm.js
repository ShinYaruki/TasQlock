$(function(){
  $('.confirm').click(function(){
    if(!confirm('本当に削除しますか？')){
      /* キャンセルの時の処理 */
      return false;
    }
  });
});