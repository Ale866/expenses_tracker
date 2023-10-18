import 'package:flutter/material.dart';
import 'package:spese_condivise/widgets/expense_card.dart';
import 'package:spese_condivise/widgets/new_add_expense.dart';

class RecentExpenses extends StatefulWidget {
  const RecentExpenses({super.key});

  @override
  State<RecentExpenses> createState() => _RecentExpensesState();
}

class _RecentExpensesState extends State<RecentExpenses> {
  List<int> expensesDisplayNum = [1, 2, 3, 4, 5];

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
          for (var i in expensesDisplayNum) ExpenseCard(),
          Expanded(
            child: Container(
                height: double.infinity,
                alignment: Alignment.center,
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
                )),
          ),
        ],
      ),
    );
  }
}
