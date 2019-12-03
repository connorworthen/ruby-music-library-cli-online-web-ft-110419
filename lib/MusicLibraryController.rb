require "pry"
class MusicLibraryController

  extend Concerns::Findable

  def initialize(path = "./db/mp3s")
    new_importer_object = MusicImporter.new(path)
    new_importer_object.import
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

      case input
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
    self.play_song
  when "exit"
    'exit'
  else
    call
  end
end

  def list_songs
    listed_songs = Song.all.collect.sort_by{|song| song.name}
    listed_songs.uniq.each_with_index{|song, index| puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
  end

  def list_artists
    songs_sorted_by_artist = Artist.all.sort_by do |artist|
      artist.name
    end
    songs_sorted_by_artist.each.with_index(1) do |artist,index|
      puts "#{index}. #{artist.name}"
    end
  end

  def list_genres
    songs_sorted_by_genre = Genre.all.sort_by do |genre|
      genre.name
    end
    songs_sorted_by_genre.each.with_index(1) do |genre,index|
      puts "#{index}. #{genre.name}"
    end
  end


  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.chomp
    if artist = Artist.find_by_name(input)
      songs_sorted_by_name = artist.songs.sort_by do |song|
        song.name
      end
      songs_sorted_by_name.each.with_index(1) do |song,index|
        puts "#{index}. #{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.chomp
    if genre = Genre.find_by_name(input)
      songs_sorted_by_name = genre.songs.sort_by do |song|
        song.name
      end

      songs_sorted_by_name.each.with_index(1) do |song,index|
        puts "#{index}. #{song.artist.name} - #{song.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    song_names = self.song_array
    user_input = gets.chomp.to_i
    if user_input > 0 && user_input <= self.library.size
      chosen_input = song_names[user_input - 1]
      chosen_input = name_extractor(chosen_input)[1]
      song = Song.find_by_name(chosen_input)
      puts "Playing #{song.name} by #{song.artist.name}" unless song == nil
   end
 end
end
