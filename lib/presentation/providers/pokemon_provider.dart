// El estado de nuestro StateNotifier debe ser inmutable.
// También podríamos usar paquetes como Freezed para ayudar con la implementación.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poketok/core/dependency_injection/locator.dart';
import 'package:poketok/domain/models/pokemon_model.dart';
import 'package:poketok/domain/repositories/pokemon_repository.dart';

class AsyncPokemonNotifier extends AsyncNotifier<List<Pokemon>> {
  final PokemonRepository _pokemonRepository;

  AsyncPokemonNotifier(this._pokemonRepository);

  int counter = 1;
  Future<List<Pokemon>> fetchPokemon() async {
    final pokemons = await _pokemonRepository.getPokemon(counter);
    counter = counter + 1;
    return [pokemons];
  }

  @override
  Future<List<Pokemon>> build() async {
    return fetchPokemon();
  }
}

// Finalmente, estamos usando StateNotifierProvider para permitir que la
// interfaz de usuario interactúe con nuestra clase TodosNotifier.
final asyncPokemonsProvider =
    AsyncNotifierProvider<AsyncPokemonNotifier, List<Pokemon>>(() {
  return AsyncPokemonNotifier(
    locator<PokemonRepository>(),
  );
});
