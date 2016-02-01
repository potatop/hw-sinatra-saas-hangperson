class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses= ''
  end

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def guess(letter)
    raise ArgumentError if letter == nil || letter.empty?
    raise ArgumentError if letter !~ /[a-z]/i
    
    return false if (@guesses =~ /#{letter}/i) ||
      (@wrong_guesses =~ /#{letter}/i)
    
    if @word.include? letter
      @guesses += letter
    else
      @wrong_guesses += letter
    end
    true
  end
  
  def word_with_guesses
    return '-' * @word.length if @guesses.empty?
    t = @word.gsub(/([^#{@guesses}])/i, '-')
    t
  end
  
  def check_win_or_lose
    return :lose if @wrong_guesses.length >= 7
    return :win if @word !~ /([^#{@guesses}])/i
    :play
  end
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
