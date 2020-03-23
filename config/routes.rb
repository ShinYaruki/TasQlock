Rails.application.routes.draw do
  # トップページ
  root to: 'homes#index'
  # トップページ用のルーティング
  resources :homes , only: [:index] 
  # スケジュールページ用のルーティング
  resources :tasks , only: [:new, :create, :edit, :update, :destroy] do
    collection do
      get 'today'
      get 'calendar'
    end
  end
  post 'tasks/:id/done', to: 'tasks#done', as: 'done'
  post 'tasks/:id/calendardone', to: 'tasks#calendardone', as: 'calendardone'
  
  resources :memos, only: [:new, :create, :destroy]
  post "/memos/create", to: "memos#create"

  #ユーザ新規登録用のルーティング
  resources :users, only: [:new, :create]
  #ログイン処理用のルーティング
  post   '/login' , to: 'sessions#create'
  #ログアウト処理用のルーティング
  delete '/logout', to: 'sessions#destroy'

end