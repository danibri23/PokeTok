import 'package:poketok/domain/models/pokemon_model.dart';

abstract class PokemonRepository {
  Future<Pokemon> getPokemons(int pokemonId);
  Future<List<Pokemon?>> getSavedPokemons();
  void addFavoritePokemon(Pokemon pokemon);
  void removeFavoritePokemon(int index);
}
