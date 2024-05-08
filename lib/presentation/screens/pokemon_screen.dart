import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poketok/domain/models/pokemon_model.dart';
import 'package:poketok/presentation/providers/pokemon_provider.dart';
import 'package:poketok/presentation/screens/favorites_screen.dart';

class PokemonScreen extends StatefulHookConsumerWidget {
  const PokemonScreen({super.key});
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

  Future<void> fetchSavedPokemons() async {
    try {
      await ref.read(pokemonsProvider.notifier).getSavedPokemons();
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchPokemons();
      fetchSavedPokemons();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = ref.watch(pokemonsProvider).pokemonList;
    // log(pokemonProvider[7].types[0].typeName);

    return Scaffold(
      backgroundColor: Colors.green,
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
                padding: const EdgeInsets.all(24.0),
                child: PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: pokemonProvider.length,
                  itemBuilder: (context, index) {
                    final pokemon = pokemonProvider[index];
                    return Column(
                      children: [
                        const PokemonHeader(),
                        PokemonTitle(pokemon: pokemon),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            ContainerStats(pokemon: pokemon),
                            Positioned(
                              bottom: 0,
                              child: PokemonImage(pokemon: pokemon),
                            ),
                          ],
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
    );
  }
}

class PokemonHeader extends StatelessWidget {
  const PokemonHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            'Mis Favoritos',
            style: TextStyle(
              fontSize: 20,
              letterSpacing: -1.0,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, FavoritesScreen.name);
            },
            icon: const Icon(Icons.favorite_border,
                size: 28, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class PokemonImage extends StatelessWidget {
  const PokemonImage({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Image.network(pokemon.sprite, height: 200, width: 200);
  }
}

class PokemonTitle extends StatelessWidget {
  const PokemonTitle({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pokemon nro ${pokemon.id}',
            style: const TextStyle(color: Colors.white),
          ),
          Text(
              '${pokemon.name.substring(0, 1).toUpperCase()}${pokemon.name.substring(1)}',
              style: const TextStyle(
                  fontSize: 36,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class ContainerStats extends StatelessWidget {
  const ContainerStats({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: SizedBox(
        height: 260,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 50,
                        width: 140,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              // Primer contenedor
                              child: Container(
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Ataque',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Expanded(
                              // Segundo contenedor
                              child: Text(
                                pokemon.stats[1].baseStat.toString(),
                                style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(width: 6), // Espacio horizontal de 20 unidades
                      Container(
                        height: 50,
                        width: 140,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              // Primer contenedor
                              child: Container(
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Ataque',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Expanded(
                              // Segundo contenedor
                              child: Text(
                                pokemon.stats[1].baseStat.toString(),
                                style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 50,
                        width: 140,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              // Primer contenedor
                              child: Container(
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Ataque',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Expanded(
                              // Segundo contenedor
                              child: Text(
                                pokemon.stats[1].baseStat.toString(),
                                style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 140,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                        child: Center(
                          child: Text('Tipo: ${pokemon.stats[2].baseStat}'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.grey.shade800),
                  minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 50)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                child: const Text(
                  'Yo te elijo!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
