class FecthContentWorker
  include Sidekiq::Worker
  def perform(id)
    website = Website.find_by_id(id)
    if website
      website.fetch_type
      sleep Random.rand(9)+1
      website.fetch_content(5)
      FecthContentWorker.perform_in(5, id+1)
    elsif Website.where('id > ?', id).any?
      FecthContentWorker.perform_in(5, id+1)
    else
      FecthContentWorker.perform_in(60*60, Website.first.id)
    end
  end
end
