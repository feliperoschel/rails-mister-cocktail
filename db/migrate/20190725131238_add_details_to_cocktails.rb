class AddDetailsToCocktails < ActiveRecord::Migration[5.2]
  def change
    add_column :cocktails, :category, :string
    add_column :cocktails, :garnish, :string
    add_column :cocktails, :preparation, :text
  end
end
