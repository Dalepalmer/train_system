require ('rspec')
require ('stations')
require ('pg')
require ('spec_helper')

# DB = PG.connect({:dbname => 'public_transit_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM stations *;")
  end
end

describe(Station) do
  describe(".all") do
    it("starts off with no train stations") do
      expect(Station.all()).to(eq([]))
    end
  end

  describe('#name') do
    it("line_name = name") do
      test_station = Station.new({:name => "red line", :time => nil, :id => nil})
      expect(test_station.name()).to(eq("red line"))
    end
  end

  describe('#id') do
    it("id = id") do
      test_station = Station.new({:name => nil, :time => nil, :id => 1})
      expect(test_station.id()).to(eq(1))
    end
  end


  describe('#time') do
    it("time = time") do
      test_station = Station.new({:name => nil, :time => '1956-05-01 04:05:06', :id => nil})
      expect(test_station.time()).to(eq('1956-05-01 04:05:06'))
    end
  end

  describe("#save") do
    it("lets you save lines to the database") do
      station = Station.new({:name => "Blue line", :time => '1956-05-01 04:05:06', :id => 1})
      station.save()
      expect(Station.all()).to(eq([station]))
    end
  end

   describe("#==") do
    it("is the same line if it has the same name") do
      station1 = Station.new({:name => "Blue Line", :time => nil, :id => nil})
      station2 = Station.new({:name => "Blue Line", :time => nil, :id => nil})
      expect(station1).to(eq(station2))
    end
  end
end
