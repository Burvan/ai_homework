import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

final class Filters extends StatelessWidget {
  final Status? selectedStatus;
  final Species? selectedSpecies;
  final ValueChanged<Status?> onStatusChanged;
  final ValueChanged<Species?> onSpeciesChanged;

  const Filters({
    required this.selectedStatus,
    required this.selectedSpecies,
    required this.onStatusChanged,
    required this.onSpeciesChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: DropdownButton2<Status?>(
              isExpanded: true,
              underline: const SizedBox.shrink(),
              value: selectedStatus,
              items: <DropdownMenuItem<Status?>>[
                DropdownMenuItem<Status?>(
                  child: Text(
                    LocaleKeys.main_page_anyStatus.watchTr(context),
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                ...Status.values.map(
                  (Status status) => DropdownMenuItem<Status?>(
                    value: status,
                    child: Text(status.localized(context)),
                  ),
                ),
              ],
              onChanged: onStatusChanged,
              buttonStyleData: ButtonStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.black),
                  color: Colors.white,
                ),
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Theme.of(context).cardColor,
                ),
                padding: const EdgeInsets.only(bottom: 8),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Species dropdown
          Expanded(
            child: DropdownButton2<Species?>(
              isExpanded: true,
              underline: const SizedBox.shrink(),
              value: selectedSpecies,
              items: <DropdownMenuItem<Species?>>[
                DropdownMenuItem<Species?>(
                  child: Text(
                    LocaleKeys.main_page_anySpecies.watchTr(context),
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                ...Species.values.map(
                  (Species species) => DropdownMenuItem<Species?>(
                    value: species,
                    child: Text(
                      species.localized(context),
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
              onChanged: onSpeciesChanged,
              buttonStyleData: ButtonStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.black),
                  color: Colors.white,
                ),
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.only(bottom: 8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
