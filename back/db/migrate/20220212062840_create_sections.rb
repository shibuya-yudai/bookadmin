class CreateSections < ActiveRecord::Migration[6.1]
  def change
    create_table :sections do |t|
      t.string :title
      t.integer :understand_rate
      t.integer :important_rate
      t.text :memo
      t.references :chapter, null: false, foreign_key: true

      t.timestamps
    end
  end
end
