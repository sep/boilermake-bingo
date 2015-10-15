require 'docx_mailmerge'

module BoilerMakeBingo
  class Card
    def initialize(template, words)
      @template = template
      @words = words
#DocxMailmerge::DocxCreator
      @docx = DocxMailmerge::DocxCreator.new(@template)
    end

    def merge_fields
      @docx.merge_field_names
    end

    def generate(output_file)
      # looks like: {'b0' => @words[0], 'b1' => @words[1]}
      cells = "bingo".chars
        .product((0..4).to_a).collect{|a,b| "#{a}#{b}"}
        .each_with_index
        .map{|k, i| {key: k, index: i}}
        .inject({}){|memo, obj| memo[obj[:key]] = @words[obj[:index]]; memo}

      output = @docx.generate_docx_bytes(cells, {})

      File.open(output_file, 'wb') {|file| file.write(output)}
    end
  end
end
