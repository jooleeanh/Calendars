require "pry-byebug"
# require_relative 'cities/boston/BSO/parser_app_BSO'
# require_relative 'cities/bordeaux/ONBA/parser_app_BSO'

class Controller
  def initialize
  end

  def go_to_boston
    path_boston = File.dirname(__FILE__)+'/cities/boston/boston_app.rb'
    exec("ruby", path_boston)
  end

  def go_to_bordeaux
    path_bordeaux = File.dirname(__FILE__)+'/cities/bordeaux/bordeaux_app.rb'
    system("ruby #{path_bordeaux}")
  end
end
