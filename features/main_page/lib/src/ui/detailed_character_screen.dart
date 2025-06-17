import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import 'widgets/character_info_row.dart';

@RoutePage()
class DetailedCharacterScreen extends StatelessWidget {
  final Character character;

  const DetailedCharacterScreen({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle? titleStyle = Theme.of(context)
        .textTheme
        .headlineSmall
        ?.copyWith(fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Hero(
                tag: character.id,
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width / 4,
                  backgroundImage: NetworkImage(character.image),
                  backgroundColor: Colors.grey[200],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(character.name, style: titleStyle),
                  const SizedBox(height: 24),
                  CharacterInfoRow(
                    icon: Icons.info_outline,
                    label: LocaleKeys.main_page_status.watchTr(context),
                    value: character.status.localized(context),
                  ),
                  CharacterInfoRow(
                    icon: Icons.pets,
                    label: LocaleKeys.main_page_species.watchTr(context),
                    value: character.species.localized(context),
                  ),
                  if (character.gender.isNotEmpty)
                    CharacterInfoRow(
                      icon: Icons.person_outline,
                      label: LocaleKeys.main_page_gender.watchTr(context),
                      value: character.gender,
                    ),
                  CharacterInfoRow(
                    icon: Icons.public,
                    label: LocaleKeys.main_page_origin.watchTr(context),
                    value: character.origin.name,
                  ),
                  CharacterInfoRow(
                    icon: Icons.place_outlined,
                    label: LocaleKeys.main_page_location.watchTr(context),
                    value: character.location.name,
                  ),
                  CharacterInfoRow(
                    icon: Icons.movie_filter_outlined,
                    label: LocaleKeys.main_page_episode.watchTr(context),
                    value: '${character.episode.length}',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
