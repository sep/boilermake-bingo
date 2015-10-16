module BoilerMakeBingo
  class CardGenerator
    def initialize(template, word_generator)
      @template = template
      @word_generator = word_generator
    end

    def generate(num_cards, output_dir='tmp')
      prepare_dir(output_dir)

      (1..num_cards).to_a.each do |i|
        words = @word_generator.generate
        card = Card.new(@template, words)
        card.generate_pdf("#{output_dir}/outfile_#{i}.pdf")
      end

      output = CombinePDF.new
      Dir.glob("#{output_dir}/*.pdf").each{|pdf| output << CombinePDF.load(pdf)}
      output.save "output.pdf"

      clean_dir(output_dir)
    end

    def prepare_dir(output_dir)
      clean_dir(output_dir)
      Dir.mkdir(output_dir)
    end

    def clean_dir(output_dir)
      Dir.glob("#{output_dir}/*").each{|file| File.delete(file)}
      Dir.rmdir(output_dir) if Dir.exists?(output_dir)
    end
  end
end
