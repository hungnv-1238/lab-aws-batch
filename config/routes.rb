Rails.application.routes.draw do
  root to: "nasa_images#show"
  get "/image", to: "nasa_images#show"
  get "/gallery", to: "nasa_images#index"
  get "/ping", to: "nasa_images#ping"
end
