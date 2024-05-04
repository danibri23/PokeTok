import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poketok/domain/use_cases/pokemones_use_case.dart';
import 'package:poketok/infraestructure/driven_adapter/api/pokemon_api.dart';

final pokemonProvider = Provider<PokemonUseCase>((ref) {
  return PokemonUseCase(PokemonApi());
});
