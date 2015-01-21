require ('rspec')
require ('lines')
require ('pg')
require ('spec_helper')

# DB = PG.connect({:dbname => 'public_transit_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM lines *;")
    # DB.exec("DELETE FROM stations *;")
  end
end


describe(Line) do
  describe(".all") do
    it("starts off with no train lines") do
      expect(Line.all()).to(eq([]))
    end
  end

  describe('#name') do
    it("line_name = name") do
      test_line = Line.new({:name => "red line", :direction => nil, :id => nil})
      expect(test_line.name()).to(eq("red line"))
    end
  end

  describe('#id') do
    it("id = id") do
      test_line = Line.new({:name => nil, :direction => nil, :id => 1})
      expect(test_line.id()).to(eq(1))
    end
  end


  describe('#direction') do
    it("direction = direction") do
      test_line = Line.new({:name => nil, :direction => "East-West", :id => nil})
      expect(test_line.direction()).to(eq("East-West"))
    end
  end

  describe("#save") do
    it("lets you save lines to the database") do
      line = Line.new({:name => "Blue line", :direction => "West-North", :id => 1})
      line.save()
      expect(Line.all()).to(eq([line]))
    end
  end

   describe("#==") do
    it("is the same line if it has the same name") do
      line1 = Line.new({:name => "Blue Line", :direction => nil, :id => nil})
      line2 = Line.new({:name => "Blue Line", :direction => nil, :id => nil})
      expect(line1).to(eq(line2))
    end
  end
end
