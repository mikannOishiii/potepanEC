class CreatePotepanSuggests < ActiveRecord::Migration[5.2]
  def change
    create_table :potepan_suggests do |t|
      t.string :keyword, null: false

      t.timestamps
    end
  end
end
