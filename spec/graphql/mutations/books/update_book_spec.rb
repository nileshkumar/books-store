require 'rails_helper'

module Mutations
  module Books
    RSpec.describe UpdateBook, type: :request do
      describe 'resolve' do
        it 'updates a book' do
          book   = create(:book)

          BooksStoreSchema.execute(
            query(id: book.id),
            context: { current_user: book.user },
            variables: {}
          )

          expect(book.reload).to have_attributes(
            'id'    => book.id,
            'title' => 'New Book',
          )
        end

        it 'returns a book' do
          book   = create(:book, title: 'Hero')
          data = BooksStoreSchema.execute(
            query(id: book.id),
            context: { current_user: book.user },
            variables: {}
          )

          result = data.dig("data", "updateBook")

          expect(result).to include(
            'id'              => book.id.to_s,
            'title'           => 'New Book',
          )
        end
      end

      def query(id:)
        <<~GQL
          mutation {
            updateBook(input: {
              id: #{id}
              title: "New Book"
            })
            {
              id
              title
            }
          }
        GQL
      end
    end
  end
end
