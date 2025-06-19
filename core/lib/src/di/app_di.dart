import '../../core.dart';

final GetIt appLocator = GetIt.instance;

abstract class AppDI {
  static void initDependencies(GetIt locator, Flavor flavor) {
    locator.registerSingleton<AppConfig>(
      AppConfig.fromFlavor(flavor),
    );
  }
}
