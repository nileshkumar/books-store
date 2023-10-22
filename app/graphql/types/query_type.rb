# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    field :current_user, UserType, null: true do
      description "The signed in user"
    end

    field :books, [BookType], null: true
    field :book, BookType, null: false do
      argument :id, ID, required: true
    end

    def books
      Book.preload(:user).where(user_id: current_user)
    end

    def book(id:)
      Book.preload(:user).where(id: id, user_id: current_user).first
    end

    def current_user
      context[:current_user]
    end
  end
end
