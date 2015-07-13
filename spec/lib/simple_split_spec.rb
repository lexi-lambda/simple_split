require 'spec_helper'

describe SimpleSplit::TestSelector do
  let(:data_store) { Hash.new }
  let(:selector) do
    SimpleSplit::TestSelector.new(->(k)    { data_store[k]     },
                                  ->(k, v) { data_store[k] = v })
  end

  it 'uses an existing test if one is already set' do
    data_store[:example_experiment] = :test_a
    _(selector.get_test :example_experiment, [:test_a, :test_b])
      .must_equal :test_a
  end

  it 'must save the chosen test if one does not yet exist' do
    chosen_test = selector.get_test :example_experiment, [:test_a, :test_b]
    _(data_store[:example_experiment]).must_equal chosen_test
  end

  it 'must select tests proportionally to their weights' do
    non_storing_selector =
      SimpleSplit::TestSelector.new(->(_) { nil }, ->(_, _) {})
    tests = [{ test_a: 1.0, test_b: 2.0 }]

    number_of_trials = 1_000
    test_results = number_of_trials.times.map do
      non_storing_selector.get_test(:example_experiment, tests) == :test_a
    end
    test_a_frequency = test_results.count(true).to_f / number_of_trials

    _(test_a_frequency).must_be_close_to 0.3, 0.1
  end
end
