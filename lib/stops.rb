class Stop
  attr_reader(:id, :line_id, :station_id)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
    @line_id = attributes.fetch(:line_id)
    @station_id = attributes.fetch(:station_id)
  end

  define_singleton_method(:all) do
    returned_stops = DB.exec("SELECT * FROM stops;")
    stops = []
    returned_stops.each() do |stop|
      id = stop.fetch("id")
      line_id = stop.fetch("line id")
      station_id = stop.fetch("station id")
      stops.push(Stop.new({:id => id, :line_id => line_id, :station_id => station_id}))
    end
    stops
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
end
