# frozen_string_literal: true

module Mutations
  class DestroyBook < BaseMutation
    description "deletes a book"
    argument :id, Integer, required: true

    type Types::BookType

    def resolve(id:)
      begin
        book = Book.find(id).destroy
      rescue GraphQL::ExecutionError => e
        e.record.errors.full_messages.join(', ')
      end
    end
  end
end
