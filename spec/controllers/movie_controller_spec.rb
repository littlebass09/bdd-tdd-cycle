require 'spec_helper'

describe MoviesController do 
    
    describe "index can be reached" do
        it "gets the index with index" do
            get :index
            expect(response).to render_template("index")
        end
    end
    
    describe "find similar movies with director" do
        before :each do
            Movie.create ({:title => "My Movie 0"})
            Movie.create ({:title => "My Movie 1"})
            Movie.create ({:title => "My Movie 2", :director => "Bob"})
            Movie.create ({:title => "My Movie 3", :director => "Tim"})
            Movie.create ({:title => "My Movie 4", :director => "Bob"})
            Movie.create ({:title => "My Movie 5", :director => "Bob"})
            Movie.create ({:title => "My Movie 6", :director => "Bob"})
            get :same_movie_director, :id => 3
        end
        it "renders the correct template" do 
            response.should render_template "same_movie_director"
        end
        it "gets the id of the movie" do
            controller.params[:id].should match 3.to_s
        end
        it "Bob should get 4 matches" do
            controller.instance_variable_get(:@movies).length.should be 4
        end
    end
    
    describe "find similar movie with no director" do
        before :each do
            Movie.create ({:title => "My Movie 0"})
            Movie.create ({:title => "My Movie 1"})
            Movie.create ({:title => "My Movie 2"})
            Movie.create ({:title => "My Movie 3", :director => "Tim"})
        end
        it "is redirected to root" do 
            get :same_movie_director, :id => 3
            response.should redirect_to "/"
        end
        it "says it has no director info when there is no director" do 
            get :same_movie_director, :id => 3
            flash[:notice].should have_content "has no director info"
        end
    end
    
    
    
    
end