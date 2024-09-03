Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "request", controller: "nfl_examples", action: "intermediate_example"

  get "fantasy", controller: "nfl_examples", action: "fantasy_projections"
  
  get "get_by_id", controller: "nfl_examples", action: "get_player_by_id"
  get "get_by_name", controller: "nfl_examples", action: "get_player_by_name"

  get "add", controller: "nfl_examples", action: "add_player"

  get "upload", controller: "nfl_examples", action: "upload_fantasy_projections"
  get "display", controller: "nfl_examples", action: "display_fantasy_projections"

  get "remove_dups", controller: "nfl_examples", action: "remove_duplicates"

  get "display", controller: "nfl_examples", action: "display_players"
  
  # Defines the root path route ("/")
  # root "posts#index"

end
