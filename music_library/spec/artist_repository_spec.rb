require 'artist_repository'

RSpec.describe ArtistRepository do

  def reset_artists_table
    seed_sql = File.read('spec/seeds_artists.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  describe ArtistRepository do
    before(:each) do 
      reset_artists_table
    end

    it "lists the artists table" do
      repo = ArtistRepository.new

      artist = repo.all

      expect(artist.length).to eq 2
      expect(artist[0].id).to eq '1'
      expect(artist[0].name).to eq 'Pixies'
      expect(artist[0].genre).to eq 'Rock'
    end

    it "finds the artist with an id of 1" do
      repo = ArtistRepository.new
      artist = repo.find(1)
      expect(artist.id).to eq '1'
      expect(artist.name).to eq 'Pixies'
      expect(artist.genre).to eq 'Rock'
    end

    it "creates an artist and puts it at end of table" do
      repo = ArtistRepository.new
      artist = Artist.new
      artist.name = 'Beatles'
      artist.genre = 'Pop'
      repo.create(artist)

      artists = repo.all
      last_artist = artists.last
      expect(last_artist.name).to eq 'Beatles'
      expect(last_artist.genre).to eq 'Pop'
    end

    it "deletes the first artist from the table" do
      repo = ArtistRepository.new      
      id_to_delete = 1
      repo.delete(id_to_delete)
      all_artists = repo.all
      expect(all_artists.length).to eq  1
      expect(all_artists.first.id).to eq '2'
    end

    it "deletes both artists from the table" do
      repo = ArtistRepository.new
      repo.delete(1)
      repo.delete(2)
      
      all_artists = repo.all
      expect(all_artists.length).to eq  0
    end

    it "updates the artist with id 1" do
      repo = ArtistRepository.new
      artist = repo.find(1)
      artist.name = 'Something else'
      artist.genre = 'Disco'
      repo.update(artist)
      
      updated_artist = repo.find(1)
      expect(updated_artist.name).to eq 'Something else'
      expect(updated_artist.genre).to eq 'Disco'
    end

    it "updates the artist with a new name only" do
      repo = ArtistRepository.new
      artist = repo.find(1)
      artist.name = 'Something else'
      repo.update(artist)
      
      updated_artist = repo.find(1)
      expect(updated_artist.name).to eq 'Something else'
      expect(updated_artist.genre).to eq 'Rock'
    end

    it "finds an artist and their related albums" do
      repo = ArtistRepository.new
      artist = repo.find_with_album(2)
      expect(artist.albums.length).to eq 1
      expect(artist.name).to eq 'ABBA'
      expect(artist.genre).to eq 'Pop'
      expect(artist.albums.first.title).to eq 'Super Trooper'
      expect(artist.albums.first.release_year).to eq '1980'
    end
  end
end