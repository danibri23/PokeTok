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
  Future<Pokemon> getPokemon(int pokemonId) async {
    final response = await _httpService.dio.get("/pokemon/$pokemonId/");
    final pokemonJson = response.data;
    final pokemon = Pokemon.fromJson(pokemonJson);

    log(pokemon.toJson().toString());
    return pokemon;
  }
}
