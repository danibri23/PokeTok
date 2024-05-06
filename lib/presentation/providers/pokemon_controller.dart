// import 'package:flutter/material.dart';
// import 'package:poketok/core/dependency_injection/locator.dart';
// import 'package:poketok/domain/models/pokemon_model.dart';
// import 'package:poketok/domain/repositories/pokemon_repository.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// class PokemonViewController extends ChangeNotifier {
//   final PokemonRepository _pokemonRepository;

//   bool isLoading = true;
//   Pokemon? _pokemonsData;
//   Pokemon? get pokemonsData => _pokemonsData;

//   PokemonViewController({
//     required PokemonRepository pokemonRepository,
//   }) : _pokemonRepository = pokemonRepository;

//   Future<Pokemon?> getPokemon(int id) async {
//     _pokemonsData = await _pokemonRepository.getPokemon(id);
//     isLoading = false;
//     notifyListeners();
//     return _pokemonsData;
//   }

//   // void savePokemon(PokemonData pokemonData) {
//   //   _pokemonRepository.savePokemon(pokemonData);
//   // }

//   // Color getColorFromPokemonType(String type) {
//   //   return getColorByType(type);
//   // }
// }

// final pokemonViewProvider = ChangeNotifierProvider(
//   (ref) => PokemonViewController(
//     pokemonRepository: locator<PokemonRepository>(),
//   ),
// );
