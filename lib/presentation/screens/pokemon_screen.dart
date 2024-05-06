import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poketok/presentation/providers/pokemon_provider.dart';

class PokemonScreen extends StatefulHookConsumerWidget {
  const PokemonScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends ConsumerState<PokemonScreen> {
  @override
  initState() {
    super.initState();

    ref.read(asyncPokemonsProvider.notifier).build();
  }

  @override
  Widget build(BuildContext context) {
    final pokemons = ref.watch(asyncPokemonsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pokemon',
        ),
      ),
      body: Center(
        child: PageView.builder(
          scrollDirection: Axis.vertical,
          onPageChanged: (value) {
            ref.read(asyncPokemonsProvider.notifier).fetchPokemon();
          },
          itemBuilder: (context, index) {
            return pokemons.when(
              data: (pokemon) => Center(
                child: Text(
                  pokemon[index].name,
                ),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, _) => Center(
                child: Text(
                  error.toString(),
                ),
              ),
            );
          },
        ),
      ),
    );

    // return pokemons.when(
    //   data: (pokemon) => Scaffold(
    //     appBar: AppBar(
    //       title: Text(
    //         pokemon.last.name,
    //       ),
    //     ),
    //   ),
    //   loading: () => const Scaffold(
    //     body: Center(
    //       child: CircularProgressIndicator(),
    //     ),
    //   ),
    //   error: (error, _) => Scaffold(
    //     body: Center(
    //       child: Text(
    //         error.toString(),
    //       ),
    //     ),
    //   ),
    // );
  }
}
