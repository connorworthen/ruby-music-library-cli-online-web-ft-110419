require 'pry'
class MusicLibraryController

  def initialize(path = "./db/mp3s")
    @path = path
    musicimporter_obj = MusicImporter.new(path)
    musicimporter_obj.import
  end

  def call
    input = ""
    while input != "exit"

    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    input = gets.strip


    end
  end

  def list_songs
    songs_sorted_by_songs = Song.all.sort_by do |songs|
      songs.name
    end
    songs_sorted_by_songs.each.with_index(1) do |songs,index|
      puts "#{index}. #{songs.name}"
    end
  end

  def list_artists
    songs_sorted_by_artist = Artist.all.sort_by do |artist|
      artist.name
    end
    songs_sorted_by_artist.each.with_index(1) do |artist,index|
      puts "#{index}. #{artist.name}"
    end
  end




end
