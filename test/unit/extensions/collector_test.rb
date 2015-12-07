require 'test_helper'
require 'librato-rack'

describe Librato::Rack::SourcePrefix::Extensions::Collector do

  let(:aggregate) { MiniTest::Mock.new }
  let(:counters) { MiniTest::Mock.new }
  let(:global_source) { 'gbl_src' }

  subject do
    Class.new {
      include Librato::Rack::SourcePrefix::Extensions::Collector
      attr_reader :aggregate, :counters

      def initialize(agg, cnt)
        @aggregate = agg
        @counters = cnt
      end
    }.new(aggregate, counters)
  end

  before do
    # Set-up Librato metrics stuff
    Librato.register_tracker(
      Librato::Rack::Tracker.new(
        Librato::Rack::Configuration.new
      )
    )
  end


  describe '#increment' do

    let(:metric) { 'metric' }

    describe 'when there is a global source' do

      before do
        Librato.tracker.config.source = global_source
      end

      describe 'when a custom source is specified' do

        it 'prefixes the custom source with the global source' do
          counters.expect(:increment, nil,
            [metric, { source: "#{global_source}.foo" }]
          )

          subject.increment metric, source: 'foo'
        end
      end

      describe 'when NO custom source is specified' do

        it 'does NOT perform any source prefixing' do
          counters.expect(:increment, nil, [metric, {}])
          subject.increment metric
        end
      end
    end

    describe 'when there is NO global source' do

      describe 'when a custom source is specified' do

        it 'does NOT perform any source prefixing' do
          counters.expect(:increment, nil, [metric, { source: 'foo' }])
          subject.increment metric, source: 'foo'
        end
      end
    end
  end

  describe '#measure' do

    let(:metric) { 'metric' }
    let(:val) { 999 }

    describe 'when there is a global source' do

      before do
        Librato.tracker.config.source = global_source
      end

      describe 'when a custom source is specified' do

        it 'prefixes the custom source with the global source' do
          aggregate.expect(:measure, nil,
            [metric, val, { source: "#{global_source}.foo" }]
          )

          subject.measure metric, val, source: 'foo'
        end
      end

      describe 'when NO custom source is specified' do

        it 'does NOT perform any source prefixing' do
          aggregate.expect(:measure, nil, [metric, val])
          subject.measure metric, val
        end
      end
    end

    describe 'when there is NO global source' do

      describe 'when a custom source is specified' do

        it 'does NOT perform any source prefixing' do
          aggregate.expect(:measure, nil, [metric, val, { source: 'foo' }])
          subject.measure metric, val, source: 'foo'
        end
      end
    end
  end
end
