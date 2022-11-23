require 'album_repository'

RSpec.describe AlbumRepository do

  def reset_albums_table
    seed_sql = File.read('spec/seeds_albums.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  describe AlbumRepository do
    before(:each) do 
      reset_albums_table
    end

    it 'returns album table' do 
      repo = AlbumRepository.new
      albums = repo.all
      expect(albums.length).to eq 2
      expect(albums[0].id).to eq '1'
      expect(albums[0].title).to eq 'Surfer Rosa'
      expect(albums[0].release_year).to eq '1988'
      expect(albums[0].artist_id).to eq '1'
      expect(albums[1].id).to eq '2'
      expect(albums[1].title).to eq 'Super Trooper'
      expect(albums[1].release_year).to eq '1980'
      expect(albums[1].artist_id).to eq '2'
    end

    it 'returns the album with id 1' do
      repo = AlbumRepository.new
      album = repo.find(1)
      expect(album.id).to eq '1'
      expect(album.title).to eq 'Surfer Rosa'
      expect(album.release_year).to eq '1988'
      expect(album.artist_id).to eq '1'
    end

    it 'returns the album with id 2' do
      repo = AlbumRepository.new
      album = repo.find(2)
      expect(album.id).to eq '2'
      expect(album.title).to eq 'Super Trooper'
      expect(album.release_year).to eq '1980'
      expect(album.artist_id).to eq '2'
    end

    it "creates a new album at the end of the table" do
      repo = AlbumRepository.new
      album = Album.new
      album.title = 'DAMN.'
      album.release_year = '2016'
      album.artist_id = '3'
      repo.create(album)

      albums = repo.all
      last_album = albums.last
      expect(last_album.title).to eq 'DAMN.'
      expect(last_album.release_year).to eq '2016'
      expect(last_album.artist_id).to eq '3'
    end

    it "creates a new album at the end of the table (diff matcher)" do
      repo = AlbumRepository.new
      new_album = Album.new
      new_album.title = 'DAMN.'
      new_album.release_year = '2016'
      new_album.artist_id = '3'
      repo.create(new_album)

      albums = repo.all
      expect(albums).to include(
        have_attributes(
          title: new_album.title,
          release_year: new_album.release_year,
          artist_id: new_album.artist_id
          )
        )
    end

    it "deletes the album with id 1" do
      repo = AlbumRepository.new
      album = repo.find(1)
      repo.delete(1)
      
      all_albums = repo.all
      expect(all_albums.length).to eq 1
      expect(all_albums.first.id).to eq '2'
    end

    it "updates the album with id 1" do
      repo = AlbumRepository.new
      album = repo.find(1)
      album.title = 'Something else'
      album.release_year = '2023'
      album.artist_id = '10'
      repo.update(album)
      
      updated_album = repo.find(1)
      expect(updated_album.title).to eq 'Something else'
      expect(updated_album.release_year).to eq '2023'
      expect(updated_album.artist_id).to eq '10'
    end
  end
end