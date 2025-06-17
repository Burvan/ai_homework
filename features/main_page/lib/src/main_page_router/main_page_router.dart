import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import '../ui/character_list_screen.dart';
import '../ui/detailed_character_screen.dart';

part 'main_page_router.gr.dart';

@AutoRouterConfig()
class MainPageRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[];
}
