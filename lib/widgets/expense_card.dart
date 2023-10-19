import 'package:flutter/material.dart';
import 'package:spese_condivise/models/expense.dart';
import 'package:spese_condivise/models/expense.dart';

class ExpenseCard extends StatefulWidget {
  const ExpenseCard({super.key, required this.expense});

  final Expense expense;

  @override
  State<ExpenseCard> createState() => _ExpenseCardState();
}

class _ExpenseCardState extends State<ExpenseCard> {
  // final expense = Expense(
  //   title: "Latte e acqua e pane",
  //   date: DateTime.now(),
  //   category: Category.Affitto,
  //   payer: Payer.Mancio,
  //   cost: 12,
  // );
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      height: 90,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: Colors.purple,
              width: 2,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple, Color.fromARGB(255, 89, 38, 98)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 180,
                            child: Text(
                              widget.expense.title,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Text(
                            widget.expense.formattedDate,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          // SizedBox(height: 2),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text(
                              '${widget.expense.cost.toString()} €',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Text(
                            widget.expense.payer.name[0].toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.symmetric(
                                vertical:
                                    BorderSide(color: Colors.white, width: 2))),
                        width: 70,
                        child: Icon(
                          size: 40,
                          categoryIcons[widget.expense.category],
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
