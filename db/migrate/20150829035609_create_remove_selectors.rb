class CreateRemoveSelectors < ActiveRecord::Migration
  def change
    create_table :remove_selectors do |t|
      t.string :selector
      t.string :selector_page
      t.references :website, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
