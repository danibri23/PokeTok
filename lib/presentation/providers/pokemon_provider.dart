import 'dart:developer';

import 'package:flutter/material.dart';
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
    log(state.isLoading.toString());

    try {
      state = state.copyWith(isLoading: true);
      log(state.isLoading.toString());

      final List<Pokemon> updatedPokemons = [];

      for (int i = 1; i <= amount; i++) {
        final int page = state.pokemonList.length + i;
        final Pokemon newPokemon = await _pokemonRepository.getPokemons(page);
        updatedPokemons.add(newPokemon);
        log('Pokemon obtenido: ${newPokemon.name}');
      }

      state = state.copyWith(
        pokemonList: [...state.pokemonList, ...updatedPokemons],
        isLoading: false,
      );
      log(state.isLoading.toString());

      log('Pokemons obtenidos: $updatedPokemons');
    } catch (e) {
      // log('Error al obtener páginas adicionales: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  void addFavoritePokemon(Pokemon pokemon, context) {
    if (state.favoritePokemonList.contains(pokemon)) {
      mostrarSnackbar(
        mensaje: '¡Este Pokémon ya está en tu lista de favoritos!',
        context: context,
      );
    } else {
      _pokemonRepository.addFavoritePokemon(pokemon);
      state = state.copyWith(
        favoritePokemonList: [...state.favoritePokemonList, pokemon],
      );
      mostrarSnackbar(
        mensaje:
            '¡${pokemon.name.toUpperCase()} ha sido añadido a tus favoritos!',
        context: context,
      );
    }
  }

  void mostrarSnackbar({required String mensaje, required context}) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      snackbar,
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

  Color getColorsByType(String type) {
    switch (type) {
      case 'normal':
        return const Color(0xFFA8A77A);
      case 'fire':
        return const Color(0xFFEE8130);
      case 'water':
        return const Color(0xFF6390F0);
      case 'electric':
        return const Color(0xFFF7D02C);
      case 'grass':
        return const Color(0xFF7AC74C);
      case 'ice':
        return const Color(0xFF96D9D6);
      case 'fighting':
        return const Color(0xFFC22E28);
      case 'poison':
        return const Color(0xFFA33EA1);
      case 'ground':
        return const Color(0xFFE2BF65);
      case 'flying':
        return const Color(0xFFA98FF3);
      case 'psychic':
        return const Color(0xFFF95587);
      case 'bug':
        return const Color(0xFFA6B91A);
      case 'rock':
        return const Color(0xFFB6A136);
      case 'ghost':
        return const Color(0xFF735797);
      case 'dragon':
        return const Color(0xFF6F35FC);
      case 'dark':
        return const Color(0xFF705746);
      case 'steel':
        return const Color(0xFFB7B7CE);
      case 'fairy':
        return const Color(0xFFD685AD);
      default:
        return Colors.grey;
    }
  }
}
