require 'rails_helper'

module Mutations
  module Books
    RSpec.describe UpdateBook, type: :request do
      describe 'resolve' do
        it 'updates a book' do
          book   = create(:book)
          post '/graphql', params: { query: query(id: book.id) }

          expect(book.reload).to have_attributes(
            'id'    => book.id,
            'title' => 'New Book',
          )
        end

        it 'returns a book' do
          book   = create(:book, title: 'Hero')
          post '/graphql', params: { query: query(id: book.id) }

          json = JSON.parse(response.body)
          data = json['data']['updateBook']

          expect(data).to include(
            'id'              => book.id.to_s,
            'title'           => 'New Book',
          )
        end
      end

      def query(id:)
        <<~GQL
          mutation {
            updateBook(
              id: #{id}
              title: "New Book"
            )
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
