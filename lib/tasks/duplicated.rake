namespace :duplicated do
  desc "TODO"
  task destroy: :environment do
    Content.all.each do |content|
      Content.where(title: content.title).each do |c|
        c.destroy if c.id != content.id
      end
    end
  end
end
