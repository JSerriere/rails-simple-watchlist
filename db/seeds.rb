require_relative '../.tmdb_api_key.rb'
require "rest-client"
require "open-uri"
require "json"

puts "Cleaning up database..."
  Movie.destroy_all
puts "Database cleaned"

def movies_dataset
  url = RestClient.get("https://api.themoviedb.org/3/movie/top_rated?api_key=#{$tmdb_api_key}")
  movies_array = JSON.parse(url)["results"]
  movies_array.each do |movie|
    puts "Creating #{movie["title"]}"
    base_poster_url = "https://image.tmdb.org/t/p/original"
      Movie.create(
        title: movie["title"],
        original_title: movie["original_title"],
        release_date: movie["release_date"],
        original_language: movie["original_language"],
        overview: movie["overview"],
        poster_url: "#{base_poster_url}#{movie["backdrop_path"]}",
        rating: movie["vote_average"]
      )
  end
end

movies_dataset()

puts "Movies created"
