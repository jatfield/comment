class CreateFontSizes < ActiveRecord::Migration[5.0]
  def change
    create_table :font_sizes do |t|
      t.string :name
      t.integer :value

      t.timestamps
    end
  end
end
