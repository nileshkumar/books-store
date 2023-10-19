Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphql", graphql_path: "/graphql#execute"
  end
  post "/graphql", to: "graphql#execute"
  devise_for :users
  root 'home#index'

end
