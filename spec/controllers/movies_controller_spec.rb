require 'spec_helper'

describe MoviesController do
    describe 'passing params when sorting by title or release date' do
        it 'should pass a sort by title hash to the index page' do
            get :sort_by_title
            response.should redirect_to '/movies?sort_by=title'
        end
        it 'should pass a sort by release date hash to the index page' do    
            get :sort_by_release_date
            response.should redirect_to '/movies?sort_by=release_date'
        end
    end
    describe 'checking params in the movies index method' do
        it 'should not see any params in the default state'
            # how do i call the index method with params and check state?
        it 'should see :sort_by => :title when sorting by title'
        it 'should see :sort_by => :release date when sorting by release date'
    end
end
