require 'book_repository'

RSpec.describe BookRepository do
  def reset_book_table
    seed_sql = File.read('spec/seeds_books.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store_test' })
    connection.exec(seed_sql)
  end

  describe BookRepository do
    before(:each) do 
      reset_book_table
    end

    it 'returns list of all books' do
    # (your tests will go here).

      repo = BookRepository.new
      books = repo.all
      expect(books.length).to eq 2
      expect(books[0].id).to eq '1'
      expect(books[0].title).to eq 'Nineteen Eighty-Four'
      expect(books[0].author_name).to eq 'George Orwell'
      expect(books[1].id).to eq '2'
      expect(books[1].title).to eq 'Mrs Dalloway'
      expect(books[1].author_name).to eq 'Virginia Woolf'
    end

    it 'filters id 1 from the book store table' do
      repo = BookRepository.new
      book = repo.find(1)
      expect(book.title).to eq 'Nineteen Eighty-Four'
      expect(book.author_name).to eq 'George Orwell'
    end

    it 'filters id 2 from the book store table' do
      repo = BookRepository.new
      book = repo.find(2)
      expect(book.title).to eq 'Mrs Dalloway'
      expect(book.author_name).to eq 'Virginia Woolf'
    end
  end
end