import 'package:flutter/material.dart';
import 'package:spese_condivise/models/expense.dart';
import 'package:spese_condivise/providers/expenses_provider.dart';
import 'package:spese_condivise/widgets/expense_card.dart';

class AllExpenses extends StatefulWidget {
  const AllExpenses({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  State<AllExpenses> createState() => _AllExpensesState();
}

class _AllExpensesState extends State<AllExpenses> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 18),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 50,
            color: Colors.white,
            child: Center(
              child: Text(
                'Filtri qui',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: ListView.builder(
                itemCount: widget.expenses.length,
                itemBuilder: (ctx, i) => Dismissible(
                    key: ValueKey(widget.expenses[i]),
                    background: Container(
                      color: Colors.red,
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                    ),
                    onDismissed: (dir) {
                      removeExpense(widget.expenses[i]);
                    },
                    child: ExpenseCard(expense: widget.expenses[i])),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
