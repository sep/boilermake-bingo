module BoilerMakeBingo
  class WordGenerator
    def initialize(words)
      @words = words
    end

    def generate
      @words.sample(25)
    end
  end

  class BucketedWordGenerator
    def initialize(buckets)
      @buckets = buckets
    end

    def generate
      weighted = @buckets.inject([]){|memo, obj| memo + obj[:words]*obj[:weight]}

      words = Hash.new

      until words.keys.length == 25 do
        words[weighted.sample(1).first] = ""
      end

      words.keys
    end
  end
end
