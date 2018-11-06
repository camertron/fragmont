module Fragmont
  class Manifest
    attr_reader :app, :entries

    def initialize(app)
      @app = app
      @entries = []
    end

    def subset(filename)
      new_entry = Entry.new(filename, self)
      yield new_entry if block_given?
      entries << new_entry
    end

    def entry_for(absolute_path)
      entries.find { |entry| entry.absolute_path == absolute_path }
    end
  end
end
