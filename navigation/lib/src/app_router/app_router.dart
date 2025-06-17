import 'package:auto_route/auto_route.dart';
import 'package:main_page/main_page.dart';

class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(
          page: CharacterListRoute.page,
          initial: true,
        ),
        AutoRoute(page: DetailedCharacterRoute.page),
      ];
}
