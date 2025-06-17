part of models;

class QueryPayLoad {
  final int page;
  final Map<String, dynamic>? queryParams;

  QueryPayLoad({
    required this.page,
    this.queryParams,
  });
}
