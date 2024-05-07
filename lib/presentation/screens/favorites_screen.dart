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
        title: const Text('Favorites'),
      ),
      body: pokemonProvider.isEmpty
          ? const Center(
              child: Text('No tenes pokemones favoritos'),
            )
          : ListView.builder(
              itemCount: pokemonProvider.length,
              itemBuilder: (context, index) {
                final pokemon = pokemonProvider[index];
                return Column(
                  children: [
                    ListTile(
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          ref
                              .read(pokemonsProvider.notifier)
                              .removeFavoritePokemon(index);
                        },
                      ),
                      title: Text(pokemon.name),
                      subtitle: Text(pokemon.id.toString()),
                    ),
                    Divider(),
                  ],
                );
              },
            ),
    );
  }
}
