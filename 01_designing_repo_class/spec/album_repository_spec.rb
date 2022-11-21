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
  end

end