require 'spec_helper'
require 'rails_helper'

describe Movie do
	describe 'searching	Tmdb by	keyword' do	
		context	'with valid key' do	
			it	'should	call Tmdb with +tle	keywords' do	
				expect(	Tmdb::Movie).to	receive(:find).with('Inception')	
				Movie.find_in_tmdb('Inception')	
			end	
		end	
		context	'with invalid key' do	
			it 'should raise InvalidKeyError if key is missing or invalid' do	
				allow(Tmdb::Movie).to receive(:find).and_raise(NoMethodError)	
				allow(Tmdb::Api).to	receive(:response).and_return({'code'=>	'401'})	
				expect{Movie.find_in_tmdb('Inception')}.to raise_error(Movie::InvalidKeyError)	
			end	
		end	
	end	
end