require 'rails_helper'

module Mutations
  module Books
    RSpec.describe CreateBook, type: :request do
      describe '.resolve' do
        let(:user) { create(:user) }
        it 'creates a book' do
          expect do
            BooksStoreSchema.execute(
            query,
            context: { current_user: user },
            variables: {}
          )
          end.to change { Book.count }.by(1)
        end

        it 'returns a book' do
          data = BooksStoreSchema.execute(
            query,
            context: { current_user: user },
            variables: {}
          )
          result = data.dig("data", "createBook", "book")

          expect(result).to eq(
            'author' => "Mark Spencer",
            'title'  => 'Jurrasic Park',
          )
        end
      end

      def query
        <<~GQL
          mutation {
            createBook(input: {
              title: "Jurrasic Park",
              publicationDate: "2020-02-01",
              author: "Mark Spencer"
            }) {
              book{
                title
                author
              }
            }
          }
        GQL
      end
    end
  end
end
