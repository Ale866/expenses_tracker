import 'package:flutter/material.dart';
import 'package:spese_condivise/models/expense.dart';

class ExpenseCard extends StatefulWidget {
  const ExpenseCard({super.key});

  @override
  State<ExpenseCard> createState() => _ExpenseCardState();
}

class _ExpenseCardState extends State<ExpenseCard> {
  final expense = Expense(
    title: "spesa prova",
    date: DateTime.now(),
    category: Category.Affitto,
    payer: Payer.Mancio,
    cost: 25,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      height: 90,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Card(
          color: Colors.blue,
          // child: Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(expense.title),
                  Text('${expense.cost.toString()} €')
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(expense.formattedDate),
                  Text(expense.category.name),
                  Text(expense.payer.name),
                ],
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }
}
