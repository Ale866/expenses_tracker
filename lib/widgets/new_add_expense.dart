import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';

class NewExpenseModal extends StatefulWidget {
  @override
  _NewExpenseModalState createState() => _NewExpenseModalState();
}

class _NewExpenseModalState extends State<NewExpenseModal> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  Category _selectedCategory = Category.Affitto;
  Payer _selectedPayer = Payer.Mancio;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty ||
        enteredAmount <= 0 ||
        _selectedCategory == null ||
        _selectedDate == null) {
      return;
    }

    final newExpense = Expense(
      title: enteredTitle,
      cost: enteredAmount,
      category: _selectedCategory,
      payer: _selectedPayer,
      date: _selectedDate,
    );

    Navigator.of(context).pop(newExpense);
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitData(),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 100,
                          child: Expanded(
                            child: DropdownButton<Category>(
                              value: _selectedCategory,
                              onChanged: (Category? newValue) {
                                setState(() {
                                  _selectedCategory = newValue!;
                                });
                              },
                              items: Category.values
                                  .map<DropdownMenuItem<Category>>(
                                      (Category value) {
                                return DropdownMenuItem<Category>(
                                  value: value,
                                  child: Text(value.toString().split('.').last),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          height: 50,
                          width: 100,
                          child: Expanded(
                            child: DropdownButton<Payer>(
                              value: _selectedPayer,
                              onChanged: (Payer? newValue) {
                                setState(() {
                                  _selectedPayer = newValue!;
                                });
                              },
                              items: Payer.values
                                  .map<DropdownMenuItem<Payer>>((Payer value) {
                                return DropdownMenuItem<Payer>(
                                  value: value,
                                  child: Text(value.toString().split('.').last),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      child: Icon(Icons.calendar_month_outlined),
                      onPressed: _presentDatePicker,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Picked Date: ${DateFormat('dd / MMM / yy').format(_selectedDate)}',
                    ),
                  ),
                ],
              ),
              TextButton(
                child: Text('Add Expense'),
                onPressed: () {
                  _submitData();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
