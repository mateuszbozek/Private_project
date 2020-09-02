Rails.application.routes.draw do
  devise_for :users, skip: :saml_authenticatable, controllers: {
      devise: "user/sign_up",
      devise: "user/sessions",
      devise: "user/passwords"
  }

  devise_scope :user do
    scope "users", controller: 'devise/saml_sessions' do
      get :new, path: "saml/sign_in", as: :new_user_sso_session
      post :create, path: "saml/auth", as: :user_sso_session
      get :destroy, path: "sign_out", as: :destroy_user_sso_session
      get :metadata, path: "saml/metadata", as: :metadata_user_sso_session
      match :idp_sign_out, path: "saml/idp_sign_out", via: [:get, :post]
    end
  end

  root to: "main#index"

  resources :main, only: [:index]

end
