import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class CharacterTile extends StatelessWidget {
  final Character character;
  final VoidCallback onTap;

  const CharacterTile({
    Key? key,
    required this.character,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(16),
      color: AppColors.gentlyGreen,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Hero(
                  tag: character.id,
                  child: Image.network(
                    character.image,
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.width / 5,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      character.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.circle,
                          color: character.status.color,
                          size: 10,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          character.status.localized(context),
                          style: const TextStyle(
                            color: AppColors.darkGrey,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          character.species.localized(context),
                          style: const TextStyle(
                            color: AppColors.darkGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: AppColors.darkGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
