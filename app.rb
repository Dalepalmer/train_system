require('sinatra')
require('sinatra/reloader')
also_reload("lib/**/*.rb")
require('./lib/lines')
require('./lib/stops')
require('pg')

DB = PG.connect({:dbname => "public_transit"})

get("/") do
  @lines = Lines.all()
  @stops = Station.all()
  erb(:index)
end

post("lines") do
  name = params.fetch("name")
  direction = params.fetch("direction")
  line_id = params.fetch("line_id").to_i()
  line = Line.new({:name => name, :direction => direction, :id => line_id})
  line.save()
  
