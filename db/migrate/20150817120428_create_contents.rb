class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :title
      t.string :link_url
      t.string :thumnail
      t.string :snippet
      t.references :contentable, polymorphic: true

      t.timestamps null: false
    end
  end
end
