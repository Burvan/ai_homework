import 'package:bloc_test/bloc_test.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:main_page/src/bloc/main_page_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navigation/navigation.dart';

class MockFetchCharactersUseCase extends Mock
    implements FetchCharactersUseCase {}

class MockAppRouter extends Mock implements AppRouter {}

void main() {
  late MockFetchCharactersUseCase fetchCharactersUseCase;
  late MockAppRouter appRouter;

  const Character testCharacter = Character(
    id: 1,
    name: 'Rick Sanchez',
    status: Status.alive,
    species: Species.human,
    type: 'Scientist',
    gender: 'Male',
    origin: Location(
      name: 'Earth',
      url: 'https://rickandmortyapi.com/api/location/1',
    ),
    location: Location(
      name: 'Earth',
      url: 'https://rickandmortyapi.com/api/location/20',
    ),
    image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
    episode: <String>['https://rickandmortyapi.com/api/episode/1'],
    url: 'https://rickandmortyapi.com/api/character/1',
    created: '2017-11-04T18:48:46.250Z',
  );

  const RequestResult requestResult = RequestResult(
    info: Info(count: 1, pages: 1, next: null, prev: null),
    characters: <Character>[testCharacter],
  );

  setUpAll(() {
    registerFallbackValue(
      QueryPayLoad(
        page: 1,
        queryParams: <String, dynamic>{},
      ),
    );
  });

  setUp(() {
    fetchCharactersUseCase = MockFetchCharactersUseCase();
    appRouter = MockAppRouter();

    when(() => fetchCharactersUseCase.execute(any()))
        .thenAnswer((_) async => requestResult);
  });

  blocTest<MainPageBloc, MainPageState>(
    'emits loading -> loading with data -> success when Init event is added automatically',
    build: () => MainPageBloc(
      fetchCharactersUseCase: fetchCharactersUseCase,
      appRouter: appRouter,
    ),
    wait: const Duration(milliseconds: 100),
    act: (_) {},
    expect: () => <Matcher>[
      isA<MainPageState>()
          .having((MainPageState s) => s.isPageLoading, 'isPageLoading', true),
      isA<MainPageState>()
          .having((MainPageState s) => s.isPageLoading, 'isPageLoading', true)
          .having(
              (MainPageState s) => s.characters.length, 'characters.length', 1),
      isA<MainPageState>()
          .having((MainPageState s) => s.isPageLoading, 'isPageLoading', false)
          .having(
              (MainPageState s) => s.characters.length, 'characters.length', 1),
    ],
  );
}
