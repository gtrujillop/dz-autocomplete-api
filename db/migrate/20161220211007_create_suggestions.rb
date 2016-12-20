class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.string :name
      t.float :price
      t.string :image
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
