import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poketok/presentation/providers/pokemon_provider.dart';

class FavoritesScreen extends ConsumerWidget {
  static const String name = '/favoritos';
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonProvider = ref.watch(pokemonsProvider).favoritePokemonList;
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Spacer(),
            Text(
              'Mis Favoritos',
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
      body: pokemonProvider.isEmpty
          ? const Center(
              child: Text('No tenes pokemones favoritos'),
            )
          : Padding(
              padding: const EdgeInsets.all(8),
              child: ListView.builder(
                itemCount: pokemonProvider.length,
                itemBuilder: (context, index) {
                  final pokemon = pokemonProvider[index];
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        height: 100,
                        decoration: BoxDecoration(
                          color: ref
                              .watch(pokemonsProvider.notifier)
                              .getColorsByType(pokemon.types[0].typeName),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 5, bottom: 5),
                              child: Image.network(
                                pokemon.sprite,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                textAlign: TextAlign.center,
                                '${pokemon.name.substring(0, 1).toUpperCase()}${pokemon.name.substring(1)}',
                                style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: IconButton(
                                icon: const Icon(Icons.delete_outline_outlined,
                                    color: Colors.white, size: 30),
                                onPressed: () {
                                  ref
                                      .read(pokemonsProvider.notifier)
                                      .removeFavoritePokemon(index);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
    );
  }
}
