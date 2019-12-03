require 'pry'
class Song

attr_accessor :name, :artist, :genre

@@all = []

  def initialize(name, genre = nil)
    @name = name
    @artist = artist
    @genre = genre
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    new_song = Song.new(name)
    new_song.save
    new_song
  end
end
