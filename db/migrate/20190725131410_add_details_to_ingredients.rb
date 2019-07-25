class AddDetailsToIngredients < ActiveRecord::Migration[5.2]
  def change
    add_column :ingredients, :abv, :integer, default: 0
    add_column :ingredients, :taste, :string
  end
end
