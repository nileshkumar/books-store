class Mutations::CreateBook < Mutations::BaseMutation
  def ready?(**_args)
    check_current_user
  end

  description "creates a book"
  argument :title, String, required: true
  argument :author, String, required: true
  argument :publication_date, GraphQL::Types::ISO8601Date, required: true

  field :book, Types::BookType, null: false

  def resolve(title:, author:, publication_date:)
    begin
      book = Book.create!(
      title: title,
      author: author,
      publication_date: publication_date,
      user: context[:current_user])
      { book: book }
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
      " #{e.record.errors.full_messages.join(', ')}")
    end
  end
end


=begin
mutation{
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
=end
