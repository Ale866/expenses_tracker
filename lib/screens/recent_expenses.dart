import 'package:flutter/material.dart';
import 'package:spese_condivise/models/expense.dart';
import 'package:spese_condivise/widgets/expense_card.dart';
import 'package:spese_condivise/widgets/new_add_expense.dart';

class RecentExpenses extends StatefulWidget {
  const RecentExpenses({super.key, required this.lastExpenses});

  final List<Expense> lastExpenses;

  @override
  State<RecentExpenses> createState() => _RecentExpensesState();
}

class _RecentExpensesState extends State<RecentExpenses> {
  void _openModal() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpenseModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var expense in widget.lastExpenses)
            ExpenseCard(expense: expense),
          Expanded(
            child: Container(
              height: double.infinity,
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  _openModal();
                },
                child: Icon(Icons.add, color: Colors.white),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(12),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.red,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
