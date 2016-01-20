require 'sinatra'
require 'yaml'

class City
  attr_reader :name, :color, :adjCities, :x, :y
  def initialize(name, color, connectedCities, x, y)
    @name = name
    @color = color
    @adjCities = connectedCities
    @x = x
    @y = (y - 15) * 1.7
  end

end

citiesData = YAML::load_file(File.join(__dir__, 'cities.yml'))

cities = Array.new

citiesData.each do |name, properties|
  city = City.new(name, properties['Color'], properties['Connected'], properties['Coords']['x'], properties['Coords']['y'])
  cities << city
end

get '/' do
  erb :cities, locals: { cities: cities }
end