import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:poketok/core/dependency_injection/locator.dart';
import 'package:poketok/domain/models/pokemon_model.dart';
import 'package:poketok/domain/repositories/pokemon_repository.dart';

part 'pokemon_provider.g.dart';

class PokemonStateNotifier {
  final bool isLoading;
  final List<Pokemon> pokemonList;
  final List<Pokemon> favoritePokemonList;
  final String errorMessage;

  PokemonStateNotifier({
    required this.isLoading,
    required this.pokemonList,
    required this.favoritePokemonList,
    this.errorMessage = '',
  });

  PokemonStateNotifier copyWith({
    bool? isLoading,
    List<Pokemon>? pokemonList,
    List<Pokemon>? favoritePokemonList,
    String? errorMessage,
  }) {
    return PokemonStateNotifier(
      isLoading: isLoading ?? this.isLoading,
      pokemonList: pokemonList ?? this.pokemonList,
      favoritePokemonList: favoritePokemonList ?? this.favoritePokemonList,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

@riverpod
class Pokemons extends _$Pokemons {
  late final PokemonRepository _pokemonRepository;

  @override
  PokemonStateNotifier build() {
    _pokemonRepository = locator<PokemonRepository>();

    return PokemonStateNotifier(
      isLoading: false,
      pokemonList: [],
      favoritePokemonList: [],
    );
  }

  Future<void> getPokemons([int amount = 3]) async {
    if (state.isLoading) return;

    try {
      state = state.copyWith(isLoading: true);

      final List<Pokemon> updatedPokemons = [];

      for (int i = 1; i <= amount; i++) {
        final int page = state.pokemonList.length + i;
        final Pokemon newPokemon = await _pokemonRepository.getPokemons(page);
        updatedPokemons.add(newPokemon);
      }

      state = state.copyWith(
        pokemonList: [...state.pokemonList, ...updatedPokemons],
        isLoading: false,
      );
    } catch (e) {
      // log('Error al obtener páginas adicionales: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  void addFavoritePokemon(Pokemon pokemon) {
    _pokemonRepository.addFavoritePokemon(pokemon);
    state = state.copyWith(
      favoritePokemonList: [...state.favoritePokemonList, pokemon],
    );
  }

  void removeFavoritePokemon(int index) {
    _pokemonRepository.removeFavoritePokemon(index);
    state = state.copyWith(
        favoritePokemonList: state.favoritePokemonList..removeAt(index));
  }

  Future<void> getSavedPokemons() async {
    final List<Pokemon?> savedPokemons =
        await _pokemonRepository.getSavedPokemons();
    state = state.copyWith(
        favoritePokemonList: savedPokemons.whereType<Pokemon>().toList());
  }
}
