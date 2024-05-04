import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poketok/config/providers/pokemon_provider.dart';
import 'package:poketok/config/routes/app_routes.dart';
import 'package:poketok/ui/pages/home_page.dart';
import 'package:poketok/ui/pages/pokemon_page.dart';

class CleanArchExampleSepareteUsingFolderApp extends ConsumerWidget {
  const CleanArchExampleSepareteUsingFolderApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      // theme: ligthThemeWeincode,
      onGenerateRoute: (routeSetting) {
        switch (routeSetting.name) {
          case (AppRoutes.pokemon):
            return MaterialPageRoute(
                builder: ((context) => PokemonPage(
                      pokemonDetailList:
                          ref.watch(pokemonProvider).getAllPokemons(),
                    )));
          default:
            return MaterialPageRoute(builder: ((context) => const HomePage()));
        }
      },
    );
  }
}
