# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :todo_lists, only: %i[index create], path: :todolists do
      resources :todo_items, only: %i[create destroy], path: :todo_items do
        member do
          put 'complete'
        end
      end
    end
  end

  resources :todo_lists, only: %i[index new], path: :todolists
  resources :todo_items, path: :todoitems do
    member do
      put 'complete'
    end
  end
end
