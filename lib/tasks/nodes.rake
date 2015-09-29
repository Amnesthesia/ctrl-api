namespace :nodes do
  desc "Sync nodes with Ruter's API"


  task sync: :environment do
    stations = JSON.load(open("http://reisapi.ruter.no/Place/GetStopsRuter"))

    nodes = []

    stations.each do |station|
      coords = GeoUtm::UTM.new "32N", station["X"], station["Y"]
      coords = coords.to_lat_lon

      if station["Name"] =~ /T-bane/
        n = Node.find_or_create_by(name: station["Name"], metro: true)
      else
        n = Node.find_or_create_by(name: station["Name"], metro: false)
      end


      n.y = coords.lon
      n.x = coords.lat
      n.save!

      nodes << n
    end

    puts "Synchronized %d nodes" % nodes.count
  end

end
