require ('rspec')
require ('stops')
require ('pg')
require ('spec_helper')
require ('stations')
require ('lines')

describe(Stop) do
  describe(".all") do
    it("starts with no ids") do
      expect(Stop.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("saves line and station id in stop class") do
      test_station = Station.new({:name => "Dalesvile", :time => "1956-05-01 04:05:06", :id => 1})
      test_station.save()
      test_line = Line.new({:name => "Blue line", :direction => "West-North", :id => 1})
      test_line.save()
      test_stop = Stop.new({:id => nil, :station_id => test_station.id(), :line_id => test_line.id()})
      test_stop.save()
      expect(Stop.all()).to(eq([test_stop]))
    end
  end

  describe("#==") do
   it("is the same line if it has the same name") do
     stop1 = Stop.new({:id => 1, :line_id => 1, :station_id => 1})
     stop2 = Stop.new({:id => 1, :line_id => 1, :station_id => 1})
     expect(stop1).to(eq(stop2))
   end
 end

  # describe("#ids") do
  #   it("gives the ids for station and line") do
  #     test_station = Station.new({:name => "West Vile", :time => '1938-01-01 12:30:00', :id => nil})
  #     test_station.save()
  #     test_line = Line.new({:name => "yellow", :id => nil, :direction => "West"})
  #     test_line.save()
  #     test_stop = Stop.new({:id => 1, :line_id => test_line.id(), :station_id => test_station.id()})
  #     expect(test_station.id()).to(eq(test_station.id()))
  #     expect(test_line.id()).to(eq(test_line.id()))
  #   end

  # describe("#save") do
  #   it("saves line and stations to the stop DB") do
  #     test_stop = Stop.new({:id => @id, :line_id => @lines_id, :station_id => @stations_id})
  #     test_stop.save()
  #     expect(Stop.all()).to(eq([test_stop]))
  #   end
  # end
end
