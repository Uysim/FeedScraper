namespace :perform do
  desc "TODO"
  task fetch: :environment do
    Website.all.each do |website|
      website.fetch_type
      sleep Random.rand(9)+1
      website.fetch_content(5)
      sleep 60*60
    end
  end
end
