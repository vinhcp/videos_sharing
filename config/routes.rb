Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'auth/sessions' }
  root to: 'videos#index'
end
