require "pry-byebug"

class Controller
  def get_directories(file = __FILE__)
    Dir.chdir(File.dirname(file) + "/")
    Dir.glob('*').select { |f| File.directory? f }
  end

  def go_to(level, directory, file = __FILE__)
    path = File.dirname(file) + '/' + directory + '/'
    if level == "city"
      path += directory + '_app'
    elsif level == "organization"
      path += 'parser_app_' + directory
    end
    path += '.rb'
    binding.pry
    system("ruby", path)
  end
end
