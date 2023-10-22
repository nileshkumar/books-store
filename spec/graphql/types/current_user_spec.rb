require 'rails_helper'

RSpec.describe "Query.currentUser" do
  subject(:query_result) { BooksStoreSchema.execute(query, context: context).as_json }

  let(:user) { create(:user) }
  let(:context) { { current_user: user } }
  let(:query) { <<~GRAPHQL }
      query {
        currentUser {
          id
          email
        }
      }
    GRAPHQL
  let(:expected_result) do
    { "data" => { "currentUser" => { "id" => user.id.to_s, "email" => user.email } } }.as_json
  end

  it "returns the current user" do
    expect(query_result).to eq(expected_result)
  end
end
