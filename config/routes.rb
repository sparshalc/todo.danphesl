Rails.application.routes.draw do
  devise_for :users
  root "projects#index"
  resources :projects do
    # helps to assign projects to users
    # TODO apps routes should
    put 'assign_user', on: :member
    resources :todos, except: [:show, :index] do
      member do
        patch :complete
      end
    end
  end
end