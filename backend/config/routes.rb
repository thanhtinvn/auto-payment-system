Rails.application.routes.draw do
  match '/healthcheck', via: [:get], to: 'healthcheck#index'
  match '/admin/change_password', via: [:post], to: 'login#change_password'
  match '/admin/login', via: [:post], to: 'login#login'
  match '/ext/login', via: [:post], to: 'login#login_ext'
  match '/signup', via: [:post], to: 'register#signup'
end
