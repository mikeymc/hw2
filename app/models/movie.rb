class Movie < ActiveRecord::Base
    
    def self.sort_by_title
        @movies = Movie.find(:all, :order => 'title')
    end
    
    def self.sort_by_release_date
        @movies = Movie.find(:all, :order => 'release_date')
    end
    
    def self.all_ratings
        return ['G', 'PG', 'PG-13', 'R']
    end
    
    def self.return_with_conditions(session)
        if session.has_key? :ratings
            @movies = Movie.where(rating: [session[:ratings]])
        else
            @movies = Movie.all
        end
        if session.has_key? :sort_by
            @movies = @movies.order(session[:sort_by])
        end
        return @movies
    end
    
end
