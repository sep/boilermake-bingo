require 'rubygems'
require 'bundler'

Bundler.require
Dotenv.load

require 'libreconv'
require 'combine_pdf'
require './word_generator'
require './bingo_card'
require './card_generator'

include BoilerMakeBingo

TechWords = %w{HTML5 Javascript Ruby Go Swift C Haskell Rust Erlang Elixir LISP Node}
ServiceWords = %w{Twitter Twilio InIn HealthKit Force.com IFTTT Fitbit Github Sunlight Labs Amazon Alexa}
PlatformWords = %w{Android iOS Web Pebble Apple\ Watch Android Wear Cardboard Arduino Raspberry Pi Kinect Heroku Docker}
SimpleGenerator = WordGenerator.new(TechWords + ServiceWords + PlatformWords)
BucketGenerator = BucketedWordGenerator.new([
  {words: TechWords, weight: 1},
  {words: ServiceWords, weight: 3},
  {words: PlatformWords, weight: 2}
])

desc "A 'card.docx' is the input... should have mail merge fields b0 through o4"
task :single_card do
  rm 'outfile.docx'
  card = Card.new('card.docx', SimpleGenerator.generate)
  card.generate('outfile.docx')
end

desc "A 'card.docx' is the input... should have mail merge fields b0 through o4"
task :multiple_cards do
  cards = CardGenerator.new('card.docx', SimpleGenerator)
  cards.generate(5, '.')
end

task :whatever do
  soffice = '/Applications/LibreOffice.app/Contents/MacOS/soffice'
  Libreconv.convert('outfile_1.docx', 'whatever1.pdf', soffice)
  Libreconv.convert('outfile_2.docx', 'whatever2.pdf', soffice)
end

task :join do
  pdf = CombinePDF.new
  pdf << CombinePDF.load("whatever1.pdf")
  pdf << CombinePDF.load("whatever2.pdf")
  pdf.save "combined.pdf"
end
