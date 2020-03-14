Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :admins
  devise_for :members, :controllers => {
    :registrations => "members/registrations",
  }

  namespace :admins do
    resources :articles, only: [:index, :show, :update, :destroy]
    resources :tweets, only: [:index, :show, :update, :destroy] do
      resources :tweet_comments, only: [:update, :destroy]
    end
    resources :members, only: [:index, :show, :edit, :update, :destroy]
    resources :rooms, only: [:index, :show, :update, :destroy] do
      resources :messages, only: [:update, :destroy]
    end
    resources :notices, only: [:index, :show, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :parts, only: [:index, :create, :edit, :update]
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
      resource :blocks, only: [:index, :create, :destroy]
      get "article_favorites" => "members#article_favorites", as: "article_favorites"
      get "cancel" => "members#cancel", as: "cancel"
      patch "cancel" => "members#withdraw", as: "withdraw"
      get "following" => "relationships#follower", as: "following"
      get "followers" => "relationships#followed", as: "followers"
      get "accesses" => "accesses#index", as: "accesses_index"
    end
    resources :rooms, only: [:index, :show, :create]
    resource :notices, only: [:new, :create]
    get "top" => "articles#top", as: "top"
    root 'articles#top'
  end
end
