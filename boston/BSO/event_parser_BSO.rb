require_relative '../../.event_parser'

class EventParserBSO < EventParser
  def initialize(nokodoc, view, event_url)
    super
    @nokodoc = nokodoc.search(".performance-detail")
  end

  def parse_all
    @view.begin_parsing(@attributes[:url])
    parse_title
    parse_date_time
    parse_organisation
    parse_location
    parse_description
    if @attributes[:title].include?("BSO 101")
      @view.parsing_skip(@attributes[:title])
    else
      # TODO: parse_podcast
      parse_performers
      parse_program
    end
  end

  private

  def parse_program
    pieces = []
    @nokodoc.css(".program-notes").css("tbody > tr").each do |piece|
      composer = piece.css("strong").text
      composer_extra = composer.scan(/\(.*\)/).first || ""
      composer = composer.sub(composer_extra, "").strip
      duration = piece.text.sub(composer_extra, "").scan(/\(.*\)/).first || ""
      name = piece.css(".notes-title").text.sub(composer, "").sub(composer_extra, "").sub(duration, "").sub("-", "").strip
      begin
        program_notes_pdf = piece.css(".pdf-link > a")&.attribute("href")&.text
      rescue
        @view.error_empty_field(@attributes[:title], "program_notes_pdf")
      end
      begin
        piece.css(".audio-link > a").attribute("data-url").text
      rescue
        @view.error_empty_field(@attributes[:title], "audio_sample")
      else
        audio_sample = piece.css(".audio-link > a").attribute("data-url").text
      end
      if composer == "Audio Concert Preview"
        @attributes[:full_program_notes] = { info: name, type: composer, program_notes_pdf: program_notes_pdf, audio_sample: audio_sample }
      else
        pieces << { composer: composer, composer_extra:composer_extra, name: name, duration: duration, program_notes_pdf: program_notes_pdf, audio_sample: audio_sample }
      end
    end
    @attributes[:pieces] = pieces
    @view.parsing_success(@attributes[:title], "program")
  end

  def parse_performers
    performers = []
    @nokodoc.css("#performers").css("tbody > tr").each do |performer|
      text = performer.css("td:last-child > a").text.strip.split(", ")
      role = text[1]
      name = text[0].gsub(/\s+/, " ")
      performers << { name: name, role: role }
    end
    @attributes[:performers] = performers
    @view.parsing_success(@attributes[:title], "performers")
  end

  def parse_description
    desc_all = @nokodoc.css(".performance-description > p").map do |paragraph|
      paragraph.text
    end
    if desc_all.size < 1
      text = @nokodoc.css(".performance-description").text
      text = text.gsub("\r\n", " ")
    else
      @attributes[:description] = desc_all[0].gsub("\r\n", " ")
      @attributes[:description_extra] = desc_all[1].gsub("\r\n", " ") if desc_all.size > 1
      @view.parsing_success(@attributes[:title], "description")
    end
  end

  def parse_date_time
    begin
      @nokodoc.css(".performance-information > time").attribute("datetime").text
    rescue
      @view.error_empty_field(@attributes[:title], "datetime")
    else
      datetime = @nokodoc.css(".performance-information > time").attribute("datetime").text
      datetime = datetime.split(" ")
      date = datetime[0].split("/")
      year =  date[2].to_i
      month = date[0].to_i
      day = date[1].to_i
    end

    time_raw = @nokodoc.css(".performance-time").text.strip
    time_raw = time_raw.split(", ")
    weekday = time_raw[0]
    time_twelve = time_raw[1].split(" ")
    time_only = time_twelve[0].split(":")
    hour = time_only[0].to_i
    minute = time_only[1].to_i
    hour += 12 if time_twelve[1] == "PM"
    my_date = Time.new(year, month, day, hour, minute, 0, "-05:00")
    @attributes[:date] = my_date
    @attributes[:weekday] = weekday
    @view.parsing_success(@attributes[:title], "date and time")
  end

  def parse_title
    title_full = @nokodoc.css("p").first.text.split("\r\n")
    @attributes[:title] = title_full[0].strip
    @attributes[:title_extra] = title_full[1].strip if title_full.size > 1
    @view.parsing_success(@attributes[:title], "title")
  end

  def parse_organisation
    @attributes[:organisation] = @nokodoc.css("h2")[0].text.strip
    @view.parsing_success(@attributes[:title], "organisation")
  end

  def parse_location
    begin
      @nokodoc.css(".performance-information").css(".facility").text.strip
    rescue
      @view.error_empty_field(@attributes[:title], "location")
    else
      all_location = @nokodoc.css(".performance-information").css(".facility").text.strip
      all_location = all_location.split("\r\n")
      location = all_location[0].strip unless all_location[0].nil?
      @attributes[:location] = location
      city = all_location[2].strip.sub(/^-/, "").strip unless all_location[2].nil?
      @attributes[:city] = city
      @view.parsing_success(@attributes[:title], "location & city")
    end
  end

end
