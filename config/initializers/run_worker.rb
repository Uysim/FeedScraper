websites = Website.all
websites.each do |website|
  FecthContentWorker.perform_async(website.id)
  sleep 1
end
