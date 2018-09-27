Rails.application.routes.draw do
  apipie

  root to: 'zombies#index'

  resources :armors
  resources :weapons

  resources :zombies do
    resources :armors
    resources :weapons
    member do
      post 'add_armors', to: 'zombies#add_armors', as: 'add_armors'
      post 'add_weapons', to: 'zombies#add_weapons', as: 'add_weapons'
      post 'eat_brain', to: 'zombies#eat_brain', as: 'eat_brain'
    end
  end

  post '/graphql', to: 'graphql#execute'
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql'
    mount Sidekiq::Web, at: '/sidekiq'
  end
end
