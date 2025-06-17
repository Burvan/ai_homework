import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import '../bloc/main_page_bloc.dart';
import 'character_list_form.dart';

@RoutePage()
class CharacterListScreen extends StatelessWidget {
  const CharacterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainPageBloc>(
      create: (_) => MainPageBloc(
        fetchCharactersUseCase: appLocator.get<FetchCharactersUseCase>(),
        appRouter: appLocator.get<AppRouter>(),
      ),
      child: const CharacterListForm(),
    );
  }
}
