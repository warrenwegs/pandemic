require 'sinatra'
require 'yaml'

class City
  attr_reader :name, :color, :x, :y
  attr_accessor :adjCities, :diseases
  def initialize(name, color, connectedCities, x, y)
    @name = name
    @color = color.to_sym
    @adjCities = connectedCities
    @x = x
    @y = (y - 15) * 1.7
    @diseases = { red: 0, blue: 0, gold: 0, black: 0 }
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

def gameInitialize(cities)

  def addCubes(cities, city, color, qty)
    cities[city.name].diseases[color] += qty
  end

  diseases = cities.keys
  diseases.shuffle!
  discard = Array.new
  1.upto(3) do |x|
    draw = diseases.shift
    addCubes(cities, cities[draw], cities[draw].color.to_sym.downcase, x)
    discard << draw
    draw = diseases.shift
    addCubes(cities, cities[draw], cities[draw].color.to_sym.downcase, x)
    discard << draw
    draw = diseases.shift
    addCubes(cities, cities[draw], cities[draw].color.to_sym.downcase, x)
    discard << draw
  end
end

citiesData = YAML::load_file(File.join(__dir__, 'cities.yml'))

cities = Hash.new

citiesData.each do |name, properties|
  city = City.new(name, properties['Color'], properties['Connected'], properties['Coords']['x'], properties['Coords']['y'])
  cities[city.name] = city
end

linkCities(cities)

gameInitialize(cities)

get '/' do
  erb :cities, locals: { cities: cities }
end