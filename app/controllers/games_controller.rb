require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('A'..'Z').to_a[rand(26)] }
  end

  def english_word?(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    word_serialized = URI.open(url).read
    JSON.parse(word_serialized)
  end

  def score
    @result = { score: 0, message: 'It is not in the grid' }
    @attempt_letters = params[:word].upcase.split('')
    @letters = params[:letters]
    if @attempt_letters.all? { |letter| @attempt_letters.count(letter) <= @letters.count(letter) }
      if english_word?(params[:word])['found'] == true
        @result[:score] = @attempt_letters.size
        @result[:message] = "Well Done!"
      else @result = 'It is not an english word'
      end
      @result
    end
  end
end
