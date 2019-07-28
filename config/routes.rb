Rails.application.routes.draw do
  root to: 'dashboard#index'

  post '/import', to: 'application#import'
  get '/configure', to: 'visitors#configure'
  get '/dashboard', to: 'dashboard#dashboard'
  get '/details', to: 'details#index'
  get '/demo', to: 'visitors#demo'
  get '/convert', to: 'application#convert'
  post '/form_post', to: 'application#form_post'
  get '/get_chart_data', to: 'dashboard#get_chart_data'
end
