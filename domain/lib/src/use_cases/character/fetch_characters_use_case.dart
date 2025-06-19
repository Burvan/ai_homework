part of use_cases;

class FetchCharactersUseCase
    implements FutureUseCase<QueryPayLoad, RequestResult> {
  final CharacterRepository _characterRepository;

  const FetchCharactersUseCase({
    required CharacterRepository characterRepository,
  }) : _characterRepository = characterRepository;

  @override
  Future<RequestResult> execute(QueryPayLoad input) async {
    return _characterRepository.fetchCharacters(input);
  }
}
