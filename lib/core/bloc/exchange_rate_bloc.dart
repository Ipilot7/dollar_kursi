import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dollar_kursi/core/models/exchange_rates_model.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

part 'exchange_rate_event.dart';
part 'exchange_rate_state.dart';

class ExchangeRateBloc extends Bloc<ExchangeRateEvent, ExchangeRateState> {
  ExchangeRateBloc() : super(ExchangeRateState()) {
    on<LoadBanks>(_onLoadBanks);
    on<ChangePage>(_onChangePage);
    on<ChangeSortIndex>(_onChangeSortIndex);
    on<SearchQueryChanged>(_onSearchQueryChanged);
  }

  void _onLoadBanks(LoadBanks event, Emitter<ExchangeRateState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final response = await getBanks();
      List<BankModel> list = response.data ?? [];
      final date = formatDate(response.lastDate ?? '');
      emit(state.copyWith(banks: list, isLoading: false, lastUpdate: date));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      log('Ошибка загрузки курсов валют: $e');
    }
  }

  Future<ExchangeRatesModel> getBanks() async {
    const String baseUrl = "http://currency.bildung.uz/exchange/?format=json";

    final Response res = await get(Uri.parse(baseUrl));

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return ExchangeRatesModel.fromJson(data);
    } else {
      throw Exception('Failed to load exchange rates: ${res.statusCode}');
    }
  }

  String formatDate(String input) {
    final date = DateTime.parse(input);
    final formatter = DateFormat('dd.MM.yyyy (HH:mm)');
    return 'Bugun - ${formatter.format(date)}';
  }

  void _onChangePage(ChangePage event, Emitter<ExchangeRateState> emit) {
    emit(state.copyWith(selectedIndex: event.index));
  }

  void _onChangeSortIndex(
    ChangeSortIndex event,
    Emitter<ExchangeRateState> emit,
  ) {
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
