class AddDetailsToChapters < ActiveRecord::Migration[6.1]
  def change
    add_column :chapters, :position, :integer
  end
end
