require 'spec_helper'

describe MoviesController do
  it 'should be possible to create new movie' do
    movie = mock('Movie')
    movie.stub(:title)
      
    Movie.should_receive(:create!).and_return(movie)
      
    post :create, { :movie => movie }

    response.should redirect_to(movies_path)
  end
  it 'should be possible to delete movie' do
    movie = mock('Movie')
    movie.stub(:title)

    Movie.should_receive(:find).with('1').and_return(movie)
    movie.should_receive(:destroy)

    post :destroy, { :id => '1' }
    response.should redirect_to(movies_path)
  end
end
