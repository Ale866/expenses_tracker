import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:spese_condivise/providers/filters_provider.dart';

class ExpensesFilters extends ConsumerStatefulWidget {
  const ExpensesFilters({super.key});

  @override
  ConsumerState<ExpensesFilters> createState() => _ExpensesFiltersState();
}

class _ExpensesFiltersState extends ConsumerState<ExpensesFilters> {
  DateTime? _startDate = null;
  DateTime? _endDate = null;

  @override
  void initState() {
    super.initState();
    final filters = ref.read(filtersProvider);
    _startDate = filters['fromDate'] != 'all' ? filters['fromDate'] : null;
    _endDate = filters['toDate'] != 'all' ? filters['fromDate'] : null;
  }

  void _presentDatePicker(date) {
    final filtersNotifier = ref.watch(filtersProvider.notifier);

    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate == null) {
        return;
      }

      setState(() {
        date == 'start' ? _startDate = selectedDate : _endDate = selectedDate;
        if (_startDate != null && _endDate != null) {
          if (_startDate!.isAfter(_endDate!)) {
            final temp = _startDate;
            _startDate = _endDate;
            _endDate = temp;
          }
          filtersNotifier.setDateFilters(_startDate!, _endDate!);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          TextButton(
            child: Icon(Icons.calendar_month_outlined),
            onPressed: () {
              _presentDatePicker('start');
            },
          ),
          Text('From: '),
          Expanded(
            child: Text(
              _startDate == null
                  ? ' '
                  : DateFormat('dd/MM/yy').format(_startDate!),
            ),
          ),
          TextButton(
            child: Icon(Icons.calendar_month_outlined),
            onPressed: () {
              _presentDatePicker('end');
            },
          ),
          Text('To: '),
          Expanded(
            child: Text(
              _endDate == null ? ' ' : DateFormat('dd/MM/yy').format(_endDate!),
            ),
          ),
        ],
      ),
    );
  }
}
