require("rspec")
require("pg")
require("lines")
require("stations")

DB = PG.connect({:dbname => "public_transit_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM lines *;")
  end
end
