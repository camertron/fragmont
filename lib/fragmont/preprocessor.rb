require 'ttfunk/subset'

module Fragmont
  class Preprocessor
    class << self
      def run(filename, source, context)
        config = Rails.application.config.assets.fonts.entry_for(filename)
        return source unless config

        font = TTFunk::File.open(StringIO.new(source))
        subset = TTFunk::Subset::Unicode.new(font)

        config.codepoints.each do |codepoint|
          subset.use(codepoint)
        end

        subset.encode
      end

      def call(input)
        filename = input[:filename]
        source   = input[:data]
        context  = input[:environment].context_class.new(input)

        result = run(filename, source, context)
        context.metadata.merge(data: result)
      end
    end

    def initialize(filename, &block)
      @filename = filename
      @source = block.call
    end

    def render(context, empty_hash_wtf)
      self.class.run(@filename, @source, context)
    end
  end
end
