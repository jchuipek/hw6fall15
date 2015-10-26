class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def self.find_in_tmdb(title)
    @found_movies = Tmdb::Movie.find(title)
    arr = []
    @found_movies.each do |i|
      k = {:tmdb_id => i.id, :title => i.title, :rating => 'PG', :release_date => i.release_date}
      arr.push(k)
    end
    return arr
  end
  
  def self.create_from_tmdb(information)
    @info = Tmdb::Movie.detail(information)
    dateTime = DateTime.parse(@info["release_date"])
    @details = {:title => @info["original_title"], :rating => 'PG', :description => @info["overview"], :release_date => dateTime}
    Movie.create!(@details)
  end
end
