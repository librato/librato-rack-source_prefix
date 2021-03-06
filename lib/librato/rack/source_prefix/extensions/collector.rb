module Librato::Rack::SourcePrefix
  module Extensions
    module Collector

      def self.included(klass)
        # Explicitly removing methods that we intend to override. This is
        # necessary so that the methods in our module will be used when
        # they're mixed-in to the real Collector class. Typically you wouldn't
        # do this, but since the methods we're overriding are just delegates
        # to other objects, we can safely remove the methods and call the
        # underlying objects directly from our new implementations.
        [:increment, :measure, :timing].each do |method|
          if klass.instance_methods(false).include?(method)
            klass.send(:remove_method, method)
          end
        end
      end

      def increment(counter, options={})
        if prefix_needed?(options)
          options[:source] = apply_prefix(options[:source])
        end

        counters.increment(counter, options)
      end

      def measure(*args, &block)
        # If there are options
        if args.length > 1 and args[-1].respond_to?(:each)
          options = args[-1]

          if prefix_needed?(options)
            options[:source] = apply_prefix(options[:source])
          end
        end

        aggregate.measure(*args, &block)
      end
      alias :timing :measure

      private

      def prefix_needed?(options)
        if options[:apply_prefix].nil?
          apply_prefix = true
        else
          apply_prefix = options.delete(:apply_prefix)
        end

        apply_prefix &&
          options[:source] &&
          global_source &&
          !global_source.empty?
      end

      def apply_prefix(source)
        if source_pids
          "#{global_source}.#{$$}.#{source}"
        else
          "#{global_source}.#{source}"
        end
      end

      def global_source
        Librato.tracker.config.source
      end

      def source_pids
        Librato.tracker.config.source_pids
      end
    end
  end
end

