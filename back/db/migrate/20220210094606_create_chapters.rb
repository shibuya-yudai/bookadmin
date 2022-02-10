class CreateChapters < ActiveRecord::Migration[6.1]
  def change
    create_table :chapters do |t|
      t.string :title
      t.text :memo
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
