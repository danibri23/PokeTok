import 'package:poketok/domain/models/gateway/pokemones_gateway.dart';
import 'package:poketok/domain/models/pokemones_data.dart';

class PokemonUseCase {
  final PokeGateway _pokeGateway;
  PokemonUseCase(this._pokeGateway);
  Future<List<PokeDetail>> getAllPokemons() => _pokeGateway.getPokemons();
}
