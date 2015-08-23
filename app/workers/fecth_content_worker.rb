class FecthContentWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  def perform(id)
    website = Website.find(id)
    website.fetch_type
    sleep Random.rand(9)+1
    website.fetch_content
  end
end
