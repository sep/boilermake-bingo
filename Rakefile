require 'rubygems'
require 'bundler'

Bundler.require
Dotenv.load

require './word_generator'
require './bingo_card'

include BoilerMakeBingo


TechWords = %w{HTML5 Javascript Ruby Go Swift C Haskell Rust Erlang Elixir LISP Node}
ServiceWords = %w{Twitter Twilio InIn HealthKit Force.com IFTTT Fitbit Github Sunlight Labs Amazon Alexa}
PlatformWords = %w{Android iOS Web Pebble Apple\ Watch Android Wear Cardboard Arduino Raspberry Pi Kinect Heroku Docker}

task :doit do
  generator = WordGenerator.new(TechWords + ServiceWords + PlatformWords)
  generator = BucketedWordGenerator.new([
    {words: TechWords, weight: 1},
    {words: ServiceWords, weight: 3},
    {words: PlatformWords, weight: 2}
  ])

  rm 'outfile.docx'
  card = Card.new('card.docx', generator.generate)
  card.generate('outfile.docx')
end
