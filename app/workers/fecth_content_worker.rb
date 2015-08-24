class FecthContentWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  def perform()
    websites = Website.all
    websites.each do |website|
      website.fetch_type
      sleep Random.rand(9)+1
      website.fetch_content
    end
  end
end
