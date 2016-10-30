require_relative "parser_router_ALF"
require_relative "parser_view_ALF"
require "pry-byebug"

class ParserAppALF
  def run
    view = ParserViewALF.new
    calendar_url = "http://www.allezlesfilles.net/PROCHAINEMENT-EN-CONCERT_r2.html"
    ParserRouterALF.new(calendar_url, view).run
  end
end

ParserAppALF.new.run
