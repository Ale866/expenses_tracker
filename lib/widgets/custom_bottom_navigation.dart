import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spese_condivise/models/expense.dart';
import 'package:spese_condivise/providers/expenses_provider.dart';
import 'package:spese_condivise/screens/all_expenses.dart';
import 'package:spese_condivise/screens/expenses_chart.dart';
import 'package:spese_condivise/screens/recent_expenses.dart';

class CustomBottomNavigation extends ConsumerStatefulWidget {
  const CustomBottomNavigation({super.key});

  @override
  ConsumerState<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends ConsumerState<CustomBottomNavigation> {
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _pages = <Widget>[
    AllExpenses(),
    RecentExpenses(),
    ExpensesChart()
  ];

  static const List<String> _pagesTitles = <String>[
    "Tutte le spese",
    "Spese recenti",
    "Grafici"
  ];

  @override
  Widget build(BuildContext context) {
    List<Expense>? expenses = ref.watch(expensesProvider).value;
    expenses ??= [];

    return Scaffold(
      appBar: AppBar(
        title: Text(_pagesTitles.elementAt(_selectedIndex)),
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.euro_sharp),
            label: 'Chart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Charts',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
