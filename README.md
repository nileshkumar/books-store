### Books Store app
* Ruby on Rails
* PostgreSQL
* GrpahQL
* RSpec

## Steps to Run application
* git clone git@github.com:nileshkumar/books-store.git
* bundle install
* rails db:create
* rails db:migrate
* rails server
* rails app: run http://localhost:3000/
* graphQL api: run http://localhost:3000/graphql


## GraphQL query
```
query{
  books{
    title
    author
    user{
      email
    }
  }
}

query{
  book(id:1){
    title
    author
  }
}

query{
  search(searchTerm: "test"){
    author
    title
  }
}

```
## GraphQL Mutations

```
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

mutation{
  updateBook(input:{id: 2, title: "test"}) {
    id
    title
  }
}

mutation{
  destroyBook(input:{id: 2}){
    id
  }
}

```

