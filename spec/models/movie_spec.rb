require 'spec_helper'

describe Movie do
    describe 'sort by title' do
        it 'should return a list of movies in alphabetical order' do
            movies = [{:title => 'The Terminator', :rating => 'R', 
    	             :release_date => '26-Oct-1984'}, 
    	             {:title => 'Aladdin', :rating => 'G',
                     :release_date => '25-Nov-1992'}]
    	    movies.each do |movie|
                Movie.create!(movie)
            end
            Movie.sort_by_title.first.title.should == "Aladdin"
        end
    end
    describe 'sort by release date' do
        it 'should return a list of movies in order by release date' do
            movies = [{:title => 'Movie1', :rating => 'R', 
    	             :release_date => '26-Oct-1992'}, 
    	             {:title => 'Movie2', :rating => 'G',
                     :release_date => '25-Nov-1984'}]
    	    movies.each do |movie|
                Movie.create!(movie)
            end
            Movie.sort_by_release_date.first.title.should == "Movie2"
        end
    end
end
