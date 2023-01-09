require_relative 'lib/database_connection'
require_relative 'lib/recipe_repository'

DatabaseConnection.connect('recipes_directory')

recipe_repository = RecipeRepository.new

repo = recipe_repository.find(1)

p repo.name