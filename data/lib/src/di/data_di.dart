import 'package:core/core.dart';
import 'package:domain/domain.dart';

import '../../data.dart';

abstract class DataDI {
  static void initDependencies(GetIt locator) {
    locator.registerLazySingleton<Dio>(
      () => locator<DioConfig>().dio,
    );

    locator.registerLazySingleton<DioConfig>(
      () => DioConfig(
        appConfig: locator<AppConfig>(),
      ),
    );

    locator.registerLazySingleton<ErrorHandler>(
      () => ErrorHandler(),
    );

    locator.registerLazySingleton<ApiProvider>(
      () => ApiProvider(
        dio: locator.get<Dio>(),
        errorHandler: locator.get<ErrorHandler>(),
      ),
    );

    locator.registerLazySingleton<CharacterRepository>(
      () => CharacterRepositoryImpl(
        apiProvider: locator.get<ApiProvider>(),
      ),
    );

    locator.registerLazySingleton<FetchCharactersUseCase>(
      () => FetchCharactersUseCase(
        characterRepository: locator.get<CharacterRepository>(),
      ),
    );
  }
}
