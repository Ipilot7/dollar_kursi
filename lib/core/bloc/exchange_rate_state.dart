part of 'exchange_rate_bloc.dart';
class ExchangeRateState {
  final int selectedIndex;
  final int sortIndex;
  final String searchQuery;
  final List<BankModel> banks;
  final bool isLoading;

  ExchangeRateState({
    this.selectedIndex = 0,
    this.sortIndex = 0,
    this.searchQuery = '',
    this.banks = const [],
    this.isLoading = false,
  });

  ExchangeRateState copyWith({
    int? selectedIndex,
    int? sortIndex,
    String? searchQuery,
    List<BankModel>? banks,
    bool? isLoading,
  }) {
    return ExchangeRateState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      sortIndex: sortIndex ?? this.sortIndex,
      searchQuery: searchQuery ?? this.searchQuery,
      banks: banks ?? this.banks,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
