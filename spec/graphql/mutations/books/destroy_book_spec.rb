require 'rails_helper'

module Mutations
  module Books
    RSpec.describe DestroyBook, type: :request do
      describe 'resolve' do
        it 'deletes a book' do
          book = create(:book)

          expect do
            BooksStoreSchema.execute(
            query(id: book.id),
            context: { current_user: book.user },
            variables: {}
          )
          end.to change { Book.count }.by(-1)
        end

        it 'returns a book' do
          book = create(:book, title: 'Hero')

          post '/graphql', params: { query: query(id: book.id) }
          json = JSON.parse(response.body)
          data = json['data']['destroyBook']

          expect(data).to include(
            'id' => book.id,
          )
        end
      end

      def query(id:)
        <<~GQL
          mutation {
            destroyBook(
              id: #{id}
            ) {
              id
            }
          }
        GQL
      end
    end
  end
end
