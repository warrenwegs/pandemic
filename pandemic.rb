require 'sinatra'
require 'yaml'

class City
  attr_reader :name, :color, :adjCities
  def initialize(name, color, connectedCities)
    @name = name
    @color = color
    @adjCities = connectedCities
  end

end

citiesData = YAML::load_file(File.join(__dir__, 'cities.yml'))

cities = Array.new

citiesData.each do |name, properties|
  city = City.new(name, properties['Color'], properties['Connected'])
  cities << city
end

get '/' do
  erb :cities, locals: { cities: cities }
end