import 'package:get_it/get_it.dart';
import 'package:poketok/core/services/http_client.dart';
import 'package:poketok/data/repositories/pokemon_repository_implementation.dart';
import 'package:poketok/domain/repositories/pokemon_repository.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<HttpService>(
    () => HttpService(),
  );

  locator.registerLazySingleton<PokemonRepository>(
    () => PokemonRepositoryImplementation(
      httpService: locator<HttpService>(),
    ),
  );
}
