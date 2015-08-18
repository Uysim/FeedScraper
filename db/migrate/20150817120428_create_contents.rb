class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :title
      t.string :link_url

      t.timestamps null: false
    end
  end
end
