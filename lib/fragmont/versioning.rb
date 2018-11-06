require 'sprockets/version'

module Fragmont
  module Versioning
    def sprockets4?
      defined?(Sprockets) &&
        Sprockets::VERSION.to_f >= 4 &&
        Sprockets::VERSION.to_f < 5
    end
  end

  Versioning.extend(Versioning)
end
