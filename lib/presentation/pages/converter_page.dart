import 'package:dollar_kursi/core/blocs/exchange_rate_bloc/exchange_rate_bloc.dart';
import 'package:dollar_kursi/core/models/exchange_rates_model.dart';
import 'package:dollar_kursi/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _resultController = TextEditingController();
  final FocusNode _amountFocus = FocusNode();

  bool _isUsdToUzs =
      true; // true: USD -> UZS (Bank Buy), false: UZS -> USD (Bank Sell)

  BankModel? _getBestBuyBank(List<BankModel> banks) {
    if (banks.isEmpty) return null;
    BankModel? bestBank;
    int maxBuy = 0;
    for (var b in banks) {
      if ((b.buy ?? 0) > maxBuy) {
        maxBuy = b.buy!;
        bestBank = b;
      }
    }
    return bestBank;
  }

  BankModel? _getBestSellBank(List<BankModel> banks) {
    if (banks.isEmpty) return null;
    BankModel? bestBank;
    int minSell = 999999999;
    bool found = false;
    for (var b in banks) {
      if ((b.sell ?? 0) > 0) {
        if ((b.sell ?? 0) < minSell) {
          minSell = b.sell!;
          bestBank = b;
          found = true;
        }
      }
    }
    return found ? bestBank : null;
  }

  void _calculate(int rate) {
    if (_amountController.text.isEmpty) {
      _resultController.text = '';
      return;
    }

    double amount =
        double.tryParse(_amountController.text.replaceAll(',', '.')) ?? 0;

    if (_isUsdToUzs) {
      // USD -> UZS: We sell USD to bank, bank BUYS. Result = amount * rate key
      _resultController.text = (amount * rate).toStringAsFixed(0);
    } else {
      // UZS -> USD: We buy USD from bank, bank SELLS. Result = amount / rate key
      if (rate == 0) {
        _resultController.text = "0";
        return;
      }
      _resultController.text = (amount / rate).toStringAsFixed(2);
    }
  }

  void _onSwap() {
    setState(() {
      _isUsdToUzs = !_isUsdToUzs;
      _amountController.clear();
      _resultController.clear();
      _amountFocus.unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExchangeRateBloc, ExchangeRateState>(
      builder: (context, state) {
        // Determine the active bank and rate based on direction
        final bestBuyBank = _getBestBuyBank(state.allBanks);
        final bestSellBank = _getBestSellBank(state.allBanks);

        final activeBank = _isUsdToUzs ? bestBuyBank : bestSellBank;
        final activeRate =
            _isUsdToUzs ? (bestBuyBank?.buy ?? 0) : (bestSellBank?.sell ?? 0);

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            title: const Text(
              "Kalkulyator",
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Top Card (Input)
                _buildCard(
                  title: _isUsdToUzs ? "USD (Sotish)" : "UZS (Sotib olish)",
                  rate: activeRate,
                  bankName: activeBank?.bank?.name,
                  bankImage: activeBank?.bank?.image,
                  controller: _amountController,
                  focusNode: _amountFocus,
                  onChanged: (v) => _calculate(activeRate),
                  icon: _isUsdToUzs ? Icons.attach_money : Icons.money,
                  isReadOnly: false,
                  isInt: !_isUsdToUzs, // Input UZS is Int, USD is double
                ),

                const SizedBox(height: 20),

                GestureDetector(
                  onTap: _onSwap,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primarySurface,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.swap_vert_rounded,
                      color: AppColors.primary,
                      size: 32,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Bottom Card (Result)
                _buildCard(
                  title: _isUsdToUzs ? "UZS (Olasiiz)" : "USD (Olasiz)",
                  rate: activeRate,
                  // Show bank info only on the top card or both? Usually top card dictates the rate source.
                  // Let's hide it for result to keep it clean or show same?
                  // Requirement: "show which bank has this rate".
                  // It logicly belongs to the conversion execution. Let's hide on result to reduce noise,
                  // or show it to confirm "this result is from X bank".
                  // Let's stick to showing it on top card (Source of rate).
                  bankName: null,
                  bankImage: null,
                  controller: _resultController,
                  focusNode: FocusNode(), // Dummy
                  onChanged: (v) {}, // Read only
                  icon: _isUsdToUzs ? Icons.money : Icons.attach_money,
                  isReadOnly: true,
                ),

                const Spacer(),
                const Text(
                  "Hisob kitoblar eng foydali kurslar asosida amalga oshiriladi",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCard({
    required String title,
    required int rate,
    String? bankName,
    String? bankImage,
    required TextEditingController controller,
    required FocusNode focusNode,
    required Function(String) onChanged,
    required IconData icon,
    bool isReadOnly = false,
    bool isInt = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primarySurface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (bankName != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Eng yaxshi kurs: $rate so'm",
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (bankImage != null)
                            Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.network(
                                  bankImage,
                                  width: 16,
                                  height: 16,
                                  errorBuilder:
                                      (context, error, stackTrace) =>
                                          const SizedBox(),
                                ),
                              ),
                            ),
                          Text(
                            bankName,
                            style: TextStyle(
                              color: AppColors.textSecondary.withOpacity(0.8),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: controller,
            focusNode: focusNode,
            onChanged: onChanged,
            readOnly: isReadOnly,
            keyboardType: TextInputType.numberWithOptions(decimal: !isInt),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(isInt ? r'[0-9]' : r'[0-9,.]'),
              ),
            ],
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: "0",
              hintStyle: TextStyle(
                color: AppColors.textSecondary.withOpacity(0.5),
              ),
              border: InputBorder.none,
              prefixIcon: Icon(icon, color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
