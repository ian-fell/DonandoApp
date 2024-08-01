Rails.application.routes.draw do
  root to: "movies#index"

  get "movies", to: "movies#show_all_movies"
  get "directors", to: "movies#show_all_directors"
  get "longest", to: "movies#show_longest"
  get "first_last", to: "movies#show_first_last"
  get "median", to: "movies#show_median"
  get "most_wows", to: "movies#show_most_wows"
end
