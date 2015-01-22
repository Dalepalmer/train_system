class Stop
  attr_reader(:id, :line_id, :station_id)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
    @line_id = attributes.fetch(:line_id)
    @station_id = attributes.fetch(:station_id)
  end

  define_singleton_method(:all) do
    returned_stops = DB.exec("Select * from stops;")
    stops = []
    returned_stops.each() do |stop|
      id = stop.fetch("id").to_i()
      line_id = stop.fetch("line_id").to_i()
      station_id = stop.fetch("station_id").to_i()
      object_stop = Stop.new({:id => id, :line_id => line_id, :station_id => station_id})
      stops.push(object_stop)
    end
    stops
  end


  define_method(:search) do
    returned_lines = DB.exec("SELECT * FROM lines;")
    stops = []
    returned_lines.each() do |line|
      line_id = line.fetch("id")
      stops.push({:line_id => line_id})
    end
    returned_stations = DB.exec("SELECT * FROM stations;")
    returned_stations.each() do |station|
      station_id = station.fetch("id")
      stops.push({:station_id => station_id})
    end
    stops
  end
  define_method(:save) do
    result = DB.exec("INSERT INTO stops (station_id, line_id) VALUES (#{@station_id}, #{@line_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i()

  end

  define_method(:==) do |another_line|
    self.id().==(another_line.id()).&(self.line_id().==(another_line.line_id()))
  end
end




# define_method(:ids) do
#   @stations_id = DB.exec("SELECT id FROM stations;")
#   @lines_id = DB.exec("SELECT id FROM lines;")
# end

#  define_method(:save) do
#    station_result = DB.exec("SELECT id FROM stations;")
#    @stations_id = station_result.first().fetch("id").to_i()
#    line_result = DB.exec("SELECT id from lines;")
#    @lines_id = line_result.first().fetch("id").to_i()
#    results = DB.exec("INSERT INTO stops (line_id, station_id) VALUES (#{@lines_id}, #{@stations_id}) RETURNING id;")
#    @id = result.first().fetch("id").to_i()
# end
