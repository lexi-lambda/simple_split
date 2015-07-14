
# simple_split – dead simple A/B testing on Rails [![Gem Version](https://badge.fury.io/rb/simple_split.svg)](http://badge.fury.io/rb/simple_split) [![Code Climate](https://codeclimate.com/github/lexi-lambda/simple_split/badges/gpa.svg)](https://codeclimate.com/github/lexi-lambda/simple_split) [![Build Status](https://travis-ci.org/lexi-lambda/simple_split.svg?branch=master)](https://travis-ci.org/lexi-lambda/simple_split)

The `simple_split` gem provides the absolute simplest possible interface for
split testing via Rails while still providing an expressive set of tools for
writing and maintaining experiments. More traditional solutions like
[`split`][split] provide more bells and whistles, but they also do far
more than is necessary for simple split testing via good analytics services.

Instead, `simple_split` is bare bones, but it still supports flexible testing.

  - Includes optionally-weighted variations
  - Does not require the use of any data store
  - Variations already seen by users are tracked via cookies

## Quick Start

Add `gem 'simple_split'` to your Gemfile, then run `bundle`. That's it. Now you
can start writing A/B tests for your project.

All classes that inherit from `ActionView` or `ActionController` have access to
the `ab_test` method. It accepts an experiment name and a list of variations.

```ruby
ab_test 'experiment_name', 'variation_a', 'variation_b', 'variation_c'
```

The result of a call to `ab_test` is a randomly selected variation. If a user
has already seen a particular variation, that result will always be returned
instead of picking a new one.

Variations can be weighted by using a hash, where the keys are variation labels
and the values are numeric weights. If no weight is provided, the default is to
use `1.0`.

```ruby
ab_test 'experiment_name', { 'variation_a' => 1.0, 'variation_b' => 0.2 }
```

## Credit

This was inspired by the [`simple_abs`][simple_abs] gem, which also provides a
stripped-down interface. However, it still persists information to a database,
and it does not include support for weighted variations.

[split]: https://github.com/splitrb/split
[simple_abs]: https://github.com/n8/simple_abs
