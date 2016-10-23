require 'open-uri'
require 'nokogiri'
require 'pry-byebug'

class TnbaParser
  def initialize
    @events_url = "season_2016_2017.html"
    @event_url = "tnba_event.html"
    @events = Nokogiri::HTML(File.open(@events_url), nil, 'utf-8')
    @event = Nokogiri::HTML(File.open(@event_url), nil, 'utf-8')
    @links = []
    @attributes = {}
  end

  CSS = {
    link: ".views-field-title .field-content > a",
    genre: ".field-name-field-typologie-evt",
    date_range: ".field-name-field-date-court",
    title: ".field-name-title-field",
    sous_titre: ".field-name-field-sous-titre",
    infos_pratique: ".field-name-field-infos-pratiques .field-item",
    event_info: ".field-type-text-with-summary .field-item",
    crew_info: ".field-name-field-colonne .field-items",
    production_info: ".field-name-field-bloc-texte .field-item > p",
    press_review: ".field-name-field-la-presse-en-parle .file > a",
    attachment: ".field-name-field-documents .file > a"
  }

  def parse_events
    @events.search('#block-views-accueil-programmation')
        .css('.view-content > div').each do |event|
      @links << event.css(CSS[:link]).attribute("href").text
    end
  end

  def parse_event
    event = @event.search('.content .clearfix')
    # p event.css(CSS[:date_range]).text.strip
    @attributes[:genre] = event.css(CSS[:genre]).text.strip
    @attributes[:title] = event.css(CSS[:title]).text.strip
    @attributes[:date_range] = event.css(CSS[:date_range]).text.strip
    parse_event_info
    parse_performance_info
    parse_crew_info
    parse_production_info
    @attributes[:press_review] = event.css(CSS[:press_review]).attribute("href").text
    @attributes[:attachment] = event.css(CSS[:attachment]).attribute("href").text
    binding.pry
  end

  def parse_event_info
    event = @event.search('.content .clearfix').css(CSS[:infos_pratique])
    @attributes[:performance_times] = event.css("p span span[style='color:#000;']").text
    extra1 = event.css('p')[0].text.strip
    extra2 = event.css('p span[style="color:#E5007D;"]')[0].text
    info = event.text.gsub(@attributes[:performance_times], "").gsub(extra1, "").gsub(extra2, "").strip.split(" – ")
    @attributes[:organization] = info[0]
    @attributes[:location] = info[1]
    @attributes[:duration] = info[2]
    @attributes[:circumstance] = extra1
  end

  def parse_performance_info
    event = @event.search('.content .clearfix').css(CSS[:event_info])
    @attributes[:description_header] = event.css("h1 > span").text.strip
    @attributes[:description_content] = event.css("p")[0].text.strip
  end

  def parse_crew_info
    event = @event.search('.content .clearfix').css(CSS[:crew_info]).css(".rtecenter")
    crew = {}
    event.each_with_index do |column, index|
      if index == 0
        names = column.css("strong").text.split("\n")
        @attributes[:artists] = names
      else
        jobs = column.text
        names_by_job = column.css("strong").map { |name| name.text }
        names_by_job.each { |e| jobs = jobs.gsub(e, "") }
        jobs = jobs.split("\n")
        jobs.each_with_index do |job, i|
          crew[job] = names_by_job[i].split("\n")
        end
        @attributes[:crew] = crew
      end
    end
  end

  def parse_production_info
    event = @event.search('.content .clearfix')
    all = event.css(CSS[:production_info])[1]
    bold_text = []
    all.css('strong').each do |content|
      bold_text << content.text.strip
    end
    normal_text = all.text
    bold_text.each { |e| normal_text = normal_text.gsub(e, "") }
    info = {}
    normal_text.split("\n").each_with_index do |line, index|
      info[line] = bold_text[index]
    end
    @attributes[:production_info] = info
  end
end
