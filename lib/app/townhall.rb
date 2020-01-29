class Townhall
  attr_accessor :url_to_scrap, :name, :email
  @@townhall_ary = []

  def initialize(url_to_scrap, name)

    @url_to_scrap = url_to_scrap
    @name = name
    @email = get_townhall_email

  end

  def get_townhall_email

    townhall_page = Nokogiri::HTML(open(@url_to_scrap)) 
    email = townhall_page.at('td:contains("@")').text.strip 
    @@townhall_ary << self
    puts "add #{@name} to ary"
    return email

  rescue
    puts "#{@name} n'a pas d'e-mail"

  end

  def self.puts_ary
    print @@townhall_ary
  end

  def self.display_townhall(townhall_name)
    puts "#{@@townhall_ary.select {|townhall| townhall.name == townhall_name}}"
  end

  def self.to_json

    @@townhall_ary.map do |townhall|

      townhall.to_hash

    end.to_json

  end

  def to_hash
    {
      name: @name,
      email: @email,
      url: @url_to_scrap
    }  
  end

  def to_json
    File.open("../../db/emails.json","w") do |f|
    f.write(JSON.pretty_generate(@@townhall_ary))
    end
  end

end