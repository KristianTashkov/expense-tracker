require 'rubygems'
require 'bundler' 
Bundler.require

require './charts/chartkick_chart'
require './charts/google_chart'

module ExpenseTracker
  STARTING_SUBCATEGORY_COUNT = 5
  @@navigation_links = {}
  @@charts = ChartkickCharts.new

  def self.navigation_links
    @@navigation_links
  end

  def self.charts
    @@charts
  end

  class BaseController < Sinatra::Base

    set :views,         File.expand_path("../views",  __FILE__)
    set :public_folder, File.expand_path("../public", __FILE__)

    enable :sessions

    configure :development do
      register Sinatra::Reloader

      DB = Sequel.sqlite "./database/database.db"
    end

    configure :test do
      system "rm database/test_database.db"
      system "sequel -m  database/migrations sqlite://database/test_database.db"
      DB = Sequel.sqlite "database/test_database.db"
    end

    DB.extension(:pagination)
  end

  require_file = -> (file) { require file }
  Dir.glob('./{models,helpers}/**/*.rb').each &require_file
  Dir.glob('./controllers/**/*.rb').each &require_file
end
