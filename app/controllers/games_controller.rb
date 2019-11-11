require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = 10.times.map { ('A'..'Z').to_a.sample }
  end

  def score
    list = params[:letters]
    list_array = list.split(' ')
    answer = params[:word].upcase
    answer_array = answer.split('')
    url = "https://wagon-dictionary.herokuapp.com/#{answer}"
    dico = JSON.parse(open(url).read)
    answer_array.each do |letter|
      if list_array.include?(letter) == false
        @message = "Sorry but #{answer} can't be built out of #{list}"
      elsif dico['found'] == false
        @message = "Sorry but #{answer} does not seem to be a valid English word..."
      else
        @message = "Congratulations! #{answer} is an english valid word"
      end
      return @message
    end
  end
end
