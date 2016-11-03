require_relative '../../.view_parser'
require 'colorize'

class ViewParserKRA < ViewParser
  # INHERITING
  # - initialize
  # - greeting
  # - display_choices(urls_empty_bool, events_empty_bool)
  # - display_hash(hash)
  # - display_array(array)
  # - display_hash_formatted(hash)
  # - scraping_done
  # - viewing_done
  # - json_done(filepath)
  # - scrape_please
  # - begin_parsing(event_url)
  # - parsing_skip(title)
  # - error_empty_field(title, field)
  # - parsing_success(title, field)
  # - scraping_success(link)
end
