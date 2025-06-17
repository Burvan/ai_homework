import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../../../core.dart';

extension SpeciesExtension on Species {
  String localized(BuildContext context) {
    return switch (this) {
      Species.human => LocaleKeys.main_page_human.watchTr(context),
      Species.alien => LocaleKeys.main_page_alien.watchTr(context),
      Species.humanoid => LocaleKeys.main_page_humanoid.watchTr(context),
      Species.poopybutthole =>
        LocaleKeys.main_page_poopybutthole.watchTr(context),
      Species.mythological =>
        LocaleKeys.main_page_mythological.watchTr(context),
      Species.animal => LocaleKeys.main_page_animal.watchTr(context),
      Species.robot => LocaleKeys.main_page_robot.watchTr(context),
      Species.cronenberg => LocaleKeys.main_page_cronenberg.watchTr(context),
      Species.disease => LocaleKeys.main_page_disease.watchTr(context),
      Species.unknown => LocaleKeys.main_page_unknown.watchTr(context),
    };
  }
}
