part of repositories;

final class CharacterRepositoryImpl implements CharacterRepository {
  final ApiProvider _apiProvider;

  CharacterRepositoryImpl({
    required ApiProvider apiProvider,
  }) : _apiProvider = apiProvider;

  @override
  Future<RequestResult> fetchCharacters(QueryPayLoad query) async {
    final RequestResultEntity result =
        await _apiProvider.fetchCharacters(query);

    return RequestResult(
      characters: result.characters
          .map((CharacterEntity entity) =>
              MapperFactory.characterMapper.fromEntity(entity))
          .toList(),
      info: MapperFactory.infoMapper.fromEntity(result.info),
    );
  }
}
