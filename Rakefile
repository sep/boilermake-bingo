require 'rubygems'
require 'bundler'

Bundler.require
Dotenv.load
ENVied.require

require './word_generator'
require './bingo_card'
require './card_generator'

include BoilerMakeBingo

TechWords = %w{JavaScript Ruby Go Swift C Haskell Rust Erlang Elixir TypeScript Elm LISP Node C++ C# Java Python Xamarin Vue Angular React ReactNative Flutter Kotlin Machine\ Learning ARKit AR\ Foundation AI Python Blockchain}
ServiceWords = %w{Twitter Twilio HealthKit IFTTT Fitbit Github OpenGov Alexa Google Facebook Minecraft\ Forge NOAA\ CDO}
PlatformWords = %w{ChromeOS Android iOS Web Apple\ Watch Arduino Raspberry\ Pi Heroku Voice AWS Azure Docker Hadoop}

SimpleGenerator = WordGenerator.new(TechWords + ServiceWords + PlatformWords)
BucketGenerator = BucketedWordGenerator.new([
  {words: TechWords, weight: 1},
  {words: ServiceWords, weight: 4},
  {words: PlatformWords, weight: 2}
])
HashtagGenerator = HashtagGeneratorDecorator.new(BucketGenerator)

desc "A '#{ENVied.TEMPLATE}' is the input... should have mail merge fields b0 through o4"
task :generate, :num_cards do |t, args|
  args.with_defaults(num_cards: 1)

  CardGenerator.new(ENVied.TEMPLATE, HashtagGenerator).generate(args[:num_cards].to_i)
end

desc "Shows the merge fields in '#{ENVied.TEMPLATE}'"
task :merge_fields do
  p Card.new(ENVied.TEMPLATE, []).merge_fields
end
