require 'nokogiri'
require 'open-uri'

class Scraper
  def scrape_urls
    pages_urls = []
    # i = 0
    # until i == 2 do
    #   pages_url = "https://www.discogs.com/search/?sort=hot%2Cdesc&style_exact=Techno&ev=gs_ms&page=#{i += 1}"
    #   pages_urls << pages_url
    # end
    pages_url = "https://www.discogs.com/search/?sort=hot%2Cdesc&style_exact=Techno&ev=gs_ms&page=1"
    pagess_url = "https://www.discogs.com/search/?sort=hot%2Cdesc&style_exact=Techno&ev=gs_ms&page=2"
    pages_urls << pages_url
    pages_urls << pagess_url
    tracks_urls = []
    pages_urls.each do |pages_url|
      html = open(pages_url)
      doc = Nokogiri::HTML(html)
      tracks = doc.css('.card>a')
      tracks.each do |track|
        url = track.attribute('href').value
        tracks_urls << url
      end
    end
    scrape_techno(tracks_urls)
  end

  def scrape_techno(tracks_urls)
    tracks_list = []
    tracks_urls.each do |tracks_url|
      url = "https://www.discogs.com/#{tracks_url}"
      html = open(url)
      doc = Nokogiri::HTML(html)
      artist = doc.css('#profile_title>span>span').text.gsub("\n", "").gsub("  ", "")
      title = doc.css('#profile_title>span:nth-child(2n)').text.gsub("\n", "").gsub("  ", "")

      photo_urls = []
      photo_links = doc.css('.image_gallery>a>span:nth-child(2n)>img')
      photo_links.each do |photo_link|
        photo_url = photo_link.attribute('src').value
        photo_urls << "#{photo_url}"
      end

      video_urls = []
      video_links = doc.css('#youtube_player_wrapper').search('#youtube_player_placeholder')
      video_links.each do |video_link|
        video_url = video_link.attribute('data-video-ids').value.split(',')[0]
        video_urls << "https://www.youtube.com/embed/#{video_url}"
      end

      track_info = {
        title: title,
        artist: artist
      }

      if photo_urls[0].nil?
        track_info[:photo_link] = "https://source.unsplash.com/featured/?club"
      else
        track_info[:photo_link] = photo_urls[0]
      end

      if video_urls[0].nil?
        track_info[:video_link] = "https://www.youtube.com/watch?v=u-m1qToX8hU&list=PLk9OF3AXEsI4QrO7H_fZWdyN7JK-wr4tV"
      else
        track_info[:video_link] = video_urls[0]
      end
      tracks_list << track_info
    end
    p tracks_list
  end
end
