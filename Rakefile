require 'rubygems'
require 'bundler'

Bundler.require
Dotenv.load
ENVied.require

require './word_generator'
require './bingo_card'
require './card_generator'

include BoilerMakeBingo

TechWords = %w{HTML5 Javascript Ruby Go Swift C Haskell Rust Erlang Elixir LISP Node C++ C# Java Python}
ServiceWords = %w{Twitter Twilio HealthKit Force.com IFTTT Fitbit Github Sunlight\ Labs Amazon\ Alexa Google Facebook}
PlatformWords = %w{Android iOS Web Cloud Pebble Apple\ Watch Android\ Wear Google\ Cardboard Arduino Raspberry\ Pi Kinect Heroku Docker Hadoop}

SimpleGenerator = WordGenerator.new(TechWords + ServiceWords + PlatformWords)
BucketGenerator = BucketedWordGenerator.new([
  {words: TechWords, weight: 1},
  {words: ServiceWords, weight: 4},
  {words: PlatformWords, weight: 2}
])

desc "A '#{ENVied.TEMPLATE}' is the input... should have mail merge fields b0 through o4"
task :generate, :num_cards do |t, args|
  args.with_defaults(num_cards: 1)

  CardGenerator.new(ENVied.TEMPLATE, BucketGenerator).generate(args[:num_cards].to_i)
end

desc "Shows the merge fields in '#{ENVied.TEMPLATE}'"
task :merge_fields do
  p Card.new(ENVied.TEMPLATE, []).merge_fields
end
