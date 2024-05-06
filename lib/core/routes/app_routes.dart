import 'package:flutter/material.dart';
import 'package:poketok/presentation/screens/screens.dart';

class Router {
  static const pokemon = '/pokemon';
  static const favorito = '/favorito';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case pokemon:
        return MaterialPageRoute(builder: (_) => const PokemonScreen());
      case favorito:
        return MaterialPageRoute(builder: (_) => const FavoriteScreen());

      default:
        return null;
    }
  }
}
