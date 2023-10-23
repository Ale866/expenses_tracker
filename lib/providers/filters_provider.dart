import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spese_condivise/models/expense.dart';
import 'package:spese_condivise/providers/expenses_provider.dart';

Map<String, dynamic> kInitialFilters = {
  "startDate": null,
  "endDate": null,
  "category": {
    Category.Affitto: false,
    Category.Bollette: false,
    Category.Istruzione: false,
    Category.Spesa: false,
    Category.Svago: false,
    Category.Trasporti: false,
    Category.Altro: false,
  },
};

class FiltersNotifier extends StateNotifier<Map<String, dynamic>> {
  FiltersNotifier() : super(kInitialFilters);

  void setFilters(Map<String, dynamic> filters) {
    state = filters;
  }

  void setDateFilters(DateTime? startDate, DateTime? endDate) {
    state = {...state, 'startDate': startDate, 'endDate': endDate};
  }

  void setDateFilter(String arg, DateTime date) {
    state = {...state, arg: date};
  }

  void setCategoryFilter(Category cat, bool isActive) {
    Map<Category, bool> categoryFilters = state["category"];
    state = {
      ...state,
      "category": {...categoryFilters, cat: isActive}
    };
  }

  void resetFilters() {
    state = kInitialFilters;
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<String, dynamic>>(
  (ref) => FiltersNotifier(),
);

final filteredExpenseProvider = Provider.autoDispose<List<Expense>>((ref) {
  final filters = ref.watch(filtersProvider);
  final expenses = ref.watch(expensesProvider).value;
  ref.keepAlive();

  if (expenses == null) {
    return [];
  }

  return expenses.where((expense) {
    if (filters["startDate"] != null && filters["endDate"] != null) {
      if (expense.date.isBefore(filters["startDate"]) ||
          expense.date.isAfter(filters["endDate"])) return false;
    }
    final expenseCategory = expense.category;
    if (filters["category"].values.every((element) => element == false))
      return true;
    return filters["category"][expenseCategory];
  }).toList();
});
