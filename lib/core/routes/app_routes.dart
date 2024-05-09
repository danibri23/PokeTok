import 'package:flutter/material.dart';
import 'package:poketok/presentation/screens/pokemon_screen.dart';
import 'package:poketok/presentation/screens/screens.dart';

class Router {
  static const pokemon = '/pokemon';
  static const favoritos = '/favoritos';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case pokemon:
        return MaterialPageRoute(builder: (_) => const PokemonScreen());
      case favoritos:
        return MaterialPageRoute(builder: (_) => const FavoritesScreen());

      default:
        return null;
    }
  }
}
