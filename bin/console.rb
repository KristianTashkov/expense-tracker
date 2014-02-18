#!/usr/bin/env ruby

require 'sequel'
require 'awesome_print'
require 'pry'
DB = Sequel.sqlite('./database/test_database.db')

Dir['./{models}/**/*.rb'].each { |file| require file }

Pry.start
