Rails.application.routes.draw do
  root to: 'visitors#index'

  post '/import', to: 'application#import'
  get '/configure', to: 'visitors#configure'
  get '/dashboard', to: 'visitors#dashboard'
  get '/details', to: 'visitors#details'
  get '/demo', to: 'visitors#demo'
  get '/convert', to: 'application#convert'
  post '/form_post', to: 'application#form_post'
end
