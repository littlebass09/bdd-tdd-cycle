require 'spec_helper'

describe MoviesController do 
    
    describe "index can be reached" do
        it "gets the index with index" do
            get :index
            expect(response).to render_template("index")
        end
    end
    
    describe "find similar movies route" do
        it "matches expected path" do 
            Movie.create ({:title => "My Movie 0"})
            Movie.create ({:title => "My Movie 1"})
            Movie.create ({:title => "My Movie 2"})
            Movie.create ({:title => "My Movie 3"})
           get :same_movie_director, :id => 3
           expect(response).to render_template "same_movie_director"
        end
    end
    
    
end