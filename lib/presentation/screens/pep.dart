import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poketok/domain/models/pokemon_model.dart';
import 'package:poketok/presentation/providers/pokemon_provider.dart';

class PokemonScreen extends StatefulHookConsumerWidget {
  const PokemonScreen({Key? key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends ConsumerState<PokemonScreen> {
  Future<void> fetchPokemons() async {
    try {
      await ref.read(pokemonsProvider.notifier).getPokemons();
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      fetchPokemons();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = ref.watch(pokemonsProvider).pokemonList;

    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: const Text('Pokemons'),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Navigator.of(context).pushNamed(FavoritesScreen.name);
            },
          ),
        ],
      ),
      body: pokemonProvider.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
                  fetchPokemons();
                }
                return true;
              },
              child: Padding(
                padding: EdgeInsets.all(
                    24.0), // Puedes ajustar el valor según sea necesario
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: pokemonProvider.length,
                  itemBuilder: (context, index) {
                    final pokemon = pokemonProvider[index];
                    return Column(
                      children: [
                        PokemonTitle(pokemon: pokemon),
                        PokemonImage(pokemon: pokemon),
                        ElevatedButton(
                          onPressed: () {
                            ref.read(pokemonsProvider.notifier);
                          },
                          child: Text(
                            'Add to favorites',
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
    );
  }
}

class PokemonImage extends StatelessWidget {
  const PokemonImage({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Image.network(pokemon.sprite);
  }
}

class PokemonTitle extends StatelessWidget {
  const PokemonTitle({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(pokemon.name),
    );
  }
}
