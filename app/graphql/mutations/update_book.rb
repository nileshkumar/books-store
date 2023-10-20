# frozen_string_literal: true

module Mutations
  class UpdateBook < BaseMutation
    description "update a given book"
    argument :id, ID, required: true
    argument :title, String, required: false
    argument :author, String, required: false
    argument :publication_date, GraphQL::Types::ISO8601Date, required: false

    type Types::BookType

    def resolve(id:, **attributes)
      begin
        Book.find(id).tap do |book|
          book.update!(attributes)
        end
      rescue
        e.record.errors.full_messages.join(', ')
      end
    end
  end
end
