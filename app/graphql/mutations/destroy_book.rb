# frozen_string_literal: true

module Mutations
  class DestroyBook < BaseMutation
    def ready?(**_args)
      check_current_user
    end

    description "deletes a book"
    argument :id, Integer, required: true

    type Types::BookType

    def resolve(id:)
      book = Book.find(id)
      if book.user != context[:current_user]
        raise GraphQL::ExecutionError, "You are not authorized!"
      end
      begin
        book.destroy!
      rescue GraphQL::ExecutionError => e
        e.record.errors.full_messages.join(', ')
      end
    end
  end
end

=begin
mutation{
  destroyBook(input:{id: 2}){
    id
  }
}
=end
