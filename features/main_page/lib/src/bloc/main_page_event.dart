part of 'main_page_bloc.dart';

abstract class MainPageEvent {
  const MainPageEvent();
}

final class Init extends MainPageEvent {
  const Init();
}

final class LoadMore extends MainPageEvent {
  const LoadMore();
}

final class ChangeStatusFilter extends MainPageEvent {
  final Status? status;

  const ChangeStatusFilter(this.status);
}

final class ChangeSpeciesFilter extends MainPageEvent {
  final Species? species;

  const ChangeSpeciesFilter(this.species);
}

final class NavigateToDetails extends MainPageEvent {
  final Character character;

  const NavigateToDetails({required this.character});
}
