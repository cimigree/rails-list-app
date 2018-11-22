Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :categories do
    resources :items
  end
  resources :stores do
    member do
      get :all_items
    end
  end
  resources :items do
    collection do
      get :items_all
    end
  end
end
