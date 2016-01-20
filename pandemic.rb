require 'sinatra'
require 'yaml'

class City
  attr_reader :name, :color, :x, :y
  attr_accessor :adjCities
  def initialize(name, color, connectedCities, x, y)
    @name = name
    @color = color
    @adjCities = connectedCities
    @x = x
    @y = (y - 15) * 1.7
  end
end

def linkCities(cities)
  cities.each do |name, city|
    adjCityObj = Array.new
    city.adjCities.each do |adjCity|
      adjCityObj << cities[adjCity]
    end
    city.adjCities = adjCityObj
  end
end

citiesData = YAML::load_file(File.join(__dir__, 'cities.yml'))

cities = Hash.new

citiesData.each do |name, properties|
  city = City.new(name, properties['Color'], properties['Connected'], properties['Coords']['x'], properties['Coords']['y'])
  cities[city.name] = city
end

linkCities(cities)

get '/' do
  erb :cities, locals: { cities: cities }
end