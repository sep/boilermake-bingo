module BoilerMakeBingo
  class CardGenerator
    def initialize(template, word_generator)
      @template = template
      @word_generator = word_generator
    end

    def generate(num_cards, output_dir)
      (1..num_cards).to_a.each do |i|
        words = @word_generator.generate
        card = Card.new(@template, words)
        card.generate("#{output_dir}/outfile_#{i}.docx")
      end
    end
  end
end
