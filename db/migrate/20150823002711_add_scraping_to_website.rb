class AddScrapingToWebsite < ActiveRecord::Migration
  def change
    add_column :websites, :scraping, :boolean, default: :false
  end
end
