require_relative './artist'
require_relative './album'

class ArtistRepository

  def all
    sql = 'SELECT id, name, genre FROM artists;'
    result_set = DatabaseConnection.exec_params(sql, [])

    artists = []

    result_set.each do |record|
      artist = Artist.new
      artist.id = record['id']
      artist.name = record['name']
      artist.genre = record['genre']

      artists << artist
    end
    return artists
  end

  def find(id)
    sql = 'SELECT id, name, genre FROM artists WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]
    artist = Artist.new
    artist.id = record['id']
    artist.name = record['name']
    artist.genre = record['genre']
    return artist
  end

  def create(artist)
    sql = 'INSERT INTO artists (name, genre) VALUES ($1, $2);'
    params = [artist.name, artist.genre]
    DatabaseConnection.exec_params(sql, params)
    return nil
  end

  def delete(id)
    sql = 'DELETE FROM artists WHERE id = $1;'
    params = [id]
    DatabaseConnection.exec_params(sql, params)
    return nil
  end

  def update(artist)
    sql = 'UPDATE artists SET name = $1, genre = $2 WHERE id = $3;'
    params = [artist.name, artist.genre, artist.id]
    DatabaseConnection.exec_params(sql, params)
    return nil
  end

  def find_with_album(artist_id)
    sql = 'SELECT artists.id,
                  artists.name,
                  artists.genre,
                  albums.id AS "album_id",
                  albums.title,
                  albums.release_year
          FROM artists
          JOIN albums ON albums.artist_id = artists.id
          WHERE artists.id = $1;'
    params = [artist_id]
    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]

    artist = Artist.new
    artist.id = record['id']
    artist.name = record['name']
    artist.genre = record['genre']

    result_set.each do |record|
      album = Album.new
      album.id = record['id']
      album.title = record['title']
      album.release_year = record['release_year']
      artist.albums << album
    end
    return artist
  end

end