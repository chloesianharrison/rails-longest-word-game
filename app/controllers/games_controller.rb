require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
  end

  def word_validation
    word_tally = @guess.downcase.chars.tally
    letters_tally = @letters.to_a.join.downcase.chars.tally
    word_tally.all? do |key, value|
      letters_tally[key] && value <= letters_tally[key]
    end
  end

  def api_dictionary
    url = "https://wagon-dictionary.herokuapp.com/#{@guess}"
    user_serialized = URI.open(url).read
    user = JSON.parse(user_serialized)
    user['found']
  end

  def score
    @guess = params[:word]
  end
end
