import 'package:poketok/domain/models/pokemon_model.dart';

abstract class PokemonRepository {
  Future<Pokemon> getPokemon(int pokemonId);
}
