class CreateContentReferences < ActiveRecord::Migration
  def change
    create_table :content_references do |t|
      t.references :content, index: true, foreign_key: true
      t.references :datarable, polymorphic: true

      t.timestamps null: false
    end
  end
end
