# frozen_string_literal: true

LocalOnlyPosts::Engine.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :local_only_posts, only: [] do
        collection do
          get :getLocalOnlySetting
        end
      end
    end
  end
end
