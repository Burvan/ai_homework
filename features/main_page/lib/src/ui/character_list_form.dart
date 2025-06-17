import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../bloc/main_page_bloc.dart';
import 'widgets/charcter_tile.dart';
import 'widgets/filters.dart';

class CharacterListForm extends StatefulWidget {
  const CharacterListForm({super.key});

  @override
  State<CharacterListForm> createState() => _CharacterListFormState();
}

class _CharacterListFormState extends State<CharacterListForm> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final MainPageBloc bloc = context.read<MainPageBloc>();

    _scrollController.addListener(
      () {
        if (!bloc.state.isEndOfList &&
            !bloc.state.isCharactersLoading &&
            _scrollController.offset >=
                _scrollController.position.maxScrollExtent *
                    bloc.state.triggerOffset) {
          bloc.add(const LoadMore());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.main_page_rickAndMorty.watchTr(context)),
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
      ),
      body: BlocBuilder<MainPageBloc, MainPageState>(
        builder: (_, MainPageState state) {
          return state.isPageLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: <Widget>[
                      Filters(
                        selectedStatus: state.statusFilter,
                        selectedSpecies: state.speciesFilter,
                        onStatusChanged: (Status? value) {
                          context.read<MainPageBloc>().add(
                                ChangeStatusFilter(value),
                              );
                        },
                        onSpeciesChanged: (Species? value) {
                          context.read<MainPageBloc>().add(
                                ChangeSpeciesFilter(value),
                              );
                        },
                      ),
                      const SizedBox(height: 14),
                      Expanded(
                        child: () {
                          if (state.hasException) {
                            return Center(
                              child: Text(
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.lightGreen,
                                ),
                                state.exception!.toLocalizedText(),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                          return ListView.builder(
                            controller: _scrollController,
                            itemCount: state.characters.length +
                                (state.isEndOfList ? 0 : 1),
                            itemBuilder: (_, int index) {
                              if (index == state.characters.length) {
                                return const Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: CharacterTile(
                                  character: state.characters[index],
                                  onTap: () => context.read<MainPageBloc>().add(
                                        NavigateToDetails(
                                          character: state.characters[index],
                                        ),
                                      ),
                                ),
                              );
                            },
                          );
                        }(),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
