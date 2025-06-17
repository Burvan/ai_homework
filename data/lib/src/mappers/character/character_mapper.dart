part of mappers;

final class CharacterMapper extends Mapper<CharacterEntity, domain.Character> {
  @override
  domain.Character fromEntity(CharacterEntity entity) {
    return domain.Character(
      id: entity.id,
      name: entity.name,
      status: domain.Status.values.firstWhere(
        (s) => s.name.toLowerCase() == entity.status.toLowerCase(),
        orElse: () => domain.Status.unknown,
      ),
      species: domain.Species.values.firstWhere(
        (s) => s.name.toLowerCase() == entity.species.toLowerCase(),
        orElse: () => domain.Species.unknown,
      ),
      type: entity.type,
      gender: entity.gender,
      origin: LocationMapper().fromEntity(entity.origin),
      location: LocationMapper().fromEntity(entity.location),
      image: entity.image,
      episode: entity.episode,
      url: entity.url,
      created: entity.created,
    );
  }

  @override
  CharacterEntity toEntity(domain.Character item) {
    return CharacterEntity(
      id: item.id,
      name: item.name,
      status: item.status.name,
      species: item.species.name,
      type: item.type,
      gender: item.gender,
      origin: LocationMapper().toEntity(item.origin),
      location: LocationMapper().toEntity(item.location),
      image: item.image,
      episode: item.episode,
      url: item.url,
      created: item.created,
    );
  }
}
