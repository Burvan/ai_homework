part of repositories;

abstract interface class CharacterRepository {
  Future<RequestResult> fetchCharacters(QueryPayLoad payload);
}
