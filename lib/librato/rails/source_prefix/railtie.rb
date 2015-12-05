require 'librato-rails'

module Librato::Rails::SourcePrefix
  class Railtie < ::Rails::Railtie

    initializer 'librato.rails.source_prefix.extensions' do
      Librato::Collector.include(
        Librato::Rails::SourcePrefix::Extensions::Collector
      )
    end
  end
end
