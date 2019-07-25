# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Dose.destroy_all if Rails.env.development?

Ingredient.destroy_all if Rails.env.development?

Cocktail.destroy_all if Rails.env.development?

puts 'Creating Cocktails, Ingredients and Doses...'

url = 'https://raw.githubusercontent.com/maltyeva/iba-cocktails/master/recipes.json'
user_serialized = open(url).read
user = JSON.parse(user_serialized)

user.each do |recipe|
  cocktail = Cocktail.find_or_create_by!(name: recipe['name'],
                                         category: recipe['category'],
                                         garnish: recipe['garnish'],
                                         preparation: recipe['preparation']
                                         )

  recipe['ingredients'].each do |i|
    if i['label'].nil? ? (name = i['ingredient']) : (name = i['label'])
      unless name.nil?
        ingredient = Ingredient.find_or_create_by!(name: name)
        Dose.find_or_create_by!(
          description: "#{i['amount']}-#{i['unit']}",
          ingredient_id: ingredient.id,
          cocktail_id: cocktail.id
        )
      end
    end
  end
end

url = 'https://raw.githubusercontent.com/maltyeva/iba-cocktails/master/ingredients.json'
user_serialized = open(url).read
user = JSON.parse(user_serialized)

user.each do |i|
  ingredient = Ingredient.find_or_create_by(name: i[0])
  ingredient.update!(
    name: i[0],
    abv: i[1]['abv'],
    taste: i[1]['taste']
  )
end

puts "Created #{Cocktail.count} cocktails!"
puts "Created #{Ingredient.count} ingredients!"
puts "Created #{Dose.count} doses!"

# https://www.thecocktaildb.com/api.php
