part of 'exchange_rate_bloc.dart';

abstract class ExchangeRateEvent extends Equatable {
  const ExchangeRateEvent();

  @override
  List<Object?> get props => [];
}

class LoadBanks extends ExchangeRateEvent {}

class ChangePage extends ExchangeRateEvent {
  final int index;
  const ChangePage(this.index);

  @override
  List<Object> get props => [index];
}

class ChangeSortIndex extends ExchangeRateEvent {
  final int index;
  const ChangeSortIndex(this.index);

  @override
  List<Object> get props => [index];
}

class SearchQueryChanged extends ExchangeRateEvent {
  final String query;
  const SearchQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}
