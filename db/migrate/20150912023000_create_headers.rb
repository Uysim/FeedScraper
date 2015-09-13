class CreateHeaders < ActiveRecord::Migration
  def change
    create_table :headers do |t|
      t.string :text
      t.string :name

      t.timestamps null: false
    end
  end
end
