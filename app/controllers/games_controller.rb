require 'json'
require 'nokogiri'
require 'open-uri'


class GamesController < ApplicationController

  def action
  end

  def new
    @letters = []
    while @letters.size < 10 do
      letter = ("A".."Z").to_a.sample
      @letters << letter
    end
  end

  def score
    @result = params[:result]
    @letters = params[:letters]

    if letter_compare(@result, @letters) && letter_api(@result)

      @display = "you win"
    else
      @display = "you loose"
    end

  end

  def letter_compare(result, letters)
    result.split('').each do |letter|
      if letters.delete(letter)
        @include_letter = true
      else
        @include_letter = false
      end
    end
    return @include_letter
  end

  def letter_api(lambda)
    url = "https://wagon-dictionary.herokuapp.com/#{lambda}"
    user_serialized = URI.open(url).read
    compare = JSON.parse(user_serialized)
    letter_include_api = compare[:found]
  end

end
