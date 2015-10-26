require 'spec_helper'
require 'rails_helper'
    
describe MoviesController do
    before :each do
        @results = [{:tmdb_id => 1593, :title => "Night at the Museum", :rating => "PG", :release_date => "2006-12-21"}]	
    end
    describe 'searching TMDb' do
        it 'should call the model method that performs TMDb search' do
            expect(Movie).to receive(:find_in_tmdb).with('Night').and_return(@results)
            post :search_tmdb, {:search_terms => 'Night'}
        end
        it 'should make the TMDb search results available to that template' do
            post :search_tmdb, {:search_terms => 'Night'}
            expect(assigns(:movies)).to eq @results
        end
        context 'invalid search' do
            before :each do
                post :search_tmdb, {:search_terms => ''}
            end
            it 'should display an error message' do
                expect(flash[:notice]).to eq "Invalid search term"
            end
            it 'should redirect to the homepage' do
                expect(Movie).to redirect_to(movies_path)
            end
        end
        context 'Movie not found' do
            before :each do
               post :search_tmdb, {:search_terms => 'zzzzzzzzzzzzzzzzzzzzzzzzzz'} 
            end
            it 'should display an error message' do
                expect(flash[:notice]).to eq "No matching movies were found on TMDB"
            end
            it 'should redirect to the homepage' do
                expect(Movie).to redirect_to(movies_path)
            end
        end
    end
    describe 'adding TMDb movie' do
        it 'should try to find the movie' do
            expect(Movie).to receive(:find_in_tmdb).with('Night').and_return(@results)
        end
        describe 'No movie selection' do
            it 'should display an error message if a movie is not selected' do
                expect(flash[:notice]).to eq "No movies selected"
            end
            it 'should redirect to the homepage' do
                expect(Movie).to redirect_to(movies_path)
            end
        end
        describe 'Movie selected' do
            it 'should add the selected movie to the database' do
            end
            it 'should redirect to the homepage' do
                expect(Movie).to redirect_to(movies_path)
            end
            it 'should display a confirmation message' do 
                expect(flash[:notice]).to eq "Movies were successfully added"
            end
        end
    end
end