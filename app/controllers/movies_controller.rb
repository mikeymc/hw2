class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings
    if !params.has_key? :ratings and !params.has_key? :sort_by
        if !session.has_key? :ratings
            session[:ratings] = @all_ratings
        end
        if !session.has_key? :sort_by
            session[:sort_by] = 'title'
        end
        flash.keep
        redirect_to movies_path :ratings => session[:ratings], :sort_by => session[:sort_by]
    else
        if params.has_key? :ratings and !params.has_key? :sort_by
            if !params[:ratings].empty?
                session[:ratings] = params[:ratings].keys
            end
            redirect_to movies_path :ratings => session[:ratings], :sort_by => session[:sort_by]
        end
        if params.has_key? :sort_by and !params.has_key? :ratings
            session[:sort_by] = params[:sort_by]
            redirect_to movies_path :ratings => session[:ratings], :sort_by => session[:sort_by]
        end
        
        @checked = session[:ratings]
        @movies = Movie.return_with_conditions(session)
        debugger
    end
  end


=begin
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
