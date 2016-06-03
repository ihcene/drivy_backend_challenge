# Drivy Backend Challenge

 Looking for a job? Check out our [open positions](https://en.drivy.com/jobs).

## Guidelines

- clone this repo (do **not** fork it)
- solve the levels in ascending order
- commit your code at the end of each level
- once you are done, ping someone from drivy (ideally via our jobs page)

You can have a look at the higher levels, but please do the **simplest thing** that could work for the level you're currently solving.

Disclaimer: the levels become more complex over time, so you will probably have to re-use some code and adapt it to the new requirements.
A good way to solve this is by using OOP and adding new layers of abstraction only when they become necessary.
Don't hesitate to write [shameless code](http://red-badger.com/blog/2014/08/20/i-spent-3-days-with-sandi-metz-heres-what-i-learned/) at first, and then refactor it in the next levels.

For higher levels we are interested in seeing code that is:
- clean
- extensible
- robust (don't overlook edge cases, use exceptions where needed, ...)


## Things to know

- all prices are stored as integers (in cents)


# Solution

## How to run

    $ cd backend
    $ bundle install

    $ cd level(1-6)
    $ bundle exec ruby main.js


## Description

- Dependencies are defined on a commun Gemfile located at the root of levels folder
- ActiveSupport is mainly used to autoload files, ActiveModel is used for model serialization
- To reduce duplication, each level requires code from the previous levels and extend it (cf. support.rb files and model/rental.rb files)
