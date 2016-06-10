Rails.application.routes.draw do


  devise_for :users

  resources :posts do
    member do
      get 'like',   to: 'posts#like',   as: 'like'
      get 'unlike', to: 'posts#unlike', as: 'unlike'
    end
    resources :comments,module: :posts
  end

  resources :blogs do
    resources :articles do
      member do
        get 'upvote', to: 'articles#upvote', as: 'upvote'
        get 'downvote', to: 'articles#downvote', as: 'downvote'
      end
      
    end
    member do
      get 'subscribe',   to: 'blogs#subscribe',   as: 'subscribe'
      get 'unsubscribe', to: 'blogs#unsubscribe', as: 'unsubscribe'
    end
  end

  resources :articles do
    resources :comments,module: :articles
  end

  get 'checkNotification',to: 'notifications#checkCounter',as: 'notification'         #Check notification with AJAX
  get 'i/notifications',to: 'notifications#notifications',as: 'all_notifications'     #Get User's notifications
  delete 'i/notifications/:id/destroy',to: 'notifications#destroy',as: 'delete_notification'      #Delete users notification  000

  get 'users/:username/followers',to: 'pages#followers',as: 'followers'               #Get Users's Followers
  get 'users/:username/followings',to: 'pages#followings',as: 'followings'            #Get Users's Followees

  get 'gettingStarted/1',to: 'informations#bio',as: 'add_bio'
  get 'gettingStarted/2',to: 'informations#interests',as: 'add_interests'
  get 'gettingStarted/3',to: 'informations#avatar',as: 'add_bio_s'
  patch 'gettingStarted/1',to: 'informations#updateBio',as: 'save_bio'

  match 'i/explore',to: 'pages#explore', as: 'explore',via: [:get,:post]
  post 'i/search',to: 'pages#lala',as: 'do_search'
  get 'i/fetch',to: 'pages#fetch', as: 'fetch'
  patch 'i/updateAvatar',to: 'pages#updateAvatar', as: 'update_avatar'
  patch 'i/blogs/:id/updateAvatar',to: 'blogs#updateAvatar', as: 'update_blog_avatar'
  
  get 'dashboard',to: 'pages#dashboard',as: 'dashboard'
  get ':link',to: 'blogs#show', as: 'page'
  get ':link/subscribers',to: 'blogs#getSubscribers', as: 'get_subscribers'
  
  get ':id/follow',to: 'blogs#follow',as: 'follow_user'
  get ':id/unfollow',to: 'blogs#unfollow',as: 'unfollow_user'
  

  get 'users/:username',    to: 'pages#sketchbook', as: 'sketchbook'
  # get 'userCard/:username', to: 'pages#userCard',   as: 'userCard'
  

  post 'blogs/check_availability',to: 'pages#checkData',as: 'checkData'
  post 'users/check_availability',to: 'pages#checkUsername',as: 'checkUsername'
  
  root 'pages#index'

end
