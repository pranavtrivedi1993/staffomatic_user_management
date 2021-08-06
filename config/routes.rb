Rails.application.routes.draw do
  resource :signup, only: %i[create]
  resources :authentications, only: %i[create]
  resources :users, only: %i[index] do
    member do
      post "archive"
      post "unarchive"
    end
  end
end
