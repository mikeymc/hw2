class Movie < ActiveRecord::Base
    
    def self.sort_by_title
        @movies = Movie.find(:all, :order => 'title')
    end
    
    def self.sort_by_release_date
        @movies = Movie.find(:all, :order => 'release_date')
    end
    
end
