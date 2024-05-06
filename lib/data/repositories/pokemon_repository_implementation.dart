import 'dart:developer';

import 'package:poketok/core/services/http_client.dart';
import 'package:poketok/domain/models/pokemon_model.dart';
import 'package:poketok/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImplementation implements PokemonRepository {
  final HttpService _httpService;

  PokemonRepositoryImplementation({
    required HttpService httpService,
  }) : _httpService = httpService;

  @override
  Future<Pokemon> getPokemons(int pokemonId) async {
    final response = await _httpService.dio.get('/pokemon/$pokemonId');
    // log('Response: ${response.data}');
    return Pokemon.fromJson(response.data);
  }
}
