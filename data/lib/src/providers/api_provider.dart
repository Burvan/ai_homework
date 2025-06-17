part of providers;

final class ApiProvider {
  final Dio _dio;
  final ErrorHandler _errorHandler;

  const ApiProvider({
    required Dio dio,
    required ErrorHandler errorHandler,
  })  : _dio = dio,
        _errorHandler = errorHandler;

  Future<RequestResultEntity> fetchCharacters(QueryPayLoad query) async {
    try {
      final Response<Map<String, dynamic>> response =
          await _dio.get<Map<String, dynamic>>(
        DataConstants.characterEndpoint,
        queryParameters: <String, dynamic>{
          DataConstants.pageQueryParameter: query.page,
          ...?query.queryParams,
        },
      );

      final Map<String, dynamic>? results = response.data;
      final List<CharacterEntity> characters =
          (results?[DataConstants.resultsKey] as List<dynamic>)
              .map((dynamic json) =>
                  CharacterEntity.fromJson(json as Map<String, dynamic>))
              .toList();

      final InfoEntity info = InfoEntity.fromJson(
          results?[DataConstants.infoKey] as Map<String, dynamic>);

      return RequestResultEntity(
        characters: characters,
        info: info,
      );
    } catch (e) {
      _errorHandler.handleError(e);
    }
  }
}
