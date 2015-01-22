require("rspec")
require("pg")
require("lines")
require("stations")
require("stops")
require("pry")

DB = PG.connect({:dbname => "public_transit_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM lines *;")
    DB.exec("DELETE FROM stations *;")
    DB.exec("DELETE FROM stops *;")
  end
end
