# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'

puts "Cleaning DB"
Dose.destroy_all
Cocktail.destroy_all
Ingredient.destroy_all

puts "Creating ingredients"
url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredient_serialized = open(url).read
ingredients = JSON.parse(ingredient_serialized)
ingredients["drinks"].each do |ingredient|
  ingredient = Ingredient.new(name: ingredient["strIngredient1"])
  ingredient.save!
  # Ingredient.create!(name: ingredient["strIngredient1"])
end

puts "Creating Cocktail"
mojito = Cocktail.create!(name: "Mojito")
url = "https://www.culinaryhill.com/wp-content/uploads/2018/08/Mojito-Cocktail-9-Culinary-Hill-660x865.jpg"
mojito.remote_photo_url = url
mojito.save
cosmo = Cocktail.create!(name: "Cosmopolitan")
url = "https://www.creative-culinary.com/wp-content/uploads/cosmopolitan-2.jpg"
cosmo.remote_photo_url = url
cosmo.save
moscow = Cocktail.create!(name: "Moscow Mule")
url = "https://www.pourquoidocteur.fr/media/article/thunbs/uploded_stock-image-72716581-m-2015-1502447159.jpg"
moscow.remote_photo_url = url
moscow.save

puts "Creating Doses"
dose1 = Dose.new
dose2 = Dose.new
dose3 = Dose.new

puts "Adding ingredient to cocktail"
dose1.cocktail = mojito
dose1.ingredient = Ingredient.find_by(name: "Lime juice")
dose1.description = "4cl"
dose2.cocktail = cosmo
dose2.ingredient = Ingredient.find_by(name: "Cranberry juice")
dose2.description = "2cl"
dose3.cocktail = moscow
dose3.ingredient = Ingredient.find_by(name: "Absolut Vodka")
dose3.description = "2cl"

puts "Saving"
dose1.save!
dose2.save!
dose3.save!




puts "Done"
