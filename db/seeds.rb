Track.destroy_all

scrape = Scraper.new
tracks = scrape.scrape_urls
Track.create_from_scraping(tracks)
