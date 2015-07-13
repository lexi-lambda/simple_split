require 'active_support/all'
require 'weighted_randomizer'

module SimpleSplit
  class TestSelector
    def initialize(get_test, set_test)
      @get_test = get_test
      @set_test = set_test
    end

    def get_test(name, tests)
      get_existing_test_value(name, tests) || assign_test(name, tests)
    end

    private

    def get_existing_test_value(name, tests)
      test_value = @get_test.call name
      test_value if test_value.present? && tests.include?(test_value)
    end

    def assign_test(name, tests)
      selected_test = select_test tests
      @set_test.call name, selected_test
      selected_test
    end

    def select_test(tests)
      WeightedRandomizer.new(normalize_tests tests).sample
    end

    def normalize_tests(tests)
      tests.flat_map do |test|
        if test.is_a? Hash
          test
        elsif test.is_a? Array
          normalize_tests(test)
        else
          { test => 1.0 }
        end.to_a
      end.to_h
    end
  end

  module TestHelper
    def ab_test(name, *tests)
      TestSelector.new(->(k)    { cookies[k]     },
                       ->(k, v) { cookies[k] = v })
        .get_test name, tests
    end
  end

  if defined? Rails
    class Railtie < Rails::Railtie
      initializer 'simple_split.initialize' do
        ActionController::Base.send :include, SimpleSplit::TestHelper
        ActionView::Base.send :include, SimpleSplit::TestHelper
      end
    end
  end
end
