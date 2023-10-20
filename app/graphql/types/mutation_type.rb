# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :destroy_book, mutation: Mutations::DestroyBook
    field :update_book, mutation: Mutations::UpdateBook
    field :create_book, mutation: Mutations::CreateBook
  end
end
