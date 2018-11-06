module Fragmont
  autoload :Entry,        'fragmont/entry'
  autoload :Manifest,     'fragmont/manifest'
  autoload :Preprocessor, 'fragmont/preprocessor'
  autoload :Versioning,   'fragmont/versioning'
end

require 'fragmont/railtie'
