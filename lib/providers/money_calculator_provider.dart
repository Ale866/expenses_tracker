import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spese_condivise/models/expense.dart';
import 'package:spese_condivise/providers/expenses_provider.dart';

Map<Payer, double> kInitialMoneyPayed = {
  Payer.Mancio: 0,
  Payer.Sespo: 0,
};

final moneyPayedProvider = Provider.autoDispose((ref) {
  final expenses = ref.watch(expensesProvider).value;

  ref.keepAlive();

  if (expenses == null) {
    return {};
  }

  var moneyMap = {};

  for (var key in kInitialMoneyPayed.keys) {
    moneyMap[key] = expenses!
        .where((element) => element.payer == kInitialMoneyPayed[key])
        .fold(0.0, (value, element) => value + element.cost);
  }

  return moneyMap;
});
