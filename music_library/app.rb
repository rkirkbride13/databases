# file: app.rb

require_relative './lib/album_repository'
require_relative './lib/artist_repository'
require_relative './lib/database_connection'

class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @album_repository = album_repository
    @artist_repository = artist_repository
  end

  def run
    # "Runs" the terminal application
    # so it can ask the user to enter some input
    # and then decide to run the appropriate action
    # or behaviour.

    # Use `@io.puts` or `@io.gets` to
    # write output and ask for user input.
    @io.puts "Welcome to the music library manager!"
    @io.puts "What would you like to do?"
    @io.puts "  1 - List all albums"
    @io.puts "  2 - List all artists"
    @io.print "Enter your choice: "
    input = @io.gets.chomp.to_i
    if input == 1
      @io.puts "Here is the list of albums:"
      repo = AlbumRepository.new
      albums = repo.all
      sorted_array = albums.map {|album| [album.id.to_i, album.title]}.sort
      sorted_array.each {|album| puts "* #{album[0]} - #{album[1]}"}
    else
      @io.puts "Here is the list of artists:"
      repo = ArtistRepository.new
      artists = repo.all
      artists.each {|artist| puts "* #{artist.id} - #{artist.name}"}
    end
  end
end

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'music_library',
    Kernel,
    AlbumRepository.new,
    ArtistRepository.new
  )
  app.run
end