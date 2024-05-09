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
  final PageController _pageController = PageController();

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

    return Scaffold(
      body: pokemonProvider.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              onPageChanged: (index) {
                if ((pokemonProvider.length - 3) == index) {
                  fetchPokemons();
                }
              },
              itemCount: pokemonProvider.length,
              itemBuilder: (context, index) {
                final pokemon = pokemonProvider[index];
                return Scaffold(
                  backgroundColor: ref
                      .watch(pokemonsProvider.notifier)
                      .getColorsByType(pokemon.types[0].typeName),
                  body: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const PokemonHeader(),
                        PokemonTitle(pokemon: pokemon),
                        PokemonImage(
                          pokemon: pokemon,
                        ),
                        ContainerStats(pokemon: pokemon),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class PokemonHeader extends StatelessWidget {
  const PokemonHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, FavoritesScreen.name);
      },
      child: const Padding(
        padding: EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Mis Favoritos',
              style: TextStyle(
                fontSize: 20,
                letterSpacing: -1.0,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Icon(
              Icons.favorite_border,
              size: 28,
              color: Colors.white,
            ),
          ],
        ),
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
    return Image.network(
      height: MediaQuery.of(context).size.height * 0.40,
      fit: BoxFit.cover,
      pokemon.sprite,
    );
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
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class ContainerStats extends ConsumerWidget {
  const ContainerStats({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
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
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: ref
                                      .watch(pokemonsProvider.notifier)
                                      .getColorsByType(
                                          pokemon.types[0].typeName),
                                  borderRadius: const BorderRadius.all(
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              // Primer contenedor
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: ref
                                      .watch(pokemonsProvider.notifier)
                                      .getColorsByType(
                                          pokemon.types[0].typeName),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Defensa',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                pokemon.stats[2].baseStat.toString(),
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
                  const SizedBox(
                    height: 10,
                  ),
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
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: ref
                                      .watch(pokemonsProvider.notifier)
                                      .getColorsByType(
                                          pokemon.types[0].typeName),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'HP',
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
                                pokemon.stats[0].baseStat.toString(),
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
                          child: Text(
                            'Tipo: ${pokemon.types[0].typeName.substring(0, 1).toUpperCase()}${pokemon.types[0].typeName.substring(1)}',
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.fromLTRB(16, 0, 16, 16), // 16px top padding
              child: ElevatedButton(
                onPressed: () {
                  ref
                      .read(pokemonsProvider.notifier)
                      .addFavoritePokemon(pokemon, context);
                },
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
