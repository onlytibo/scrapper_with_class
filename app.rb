require 'bundler'
require 'json'
Bundler.require

require_relative 'lib/app/scrapper'
require_relative 'lib/app/townhall'
# require_relative 'lib/app/save_as'

mairie_christmas = Scrapper.new()

# binding.pry