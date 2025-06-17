import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../../../core.dart';

extension StatusExtension on Status {
  Color get color {
    switch (this) {
      case Status.alive:
        return AppColors.green;
      case Status.dead:
        return AppColors.red;
      case Status.unknown:
        return AppColors.black;
    }
  }

  String localized(BuildContext context) => switch (this) {
        Status.alive => LocaleKeys.main_page_alive.watchTr(context),
        Status.dead => LocaleKeys.main_page_dead.watchTr(context),
        Status.unknown => LocaleKeys.main_page_unknown.watchTr(context),
      };
}
