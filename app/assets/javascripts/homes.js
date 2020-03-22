$(function(){
  // ログインのこちらをクリックするとログインフォームを消し、新規登録画面を呼び出す
  $(".today-sub").click(function(){
    $(".login").fadeOut("normal",function(){
      $(".login").css("display","none")
    });
    setTimeout(function(){
      $(".signup").fadeIn("slow",function(){
      $(".signup").css("display","block")
    })
    },400);
  });
  // 新規登録のこちらをクリックすると新規登録画面を消し、ログインフォームを呼び出す
  $(".already-sub").click(function(){
    $(".signup").fadeOut("normal",function(){
      $(".signup").css("display","none")
      });
      setTimeout(function(){
        $(".login").fadeIn("slow",function(){
        $(".login").css("display","block")
      })
      },400);
    });

  // パスワード入力フォームのスラッシュ目アイコンをクリックするとpassのマスキングを解除
  function eyeslashClick(){
    $(".fa-eye-slash").on("click", function(){
      $(".fa-eye").off("click") // offを設定しないとクリックした回数分だけ重複作動してしまう為
      let input = $(this).parents(".form-group").find("input");
      input.attr("type", "text");
      $(this).removeClass();
      $(this).addClass("fas fa-eye");
      eyeClick(); // 追加したfas fa-eyeにクリックイベントを付与
    });
  }
  // パスワード入力フォームの目アイコンをクリックするとpassをマスキング
  function eyeClick(){
    $(".fa-eye").on("click", function(){
      $(".fa-eye-slash").off("click") // offを設定しないとクリックした回数分だけ重複作動してしまう為
      let input = $(this).parents(".form-group").find("input");
      input.attr("type", "password");
      $(this).removeClass();
      $(this).addClass("fas fa-eye-slash");
      eyeslashClick(); // 追加したfas fa-eye-slashにクリックイベントを付与
    });
  }
  // 目アイコンのクリックイベント呼び出しをデフォルト化
  eyeslashClick();
  eyeClick();

})