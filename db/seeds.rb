Track.destroy_all

scrape = Scraper.new
p "scrape=#{scrape}"
tracks = scrape.scrape_urls
p "tracks=#{tracks}"
Track.create_from_scraping(tracks)
