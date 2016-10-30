class Controller
    attr_reader :event_hash

    def initialize(event_list, view)
        @event_list = event_list
        @filepath = Time.now.strftime('files/ONBA_%Y-%m-%d')
        @event_hash = {}
        @view = view
    end

    def scrape_onba
        @event_hash = @event_list.onba_scraper
        @view.scraping_done
    end

    def view_hash
        if @event_hash.empty?
            @view.scrape_please
        else
            @event_list.print_hash(@event_hash)
            @view.viewing_done
        end
    end

    def store_csv
        if @event_hash.empty?
            @view.scrape_please
        else
            @event_list.store_into_csv(@event_hash, @filepath)
            @view.csv_done(@filepath)
        end
    end

    def store_json
        if @event_hash.empty?
            @view.scrape_please
        else
            @event_list.store_into_json(@event_hash, @filepath)
            @view.json_done(@filepath)
        end
    end

    def store_xml
        if @event_hash.empty?
            @view.scrape_please
        else
            @event_list.store_into_xml(@event_hash, @filepath)
            @view.xml_done(@filepath)
        end
    end
end
