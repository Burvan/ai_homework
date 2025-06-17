import 'package:json_annotation/json_annotation.dart';

part 'info_entity.g.dart';

@JsonSerializable()
final class InfoEntity {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  const InfoEntity({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });

  factory InfoEntity.fromJson(Map<String, dynamic> json) =>
      _$InfoEntityFromJson(json);

  Map<String, dynamic> toJson() => _$InfoEntityToJson(this);
}
