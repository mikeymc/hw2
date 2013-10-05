class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end
  
  def index
    @all_ratings = Movie.all_ratings
    @checked = @all_ratings
    if params.has_key? :ratings
        if !params[:ratings].empty?
            session[:ratings] = params[:ratings].keys
        else
            session[:ratings] = Movie.all_ratings
        end
    elsif params.has_key? :sort_by
        session[:sort_by] = params[:sort_by]
    end
    if session.has_key? :ratings
        @checked = session[:ratings]
    end
    @movies = Movie.return_with_conditions(session)
  end
  
=begin  
  def index
    @sort_by_title, @sort_by_release_date = false, false
    @all_ratings = Movie.all_ratings
    if params.has_key? :sort_by
      if params[:sort_by] == 'title'
        @sort_by_title = true
        @movies = Movie.sort_by_title
      elsif params[:sort_by] == 'release_date'
        @sort_by_release_date = true
        @movies = Movie.sort_by_release_date
      end
    else
      @movies = Movie.all
    end
  end
=end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
  def sort_by_title
    redirect_to movies_path :sort_by => :title
  end
  
  def sort_by_release_date
    redirect_to movies_path :sort_by => :release_date
  end

end
