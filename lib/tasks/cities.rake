namespace :cities do
  task :load_from_xml => :environment do
    Region.connection.execute('TRUNCATE TABLE regions')
    City.connection.execute('TRUNCATE TABLE cities')

    require 'nokogiri'

    xml = Nokogiri::XML(File.read('db/cities.xml'))
    xml.search('region').each do |region_xml|
      region = Region.create!(:title => region_xml[:name])
      region_xml.search('city').each do |city|
        region.cities.create!(:title => city[:name], :lat => city[:lat], :lon => city[:lon])
      end
    end
  end 
end
