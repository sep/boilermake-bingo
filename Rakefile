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

Soffice = '/Applications/LibreOffice.app/Contents/MacOS/soffice'
TechWords = %w{HTML5 Javascript Ruby Go Swift C Haskell Rust Erlang Elixir LISP Node C++}
ServiceWords = %w{Twitter Twilio HealthKit Force.com IFTTT Fitbit Github Sunlight\ Labs Amazon\ Alexa Google Facebook}
PlatformWords = %w{Android iOS Web Cloud Pebble Apple\ Watch Android\ Wear Google\ Cardboard Arduino Raspberry\ Pi Kinect Heroku Docker}

SimpleGenerator = WordGenerator.new(TechWords + ServiceWords + PlatformWords)
BucketGenerator = BucketedWordGenerator.new([
  {words: TechWords, weight: 1},
  {words: ServiceWords, weight: 4},
  {words: PlatformWords, weight: 2}
])

OutputDir = 'output'

desc "A 'card.docx' is the input... should have mail merge fields b0 through o4"
task :single_card => :clean do
  Card.new('card.docx', BucketGenerator.generate).generate('output.docx')
  Libreconv.convert('output.docx', 'output.pdf', Soffice)
  Dir.glob('output.docx').each{|docx| File.delete(docx)}
end

task :call, :response do |t, args|
  response = args[:response]
desc "A 'card.docx' is the input... should have mail merge fields b0 through o4"
task :multiple_cards, :num_cards => :clean do |t, args|
  args.with_defaults(num_cards: 10)

  Dir.mkdir(OutputDir)

  CardGenerator.new('card.docx', BucketGenerator).generate(args[:num_cards], OutputDir)
  Dir.glob("#{OutputDir}/*.docx").each{|docx| Libreconv.convert(docx, "#{docx}.pdf", Soffice)}

  output = CombinePDF.new
  Dir.glob("#{OutputDir}/*.pdf").each{|pdf| output << CombinePDF.load(pdf)}
  output.save "output.pdf"
end

task :clean do
  Dir.glob("#{OutputDir}/*").each{|file| File.delete(file)}
  Dir.rmdir(OutputDir) if Dir.exists?(OutputDir)
end
