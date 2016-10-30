require "pry-byebug"
require_relative '../controller'
# require_relative 'cities/boston/BSO/parser_app_BSO'
# require_relative 'cities/bordeaux/ONBA/parser_app_BSO'

class BostonController < Controller
  # def go_to_bso
  #   path_bso = File.dirname(__FILE__)+'/BSO/parser_app_BSO.rb'
  #   exec("ruby", path_bso)
  # end
  def get_directories
    super(__FILE__)
  end
  def go_to(level, directories)
    super(level, directories, __FILE__)
  end
end
