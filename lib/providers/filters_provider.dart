import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spese_condivise/models/expense.dart';
import 'package:spese_condivise/providers/expenses_provider.dart';


Map<String,dynamic> kInitialFilters = {
  "fromDate" : "all",
  "toDate" : "all",
  "category" : {
     Category.Affitto: true,
      Category.Bollette: true,
      Category.Istruzione: true,
      Category.Spesa: true,
      Category.Svago: true,
      Category.Trasporti: true,
      Category.Altro: true,
  },
};

class FiltersNotifier extends StateNotifier<Map<String, dynamic>> {
  FiltersNotifier() : super(kInitialFilters);

  void setFilters(Map<String,dynamic> filters) {
    state = filters;
  }

  void setFilter(String filter, DateTime isActive) { 
    state = {...state, filter: isActive};
  }  
  void setCategoryFilter(Category cat, bool isActive) { 
    Map<Category,bool> categoryFilters = state["category"];
    state = {...state, "category": {...categoryFilters, cat: isActive}};
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<String, dynamic>>(
  (ref) => FiltersNotifier(),
);

final filteredExpenseProvider = Provider.autoDispose((ref) {
  final filters = ref.watch(filtersProvider);
  final expenses = ref.watch(expensesProvider).value;
  ref.keepAlive();

  if(expenses == null){
    return [];
  }

  return expenses.where((expense) {
    if(filters["fromDate"] != "all" && filters["toDate"] != "all"){
      if(expense.date.isBefore(filters["fromDate"]) || expense.date.isAfter(filters["toDate"])) return false;
    }
    final expenseCategory = expense.category;
    return filters["category"][expenseCategory];
  }).toList();
});