require 'sinatra/base'
require 'sinatra/reloader'
require 'sequel'

module ExpenseTracker
  class BaseController < Sinatra::Base

    set :environment, :development
    set :views,         File.expand_path("../views",  __FILE__)
    set :public_folder, File.expand_path("../public", __FILE__)

    enable :sessions

    configure :development do
      register Sinatra::Reloader

      DB = Sequel.sqlite "./database/database.db"
    end

    DB.extension(:pagination)
  end
end

require_file = -> (file) { require file }
Dir.glob('./{models,helpers}/**/*.rb').each &require_file
Dir.glob('./controllers/**/*.rb').each &require_file

controllers = [ExpenseTracker::MainController, ExpenseTracker::ProfileController]

controllers.each do |controller|
  map (controller::NAMESPACE) { run controller }
end
