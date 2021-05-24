require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    word_letters = @word.upcase.split('')

    word_letters.each do |word_letter|
      if word_letters.count(word_letter) > @letters.count(word_letter)
        @score = "Sorry, but #{@word.upcase} can't be built out of #{@letters}"
      elsif dictionary?(@word) == false
        @score = "Sorry, but #{@word.upcase} does not seem to be valid English word..."
      else
        @score = "Congratulations! #{@word.upcase} is a valid English word!"
      end
    end
  end

  def dictionary?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    serialized_dict = URI.open(url).read
    dict = JSON.parse(serialized_dict)

    dict['found']
  end
end
