require 'set'

module Fragmont
  class Entry
    include Versioning

    attr_reader :codepoints, :filename, :manifest

    def initialize(filename, manifest)
      @filename = filename
      @manifest = manifest
      @codepoints = Set.new
    end

    def add_locale(locale)
      add_translations(locale, '.')
    end

    def add_translations(locale, prefix)
      add_structure(
        I18n.backend.send(:lookup, locale, prefix)
      )
    end

    def add_string(str)
      codepoints.merge(str.encode(Encoding::UTF_8).codepoints)
    end

    def absolute_path
      @absolute_path ||= begin
        path = manifest.app.assets.resolve(filename)

        if sprockets4? && path.is_a?(Array)
          URI.parse(path.first).path
        else
          path
        end
      end
    end

    private

    def add_structure(structure)
      case structure
        when Hash
          structure.each_pair { |k, v| add_structure(v) }
        when Array
          structure.each { |el| add_structure(el) }
        else
          if structure.respond_to?(:to_s)
            add_string(structure.to_s)
          else
            raise ArgumentError, 'structure must be an array or hash or respond to #to_s'
          end
      end
    end
  end
end
