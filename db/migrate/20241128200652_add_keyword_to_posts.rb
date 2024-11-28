class AddKeywordToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :keyword, :string
  end
end
