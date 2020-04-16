Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :admins
  devise_for :members, :controllers => {
    :registrations => "members/registrations",
    :sessions => "members/sessions",
  }

  # ゲストユーザーログイン用のルート
  devise_scope :member do
    post 'members/guest_sign_in', to: 'members/sessions#guest_create'
  end

  namespace :admins do
    resources :articles, only: [:index, :show, :update, :destroy]
    resources :tweets, only: [:index, :show, :update, :destroy] do
      resources :tweet_comments, only: [:update, :destroy]
    end
    resources :members, only: [:index, :show, :update, :destroy] do
      get "following" => "members#follower", as: "following" #フォロー一覧
      get "followers" => "members#followed", as: "followers" #フォロワー一覧
      get "blocking" => "members#blocker", as: "blocking" #ブロックしているリスト一覧
      get "blockers" => "members#blocked", as: "blockers" #ブロックされているリスト一覧
    end
    resources :rooms, only: [:index, :update, :destroy] do
      resources :messages, only: [:update, :destroy]
    end
    resources :notices, only: [:index, :show, :update, :destroy]
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
    resources :parts, only: [:index, :create, :edit, :update, :destroy]
  end

  scope module: :members do
    resources :articles do
      resource :article_favorites, only: [:create, :destroy]
    end
    resources :tweets, only: [:index, :create, :show, :destroy] do
      resources :tweet_comments, only: [:create, :destroy] do
        resource :tweet_comment_favorites, only: [:create, :destroy]
      end
      resource :tweet_favorites, only: [:create, :destroy]
    end
    resources :members, only: [:index, :show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      resource :accesses, only: [:create]
      resource :blocks, only: [:create, :destroy]
      get "article_favorites" => "members#article_favorites", as: "article_favorites"
      get "cancel" => "members#cancel", as: "cancel" #退会確認画面表示
      patch "cancel" => "members#withdraw", as: "withdraw" #会員ステータス更新（退会する）
      get "following" => "relationships#follower", as: "following" #フォロー一覧
      get "followers" => "relationships#followed", as: "followers" #フォロワー一覧
      get "blocking" => "blocks#blocker", as: "blocking" #ブロックリスト一覧
      get "accesses" => "accesses#index", as: "accesses_index" #アクセス履歴一覧
    end
    resources :rooms, only: [:index, :show, :create]
    resource :notices, only: [:new, :create]
    resources :announces, only: :index

    # 訪れたメッセージルームの相手のメッセージルーム全てに既読をつける為（非同期通信）
    get "all_message_read" => "rooms#all_message_read", as: "all_message_read"

    get "top" => "articles#top", as: "top"

    constraints ->  request { request.session.try(:[], 'warden.user.member.key').try(:[], 0).try(:[], 0).present? } do
      # ログイン中のルートパス
      root to: "articles#index"
    end
    # 未ログイン時のルートパス
    root to: 'articles#top'
  end

  #市区町村のソートの為
  get "cities_select" => "searches#cities_select"
  get "cities_select_regist" => "searches#cities_select_regist"

end
