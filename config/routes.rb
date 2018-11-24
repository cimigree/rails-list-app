Rails.application.routes.draw do
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
    member do 
      put :update_purchased
    end
  end
  root to: "items#index"
end
