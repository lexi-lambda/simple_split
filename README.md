
# simple_split – dead simple A/B testing on Rails [![Gem Version](https://badge.fury.io/rb/simple_split.svg)](http://badge.fury.io/rb/simple_split) [![Code Climate](https://codeclimate.com/github/lexi-lambda/simple_split/badges/gpa.svg)](https://codeclimate.com/github/lexi-lambda/simple_split) [![Build Status](https://travis-ci.org/lexi-lambda/simple_split.svg?branch=master)](https://travis-ci.org/lexi-lambda/simple_split)

The `simple_split` gem provides the absolute simplest possible support for split
testing with Rails that could possibly exist. More feature-complete solutions
like [`split`][split] provide more bells and whistles, but they also do far
more than necessary for simple split testing with good analytics services.

Instead, `simple_split` is bare-bones while still supporting flexible testing.

  - Supports weighted variations
  - Does not require the use of any data store
  - Variations already seen by users are tracked via cookies

## Quick Start

Add `gem 'simple_split'` to your Gemfile, then run `bundle`. That's it. Now you
can start adding split testing support to your project.

All classes that inherit from `ActionView` or `ActionController` have access to
the `ab_test` method. It accepts an experiment name and a list of variations.

```ruby
ab_test 'experiment_name', 'variation_a', 'variation_b', 'variation_c'
```

The result of a call to `ab_test` is a randomly selected variation. If a user
has already seen a particular variation, that variation will always be returned
instead of randomly selecting one.

Weights can be specified using a hash.

```ruby
ab_test 'experiment_name', { 'variation_a' => 1.0, 'variation_b' => 0.2 }
```

## Credit

This was inspired by the [`simple_abs`][simple_abs] gem, which was already quite
stripped-down, but it didn't quite suit my needs.

[split]: https://github.com/splitrb/split
[simple_abs]: https://github.com/n8/simple_abs
