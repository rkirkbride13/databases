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
end

end