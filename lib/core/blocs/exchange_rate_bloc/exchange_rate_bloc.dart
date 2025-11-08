import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dollar_kursi/core/models/device_model.dart';
import 'package:dollar_kursi/core/models/exchange_rates_model.dart';
import 'package:dollar_kursi/di/di.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'exchange_rate_event.dart';
part 'exchange_rate_state.dart';

class ExchangeRateBloc extends Bloc<ExchangeRateEvent, ExchangeRateState> {
  ExchangeRateBloc() : super(ExchangeRateState()) {
    on<LoadBanks>(_onLoadBanks);
    on<ChangePage>(_onChangePage);
    on<ChangeSortIndex>(_onChangeSortIndex);
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<SetDeivceAndFCM>(_setDeivceAndFCM);
  }

  // ---------- helpers ----------
  List<BankModel> _applySearch(List<BankModel> source, String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return List<BankModel>.from(source);

    return source.where((b) {
      final name = (b.bank?.name ?? '').toLowerCase();
      // при желании можно добавить и другие поля в фильтр
      return name.contains(q);
    }).toList();
  }

  int _cmpNumDesc(num? a, num? b) => (b ?? 0).compareTo(a ?? 0);
  int _cmpNumAsc(num? a, num? b) => (a ?? 0).compareTo(b ?? 0);

  List<BankModel> _applySort(List<BankModel> list, int sortIndex) {
    final sorted = List<BankModel>.from(list);
    switch (sortIndex) {
      case 0: // по названию банка A->Z
        sorted.sort(
          (a, b) => (a.bank?.name ?? '').compareTo(b.bank?.name ?? ''),
        );
        break;
      case 1: // buy по убыванию
        sorted.sort((a, b) => _cmpNumDesc(a.buy, b.buy));
        break;
      case 2: // sell по возрастанию
        sorted.sort((a, b) => _cmpNumAsc(a.sell, b.sell));
        break;
    }
    return sorted;
  }

  void _rebuildView(
    Emitter<ExchangeRateState> emit, {
    List<BankModel>? newAll,
  }) {
    final base = newAll ?? state.allBanks;
    final filtered = _applySearch(base, state.searchQuery);
    final sorted = _applySort(filtered, state.sortIndex);
    emit(state.copyWith(allBanks: newAll ?? state.allBanks, banks: sorted));
  }
  // ---------- /helpers ----------

  void _onLoadBanks(LoadBanks event, Emitter<ExchangeRateState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final response = await getBanks();
      final list = response.data ?? <BankModel>[];
      final date = formatDate(response.lastDate ?? '');

      // сохраняем в allBanks, видимую витрину пересобираем с поиском/сортировкой
      emit(state.copyWith(isLoading: false, lastUpdate: date, allBanks: list));
      _rebuildView(emit); // banks = filtered+sorted
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

  Future<void> _setDeivceAndFCM(SetDeivceAndFCM event, emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await device();

      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      log('Ошибка выгрузки токена: $e');
    }
  }

  Future<DeviceModel> device() async {
    final String? deviceId = await getDeviceId();
    final String? fvmToken = sl<SharedPreferences>().getString('fcm_token');
    const String baseUrl = "http://currency.bildung.uz/devices/";
    final Response res = await post(
      Uri.parse(baseUrl),
      body: {"device_id": deviceId, "fcm_token": fvmToken},
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      final data = jsonDecode(res.body);
      return DeviceModel.fromJson(data);
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
    // сортируем поверх текущего фильтра
    final filtered = _applySearch(state.allBanks, state.searchQuery);
    final sorted = _applySort(filtered, event.index);
    emit(state.copyWith(sortIndex: event.index, banks: sorted));
  }

  void _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<ExchangeRateState> emit,
  ) {
    // фильтруем по исходному списку, потом применяем активную сортировку
    final filtered = _applySearch(state.allBanks, event.query);
    final sorted = _applySort(filtered, state.sortIndex);
    emit(state.copyWith(searchQuery: event.query, banks: sorted));
  }

  Future<String?> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      return info
          .id; // Уникальный для устройства, но не гарантированно постоянный
    } else if (Platform.isIOS) {
      final info = await deviceInfo.iosInfo;
      return info
          .identifierForVendor; // Apple выдаёт уникальный ID для разработчика
    }
    return null;
  }
}
