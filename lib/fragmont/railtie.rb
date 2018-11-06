require 'fragmont'

module Fragmont
  class Railtie < ::Rails::Railtie
    EXTENSIONS = %w(.ttf .otf)

    config.before_configuration do |app|
      app.config.assets.fonts = Fragmont::Manifest.new(app)
    end

    config.after_initialize do |app|
      # add files to asset pipeline
    end

    config.assets.configure do |env|
      EXTENSIONS.each do |extension|
        mime_type = env.mime_exts[extension]

        if env.respond_to?(:register_transformer)
          # env.register_mime_type(mime_type, extensions: [extension])
          env.register_preprocessor(mime_type, Fragmont::Preprocessor)
        end

        args = [extension, Fragmont::Preprocessor]

        if Sprockets::VERSION.start_with?('3')
          args << { mime_type: mime_type, silence_deprecation: true }
        end

        env.register_engine(*args)
      end
    end
  end
end
