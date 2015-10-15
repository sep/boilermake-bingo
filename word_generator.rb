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
      @buckets
        .inject([]){|memo, obj| memo + obj[:words]*obj[:weight]}
        .sample(500).uniq  # hack to ensure we get at least 25 uniques
        .take(25)
    end
  end
end
