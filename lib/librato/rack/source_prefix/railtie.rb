module Librato::Rack::SourcePrefix
  class Railtie < ::Rails::Railtie

    initializer 'librato.rack.source_prefix.extensions' do
      Librato::Collector.include(
        Librato::Rack::SourcePrefix::Extensions::Collector
      )
    end
  end
end
