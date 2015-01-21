class Station

  attr_reader(:name, :id, :time)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
    @time = attributes.fetch(:time)
  end

  define_singleton_method(:all) do
    returned_station = DB.exec("SELECT * FROM stations;")
    stations = []
    returned_station.each() do |station|
      name = station.fetch("name")
      id = station.fetch("id").to_i()
      time = station.fetch("time")
      stations.push(Station.new({:name => name, :id => id, :time => time}))
    end
    stations
  end

  define_method(:save) do
    DB.exec("INSERT INTO stations (name, id, time) VALUES ('#{@name}', #{@id}, '#{@time}')")
    # @id = result.first().fetch("id").to_i()
  end


   define_method(:==) do |another_line|
    self.name().==(another_line.name()).&(self.id().==(another_line.id()))
  end

end
