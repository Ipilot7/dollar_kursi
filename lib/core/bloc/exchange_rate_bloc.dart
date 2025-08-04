import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dollar_kursi/core/models/exchange_rates_model.dart';
import 'package:dollar_kursi/core/services/bank_service.dart';
import 'package:equatable/equatable.dart';

part 'exchange_rate_event.dart';
part 'exchange_rate_state.dart';

class ExchangeRateBloc extends Bloc<ExchangeRateEvent, ExchangeRateState> {
  ExchangeRateBloc() : super( ExchangeRateState()) {
    on<LoadBanks>(_onLoadBanks);
    on<ChangePage>(_onChangePage);
    on<ChangeSortIndex>(_onChangeSortIndex);
    on<SearchQueryChanged>(_onSearchQueryChanged);
  }

 void _onLoadBanks(LoadBanks event, Emitter<ExchangeRateState> emit) async {
  emit(state.copyWith(isLoading: true));
  try {
    final response = await BankService.getBanks();
    List<BankModel> list = response.data ?? [];

    emit(state.copyWith(banks: list, isLoading: false));
  } catch (e) {
    emit(state.copyWith(isLoading: false));
    log('Ошибка загрузки курсов валют: $e');
  }
}


  void _onChangePage(ChangePage event, Emitter<ExchangeRateState> emit) {
    emit(state.copyWith(selectedIndex: event.index));
  }

  void _onChangeSortIndex(ChangeSortIndex event, Emitter<ExchangeRateState> emit) {
    List<BankModel> sorted = List.from(state.banks);

    switch (event.index) {
      case 0:
        sorted.sort((a, b) => a.bank!.name!.compareTo(b.bank!.name!));
        break;
      case 1:
        sorted.sort((a, b) => b.buy!.compareTo(a.buy!));
        break;
      case 2:
        sorted.sort((a, b) => a.sell!.compareTo(b.sell!));
        break;
    }

    emit(state.copyWith(sortIndex: event.index, banks: sorted));
  }

  void _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<ExchangeRateState> emit,
  ) {
    emit(state.copyWith(searchQuery: event.query));
  }
}
