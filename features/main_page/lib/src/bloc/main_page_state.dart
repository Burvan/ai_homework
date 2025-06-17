part of 'main_page_bloc.dart';

final class MainPageState {
  final bool isPageLoading;
  final bool isCharactersLoading;
  final List<Character> characters;
  final int currentPage;
  final bool isEndOfList;
  final Status? statusFilter;
  final Species? speciesFilter;
  final AppException? exception;

  const MainPageState({
    required this.isPageLoading,
    required this.isCharactersLoading,
    required this.characters,
    required this.currentPage,
    required this.isEndOfList,
    required this.statusFilter,
    required this.speciesFilter,
    required this.exception,
  });

  const MainPageState.initial()
      : isPageLoading = false,
        isCharactersLoading = false,
        characters = const <Character>[],
        currentPage = 1,
        isEndOfList = false,
        statusFilter = null,
        speciesFilter = null,
        exception = null;

  bool get hasException => exception != null;

  double get triggerOffset =>
      1 - (AppConstants.itemsPerLoad / characters.length);

  MainPageState copyWith({
    bool? isPageLoading,
    bool? isCharactersLoading,
    List<Character>? characters,
    int? currentPage,
    bool? isEndOfList,
    Status? Function()? statusFilter,
    Species? Function()? speciesFilter,
    AppException? Function()? exception,
  }) {
    return MainPageState(
      isPageLoading: isPageLoading ?? this.isPageLoading,
      isCharactersLoading: isCharactersLoading ?? this.isCharactersLoading,
      characters: characters ?? this.characters,
      currentPage: currentPage ?? this.currentPage,
      isEndOfList: isEndOfList ?? this.isEndOfList,
      statusFilter: statusFilter != null ? statusFilter() : this.statusFilter,
      speciesFilter:
          speciesFilter != null ? speciesFilter() : this.speciesFilter,
      exception: exception != null ? exception() : this.exception,
    );
  }
}
