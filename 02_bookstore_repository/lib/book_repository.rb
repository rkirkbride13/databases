require_relative './book'

class BookRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    sql = 'SELECT id, title, author_name FROM books;'
    result_set = DatabaseConnection.exec_params(sql, [])
    books = []

    result_set.each do |record|
      book = Book.new
      book.id = record['id']
      book.title = record['title']
      book.author_name = record['author_name']
      books << book
    end
    return books
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    
    sql = 'SELECT id, title, author_name FROM books WHERE id = $1;'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)
    record = result[0]
    book = Book.new
    book.id = record['id']
    book.title = record['title']
    book.author_name = record['author_name']
    return book
  end
end