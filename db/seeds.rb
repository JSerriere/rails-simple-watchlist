require "open-uri"
require "json"

puts "Cleaning up database..."
Movie.destroy_all
puts "Database cleaned"

url = "https://api.themoviedb.org/3/movie/top_rated?api_key=ENV[“TMDB_API_KEY”]"
10.times do |i|
  puts "Importing movies from page #{i + 1}"
  movies = JSON.parse(URI.open("#{url}?page=#{i + 1}").read)["results"]
  movies.each do |movie|
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
puts "Movies created"