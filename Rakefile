require 'rubygems'
require 'bundler'

Bundler.require
Dotenv.load
ENVied.require

require './word_generator'
require './bingo_card'
require './card_generator'

include BoilerMakeBingo

TechWords = %w{HTML5 Javascript Ruby Go Swift C Haskell Rust Erlang Elixir LISP Node C++}
ServiceWords = %w{Twitter Twilio HealthKit Force.com IFTTT Fitbit Github Sunlight\ Labs Amazon\ Alexa Google Facebook}
PlatformWords = %w{Android iOS Web Cloud Pebble Apple\ Watch Android\ Wear Google\ Cardboard Arduino Raspberry\ Pi Kinect Heroku Docker}

SimpleGenerator = WordGenerator.new(TechWords + ServiceWords + PlatformWords)
BucketGenerator = BucketedWordGenerator.new([
  {words: TechWords, weight: 1},
  {words: ServiceWords, weight: 4},
  {words: PlatformWords, weight: 2}
])

desc "A '#{ENVied.TEMPLATE}' is the input... should have mail merge fields b0 through o4"
task :single_card => :clean do
  Card.new(ENVied.TEMPLATE, BucketGenerator.generate).generate_pdf('output.pdf')
end

desc "A '#{ENVied.TEMPLATE}' is the input... should have mail merge fields b0 through o4"
task :multiple_cards, :num_cards do |t, args|
  args.with_defaults(num_cards: 10)

  CardGenerator.new(ENVied.TEMPLATE, BucketGenerator).generate(args[:num_cards].to_i)
end
