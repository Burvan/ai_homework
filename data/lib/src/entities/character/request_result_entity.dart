import 'character_entity.dart';
import 'info_entity.dart';

final class RequestResultEntity {
  final List<CharacterEntity> characters;
  final InfoEntity info;

  const RequestResultEntity({
    required this.characters,
    required this.info,
  });
}
