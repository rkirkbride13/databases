require_relative '../app.rb'

RSpec.describe Application do
  it "prints the list of albums if user input is 1" do
    terminal = double :terminal
    album_1 = double :album, id: "1", title: "Surfer Rosa"
    album_2 = double :album, id: "2", title: "Super Trooper"
    album_repository = double :album_repo, all: [album_1, album_2]
    artist_repository = double :artist_repo
    expect(terminal).to receive(:puts).with("Welcome to the music library manager!").ordered
    expect(terminal).to receive(:puts).with("What would you like to do?").ordered
    expect(terminal).to receive(:puts).with("  1 - List all albums").ordered
    expect(terminal).to receive(:puts).with("  2 - List all artists").ordered
    expect(terminal).to receive(:print).with("Enter your choice: ").ordered
    expect(terminal).to receive(:gets).and_return("1").ordered
    expect(terminal).to receive(:puts).with("Here is the list of albums:").ordered
    expect(terminal).to receive(:puts).with("* 1 - Surfer Rosa").ordered
    expect(terminal).to receive(:puts).with("* 2 - Super Trooper").ordered
    app = Application.new("music_library_test", terminal, album_repository, artist_repository)
    app.run
  end

  it "prints the list of artists if user input is 2" do
    terminal = double :terminal
    artist_1 = double :artist, id: "1", name: "Midland"
    artist_2 = double :artist, id: "2", name: "Overmono"
    album_repository = double :album_repo
    artist_repository = double :artist_repo, all: [artist_1, artist_2]
    expect(terminal).to receive(:puts).with("Welcome to the music library manager!").ordered
    expect(terminal).to receive(:puts).with("What would you like to do?").ordered
    expect(terminal).to receive(:puts).with("  1 - List all albums").ordered
    expect(terminal).to receive(:puts).with("  2 - List all artists").ordered
    expect(terminal).to receive(:print).with("Enter your choice: ").ordered
    expect(terminal).to receive(:gets).and_return("2").ordered
    expect(terminal).to receive(:puts).with("Here is the list of artists:").ordered
    expect(terminal).to receive(:puts).with("* 1 - Midland").ordered
    expect(terminal).to receive(:puts).with("* 2 - Overmono").ordered
    app = Application.new("music_library_test", terminal, album_repository, artist_repository)
    app.run
  end
end