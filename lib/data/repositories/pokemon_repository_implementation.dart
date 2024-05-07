import 'dart:convert';
import 'dart:developer';

import 'package:poketok/core/services/http_client.dart';
import 'package:poketok/core/services/shared_preferences_service.dart';
import 'package:poketok/domain/models/pokemon_model.dart';
import 'package:poketok/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImplementation implements PokemonRepository {
  final HttpService _httpService;
  final SharedPreferencesService _sharedPreferencesService;

  PokemonRepositoryImplementation(
      {required HttpService httpService,
      required SharedPreferencesService sharedPreferencesService})
      : _httpService = httpService,
        _sharedPreferencesService = sharedPreferencesService;

  @override
  Future<Pokemon> getPokemons(int pokemonId) async {
    final response = await _httpService.dio.get('/pokemon/$pokemonId');
    // log('Response: ${response.data}');
    return Pokemon.fromJson(response.data);
  }

  @override
  Future<List<Pokemon?>> getSavedPokemons() async {
    final savedPokemonsString =
        await _sharedPreferencesService.getSavedPokemons();
    final savedPokemonsJson = savedPokemonsString.map((e) => jsonDecode(e));
    return savedPokemonsJson.map((e) => Pokemon.fromLocalJson(e)).toList();
  }

  @override
  void addFavoritePokemon(Pokemon pokemon) async {
    final pokemonJson = pokemon.toJson();
    final pokemonString = jsonEncode(pokemonJson);
    final savedPokemons = await _sharedPreferencesService.getSavedPokemons();
    savedPokemons.add(pokemonString);
    await _sharedPreferencesService.setSavedPokemons(savedPokemons);
  }
}
