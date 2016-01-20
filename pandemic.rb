require 'sinatra'
require 'yaml'

get '/' do
  city = YAML::load_file(File.join(__dir__, 'cities.yml'))

  erb :cities, locals: { cities: city }
end