import 'package:poketok/domain/models/pokemones_data.dart';

abstract class PokeGateway {
  Future<List<PokeDetail>> getPokemons();
}
