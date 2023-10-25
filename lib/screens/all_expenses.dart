import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spese_condivise/models/expense.dart';
import 'package:spese_condivise/providers/expenses_provider.dart';
import 'package:spese_condivise/providers/filters_provider.dart';
import 'package:spese_condivise/widgets/expense_card.dart';
import 'package:spese_condivise/widgets/expenses_filters.dart';

class AllExpenses extends ConsumerWidget {
  const AllExpenses({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.only(top: 18),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 120,
            color: Colors.white,
            child: Center(
              child: ExpensesFilters(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (ctx, i) => Dismissible(
                  key: ValueKey(expenses[i]),
                  background: Container(
                    color: Colors.red,
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                  ),
                  onDismissed: (dir) {
                    final removedExpense = expenses[i];
                    removeExpense(removedExpense);
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Expense removed"),
                        action: SnackBarAction(
                          label: "Undo",
                          onPressed: () {
                            addExpense(removedExpense);
                          },
                        ),
                      ),
                    );
                  },
                  child: ExpenseCard(expense: expenses[i]),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              ref.read(filtersProvider.notifier).resetFilters();
            },
            child: Text("Cancella filtri"),
          )
        ],
      ),
    );
  }
}
