require "pry-byebug"

class Controller
  def initialize
  end

  def get_directories
    Dir.chdir(File.dirname(__FILE__) + "/")
    Dir.glob('*').select { |f| File.directory? f }
  end

  def go_to(directory)
    path = File.dirname(__FILE__)+'/'+directory+'/'+directory+'_app.rb'
    system("ruby", path)
  end
end
