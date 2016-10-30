class ParserEventALF
  attr_reader :attributes

  def initialize(nokodoc, view, event_url)
    @nokodoc = nokodoc.search("#mod_5090843 > .cel1")
    @view = view
    @attributes = {}
    @attributes[:url] = event_url
    @month_fr = %w(zero janvier février mars avril mai juin juillet août septembre octobre novembre décembre)
  end

  def parse_all
    @view.begin_parsing(@attributes[:url])
    parse_date_title
    parse_chapeau
  end

  private

  def parse_date_title
    date_title = @nokodoc.css(".titre > h1").text.strip
    date_title = date_title.split("//")
    date_raw = date_title[0].split(" ")
    day = date_raw[1].to_i
    month = date_raw[2].downcase
    month = @month_fr.index(month)
    year = Time.now.year
    title = date_title[1].strip
    @attributes[:date] = Time.new(year, month, day)
    @attributes[:title] = title
  end

  def parse_chapeau
    # TODO: scan for \d{2}h\d{2} to get times
    time = ""
    location = ""
    location_detail = ""
    info = @nokodoc.css(".chapeau > h3").text
    info = info.split("\r\t\t\t\t").map { |a| a.strip }
    info.each_with_index do |field, index|
      case index
      when 0 then time = field
      when 1 then location = field
      when 2 then location_detail = field
      end
    end
    binding.pry
  end
end
