require 'rails_helper'

module Mutations
  module Books
    RSpec.describe CreateBook, type: :request do
      describe '.resolve' do
        it 'creates a book' do
          expect do
            post '/graphql', params: { query: query }
          end.to change { Book.count }.by(1)
        end

        it 'returns a book' do
          post '/graphql', params: { query: query }
          json = JSON.parse(response.body)
          data = json['data']['createBook']['book']

          expect(data).to eq(
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
