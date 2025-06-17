import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

import '../../main_page.dart';

part 'main_page_event.dart';
part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final FetchCharactersUseCase _fetchCharactersUseCase;
  final AppRouter _appRouter;

  MainPageBloc({
    required FetchCharactersUseCase fetchCharactersUseCase,
    required AppRouter appRouter,
  })  : _fetchCharactersUseCase = fetchCharactersUseCase,
        _appRouter = appRouter,
        super(const MainPageState.initial()) {
    on<Init>(_onInit);
    on<LoadMore>(_onLoadMore);
    on<ChangeStatusFilter>(_onChangeStatusFilter);
    on<ChangeSpeciesFilter>(_onChangeSpeciesFilter);
    on<NavigateToDetails>(_onNavigateToDetails);

    add(const Init());
  }

  Future<void> _onInit(
    Init event,
    Emitter<MainPageState> emit,
  ) async {
    emit(
      state.copyWith(
        isPageLoading: true,
        exception: () => null,
        characters: const <Character>[],
      ),
    );

    try {
      final RequestResult result = await _fetchCharactersUseCase.execute(
        QueryPayLoad(
          page: state.currentPage,
          queryParams: <String, dynamic>{
            'status': state.statusFilter?.name,
            'species': state.speciesFilter?.name,
          },
        ),
      );

      emit(
        state.copyWith(
            characters: result.characters,
            currentPage: result.info.next != null
                ? state.currentPage + 1
                : state.currentPage,
            isEndOfList: result.info.next == null),
      );
    } on AppException catch (e) {
      AppLogger().error(e.toString());
      emit(
        state.copyWith(
          exception: () => e,
          characters: const <Character>[],
        ),
      );
    } finally {
      emit(state.copyWith(isPageLoading: false));
    }
  }

  Future<void> _onLoadMore(
    LoadMore event,
    Emitter<MainPageState> emit,
  ) async {
    emit(state.copyWith(isCharactersLoading: true));

    try {
      final RequestResult result = await _fetchCharactersUseCase.execute(
        QueryPayLoad(
          page: state.currentPage,
          queryParams: <String, dynamic>{
            AppConstants.statusQueryParameter: state.statusFilter?.name,
            AppConstants.speciesQueryParameter: state.speciesFilter?.name,
          },
        ),
      );

      emit(
        state.copyWith(
          characters: state.characters + result.characters,
          currentPage: result.info.next != null
              ? state.currentPage + 1
              : state.currentPage,
          isEndOfList: result.info.next == null,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          exception: () => e,
        ),
      );
    } finally {
      emit(state.copyWith(isCharactersLoading: false));
    }
  }

  Future<void> _onChangeStatusFilter(
    ChangeStatusFilter event,
    Emitter<MainPageState> emit,
  ) async {
    emit(
      state.copyWith(
        statusFilter: () => event.status,
        currentPage: 1,
        characters: <Character>[],
        isEndOfList: false,
      ),
    );
    add(const Init());
  }

  Future<void> _onChangeSpeciesFilter(
    ChangeSpeciesFilter event,
    Emitter<MainPageState> emit,
  ) async {
    emit(
      state.copyWith(
        speciesFilter: () => event.species,
        currentPage: 1,
        characters: <Character>[],
        isEndOfList: false,
      ),
    );
    add(const Init());
  }

  Future<void> _onNavigateToDetails(
    NavigateToDetails event,
    Emitter<MainPageState> emit,
  ) async {
    await _appRouter.push(
      DetailedCharacterRoute(
        character: event.character,
      ),
    );
  }
}
