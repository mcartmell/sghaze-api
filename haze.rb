require 'json'
require 'open-uri'

class Haze
  AREAS = %w{North South East West Central}
  URL = 'http://app2.nea.gov.sg/anti-pollution-radiation-protection/air-pollution-control/psi/psi-readings-over-the-last-24-hours'
  CACHE_DURATION = 60 * 30

  def call(env)
    ret = cached_psi.to_json
    [200, {'Content-Type' => 'application/json'}, [ret]]
  end

  # Returns PSI reading from cache unless the cache has expired
  def cached_psi
    time_now = Time.now.to_i
    if @cached_psi
      unless ((time_now - @cache_time) > CACHE_DURATION)
        return @cached_psi
      end
    end
    @cached_psi = get_psi
    @cache_time = Time.now.to_i
    @cached_psi
  end

  # Gets the PSI reading by scraping the NEA site
  def get_psi
    psi = {}
    html = open(URL).read
    AREAS.each do |area|
      if m = html.match(%r{<strong>#{area}</strong>.*?<strong[^>]+>(\d+)}m)
        psi[area] = m[1]
      end
    end
    psi
  end
end
