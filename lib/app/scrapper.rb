class Scrapper

  @@all_cities = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))

  def initialize
    @list_cities = @@all_cities.xpath('//a[contains(@href,"./95/")]')
    
    @list_cities.map do |townhall|
      url_to_scrap = "http://annuaire-des-mairies.com/" + "#{townhall['href'].delete_prefix!("./")}" # url de la ville
      name = townhall.text
      
      Townhall.new(url_to_scrap, name)
      Townhall.to_json
    end
  end

end
