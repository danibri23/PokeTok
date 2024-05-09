import 'package:get_it/get_it.dart';
import 'package:poketok/core/services/http_client.dart';
import 'package:poketok/core/services/shared_preferences_service.dart';
import 'package:poketok/data/repositories/pokemon_repository_implementation.dart';
import 'package:poketok/domain/repositories/pokemon_repository.dart';
import 'package:stacked_services/stacked_services.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<HttpService>(
    () => HttpService(),
  );
  locator.registerLazySingleton<SharedPreferencesService>(
    () => SharedPreferencesService(),
  );

  locator.registerLazySingleton<SnackbarService>(
    () => SnackbarService(),
  );

  locator.registerLazySingleton<PokemonRepository>(
    () => PokemonRepositoryImplementation(
      httpService: locator<HttpService>(),
      sharedPreferencesService: locator<SharedPreferencesService>(),
    ),
  );
}
