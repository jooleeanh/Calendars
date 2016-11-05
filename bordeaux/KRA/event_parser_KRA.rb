require_relative '../../.event_parser'

class EventParserKRA < EventParser
  # INHERITING READERS :attributes

  def initialize(nokodoc, view, event_url) # INHERITING/OVERRIDING
    super
    @nokodoc = @nokodoc # refine css search
  end

  def parse_all # NEW DEFINITION
    # TODO: write scraping code
    @view.begin_parsing(@attributes[:url])
    parse_title
    parse_date
    parse_cover_link
    parse_price
    parse_genre_origine
    parse_location
    parse_extra_link
    parse_content
    parse_video_urls
  end

  private

  def parse_title
    begin
      @attributes[:title] = @nokodoc.css('.entry-title').text
      @view.parsing_success(@attributes[:title], "title")
    rescue
      @view.error_empty_field(@attributes[:title], "title")
    end
  end

  def parse_date
    begin
      datetime = @nokodoc.css('.entry-date').attribute('datetime').text.split(/\+|-|T|:/)
      @attributes[:datetime] = Time.new(
      datetime[0],
      datetime[1],
      datetime[2],
      datetime[3],
      datetime[4],
      datetime[5],
      "+" + datetime[6] + ":" + datetime[7],
      )
      @view.parsing_success(@attributes[:title], "datetime")
    rescue
      @view.error_empty_field(@attributes[:title], "datetime")
    end
  end

  def parse_cover_link
    begin
      @attributes[:cover_link] = @nokodoc.css('.top-thumbnail > img').attribute("src").text
      @view.parsing_success(@attributes[:title], "cover_link")
    rescue
      @view.error_empty_field(@attributes[:title], "cover_link")
    end
  end

  def parse_price
    begin
      prices = @nokodoc.css('.subtitle > a:last-of-type').text.scan(/[\d{1,3}\/]+€/).first.split("/")
      @attributes[:price_max] = prices.last.to_i
      @attributes[:price_min] = prices.first.to_i
      @view.parsing_success(@attributes[:title], 'price')
    rescue
      @view.error_empty_field(@attributes[:title], 'price')
    end
  end

  def parse_genre_origine
    begin
      genre_origine = @nokodoc.css('.entry-content').text.scan(/Genre \/ Origine : .+\s{3,}/).first.strip.split(/ \/ | : /)
      @attributes[genre_origine[0].to_sym] = genre_origine[2]
      @attributes[genre_origine[1].to_sym] = genre_origine[3]
      @view.parsing_success(@attributes[:title], "genre_origine")
    rescue
      @view.error_empty_field(@attributes[:title], "genre_origine")
    end
  end

  def parse_location
    begin
      @attributes[:custom_location] = @nokodoc.css('.entry-content').text.scan(/Lieu : .*\s{2,}/).first.strip.gsub(/Lieu : /,"")
      @view.parsing_success(@attributes[:title], 'custom_location')
    rescue
      @view.error_empty_field(@attributes[:title], 'custom_location')
    end
  end

  def parse_extra_link
    begin
      @attributes[:extra_link] = @nokodoc.css('.entry-content a').attribute("href").text
      @view.parsing_success(@attributes[:title], "extra_link")
    rescue
      @view.error_empty_field(@attributes[:title], "extra_link")
    end
  end

  def parse_content
    begin
      content = @nokodoc.css('.entry-content').text
      content = content.gsub(/Genre \/ Origine : .+/, "").gsub(/Lieu : .*[\n]*/, "")
      content = content.strip.gsub(/\\ n/, "").gsub(/\s{3,}/, "\n")
    rescue
      @view.error_empty_field(@attributes[:title], "content")
    else
      begin
        remove1 = @nokodoc.css('.entry-content p script').text
        remove2 = @nokodoc.css('.entry-content p script+a').text
        content = content.gsub(remove1, "")
        content = content.gsub(remove2, "")
      end
      @attributes[:content] = content
      @view.parsing_success(@attributes[:title], "content")
    end
  end

  def parse_video_urls
    video_urls = []
    begin
      @nokodoc.css('.entry-content iframe').each do |iframe|
        video_urls << iframe.attribute("src").text
      end
      @attributes[:video_urls] = video_urls
      @view.parsing_success(@attributes[:title], "video_urls")
    rescue
      @view.error_empty_field(@attributes[:title], "video_urls")
    end
  end

end
