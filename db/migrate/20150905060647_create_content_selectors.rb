class CreateContentSelectors < ActiveRecord::Migration
  def change
    create_table :content_selectors do |t|
      t.string :selector
      t.string :selector_type
      t.references :website, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
