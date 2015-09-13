class FecthContentWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  def perform()
    while true
      websites = Website.all
      websites.each do |website|
        website.fetch_type
        sleep Random.rand(9)+1
        website.fetch_content(100)
      end
      sleep 60*60
    end
  end
end
